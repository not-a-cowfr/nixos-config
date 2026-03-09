{
  config,
  configFile,
  lib,
  ...
}:
let
  cfg = config.features.programs.terminal.ghostty;
in
{
  options.features.programs.terminal.ghostty.enable = lib.mkEnableOption "ghostty";

  config = lib.mkIf cfg.enable {
    programs.ghostty = {
      enable = true;

      settings = {
        font-size = 10;

        keybind = "ctrl+a=toggle_tab_overview";
        window-show-tab-bar = "never";

        confirm-close-surface = false;

        cursor-style = "bar";
        cursor-style-blink = false;

        maximize = configFile.desktop.environment != "niri";
      };
    };
  };
}
