{ ... }:
{
  spawn-at-startup = [
    { command = [ "waybar" ]; }
    { command = [ "hypridle" ]; }
    {
      command = [
        "wl-paste"
        "--type"
        "text"
        "--watch"
        "cliphist"
        "store"
      ];
    }
  ];

  switch-events = {
    lid-close.action.spawn = [ "hyprlock" ];
  };
}
