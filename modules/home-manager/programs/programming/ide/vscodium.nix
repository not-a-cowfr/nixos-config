{
  pkgs,
  config,
  lib,
  ...
}:
let
  cfg = config.features.programs.programming.ide.vscodium;
in
{
  options.features.programs.programming.ide.vscodium.enable = lib.mkEnableOption "VSCodium";

  config = lib.mkIf cfg.enable {
    home.packages = with pkgs; [
      vscodium-fhs
    ];
  };
}
