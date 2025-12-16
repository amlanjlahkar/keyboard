local manipulator = import 'helpers/manipulator.libsonnet';
local util = import 'helpers/util.libsonnet';

local mp = manipulator.call;
local hyper = util.key_hyper;

local launch_prefix = 'p';
local param_simthreshold = { 'basic.simultaneous_threshold_milliseconds': 500 };

{
  title: 'Launch Applications',
  rules: [
    {
      description: 'Launch: Browser',
      manipulators: [
        mp({
          p: param_simthreshold,
          f: { s: [launch_prefix, 'w'], so: { key_down_order: 'strict' }, m: hyper(true).m },
          t: { sc: 'export MOZ_DISABLE_SAFE_MODE_KEY=1; open ~/Applications/Home\\ Manager\\ Apps/Firefox.app' },
        }),
      ],
    },
    {
      description: 'Launch: Terminal',
      manipulators: [
        mp({
          p: param_simthreshold,
          f: { s: [launch_prefix, 'x'], so: { key_down_order: 'strict' }, m: hyper(true).m },
          t: { sc: 'open ~/Applications/Home\\ Manager\\ Apps/kitty.app' },
        }),
      ],
    },
    {
      description: 'Launch: Music',
      manipulators: [
        mp({
          p: param_simthreshold,
          f: { s: [launch_prefix, 'm'], so: { key_down_order: 'strict' }, m: hyper(true).m },
          t: { sc: 'open /System/Applications/Music.app' },
        }),
      ],
    },
  ],
}

// vim:ai:
