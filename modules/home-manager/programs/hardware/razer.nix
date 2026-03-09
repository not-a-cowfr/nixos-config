{
  config,
  lib,
  pkgs,
  ...
}:
let
  cfg = config.features.programs.hardware.razer;
in
{
  options.features.programs.hardware.razer.enable = lib.mkEnableOption "razer";

  config = lib.mkIf cfg.enable {
    home.packages = with pkgs; [
      razergenie
      polychromatic
      openrazer-daemon
    ];
  };
}
