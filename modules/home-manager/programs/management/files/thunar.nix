{
  config,
  lib,
  pkgs,
  ...
}:
let
  cfg = config.features.programs.management.files.thunar;
in
{
  options.features.programs.management.files.thunar.enable = lib.mkEnableOption "thunar";

  config = lib.mkIf cfg.enable {
    home.packages = with pkgs; [
      thunar
      gvfs
      thunar-archive-plugin
      thunar-volman

      xfconf
    ];
  };
}
