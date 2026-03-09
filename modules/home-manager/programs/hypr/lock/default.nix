{ config, lib, ... }:
let
  cfg = config.features.programs.hypr.lock;
in
{
  options.features.programs.hypr.lock.enable = lib.mkEnableOption "hyprlock";

  config = lib.mkIf cfg.enable {
    programs.hyprlock = {
      enable = true;
      settings = {
        ignore_empty_input = true;

        label = {
          text = "$TIME";
          font_size = 65;
          font_family = config.stylix.fonts.monospace.name;

          position = "0, 0";
          halign = "center";
          valign = "center";
        };

        input-field = {
          size = "250, 50";
          position = "0, -80";
          outline_thickness = 0;
          placeholder_text = "";
        };
      };
    };
  };
}
