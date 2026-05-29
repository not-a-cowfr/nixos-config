{
  config,
  lib,
  pkgs,
  ...
}:
let
  cfg = config.features.programs.management.files.dolphin;
in
{
  options.features.programs.management.files.dolphin.enable = lib.mkEnableOption "dolphin";

  config = lib.mkIf cfg.enable {
    home.packages = with pkgs.kdePackages; [
      dolphin
      ffmpegthumbs
      kdegraphics-thumbnailers
      kconfig
    ];
  };
}
