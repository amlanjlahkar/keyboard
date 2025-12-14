brewfile := Brewfile
brew_check_bundle := bundle check --file $(brewfile)
brew_install_bundle := bundle install --file $(brewfile)
generator_dir := generators
generators := $(wildcard $(generator_dir)/*.jsonnet)
target_dir := assets/complex_modifications
targets := $(patsubst $(generator_dir)/%.jsonnet, %.json, $(generators))
config := $(HOME)/.config/karabiner

SHELL := /bin/bash

.PHONY: all init check generate
.SILENT: init check generate

all: generate

init: check
ifeq ($(PWD), $(config))
else
	if [[ ! -d $(config) ]]; then\
		echo "Linking karabiner config to ~/.config/karabiner";\
		command ln -s $(PWD) $(config);\
	fi

	if [[ -d "$(config)" ]] && [[ ! -L "$(config)" ]]; then\
		echo "Existing karabiner config found inside ~/.config. Backup saved at ~/.config/karabiner_backup";\
		command mv $(config) $(config)_backup;\
		echo "Linking karabiner config to ~/.config/karabiner";\
		command ln -s $(PWD) $(config);\
	elif [[ -L "$(config)" ]] && [[ ! "$(shell readlink $(config))" -ef "$(PWD)" ]]; then\
		printf '\n%s\n%s\n' "Existing karabiner config found inside ~/.config."\
		"Not making any changes because it's a symlink. Remove or backup manually then proceed.";\
	fi
endif

check:
	read -p "Install dependencies with brew? [Y/n] " choice;\
	case "$$choice" in\
		Y | y | yes | Yes | YES)\
			brew $(brew_check_bundle) 1>/dev/null || (\
				echo "Installing missing dependencies...";\
				brew $(brew_install_bundle);\
			);\
			;;\
		*)\
			exit 0;\
			;;\
	esac

generate: $(targets)
	echo "All targets are up-to-date"

$(targets): %.json: %.jsonnet

%.jsonnet:
	$(eval target := $(target_dir)/$(@:.jsonnet=.json))
	$(eval generator := $(generator_dir)/$@)

	@if [[ "$(generator)" -nt "$(target)" ]]; then\
		rm -rf "$(target)";\
		echo "Generating target for $@";\
		jsonnet "$(generator)" -o "$(target)";\
		karabiner_cli --lint-complex-modifications "$(target)";\
	fi

