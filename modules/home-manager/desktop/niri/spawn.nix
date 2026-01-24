{ configFile, ... }:
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
        "/etc/nixos/assets/wallpapers/${configFile.desktop.wallpaper}/image.jpg"
      ];
    }
  ];
}
