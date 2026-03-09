{
  config,
  configFile,
  lib,
  pkgs,
  ...
}:
let
  cfg = config.features.programs.terminal.alacritty;
in
{
  options.features.programs.terminal.alacritty.enable = lib.mkEnableOption "Alacritty";

  config = lib.mkIf cfg.enable {
    programs.alacritty = {
      enable = true;

      settings = {
        window = {
          startup_mode = lib.mkIf (configFile.desktop.environment != "niri") "Maximized";
        };

        cursor = {
          style = {
            shape = "Beam";
            blinking = "Off";
          };
        };

        terminal = {
          osc52 = "CopyPaste";
        };
      };
    };
  };
}
