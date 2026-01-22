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
}
