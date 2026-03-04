{
  configFile,
  config,
  pkgs,
  ...
}:
{
  programs.ghostty = {
    enable = true;

    settings = {
      font-size = 10;

      keybind = "ctrl+a=toggle_tab_overview";
      window-show-tab-bar = "never";

      cursor-style = "bar";
      cursor-style-blink = false;

      command = "nu";

      maximize = configFile.desktop.environment != "niri";
    };
  };
}
