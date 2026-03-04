{ config, ... }:
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
    {
      command = [
        "swaybg"
        "-i"
        "${config.stylix.image}"
        "-m"
        "fill"
      ];
    }
  ];

  switch-events = {
    lid-close.action.spawn = [ "hyprlock" ];
  };
}
