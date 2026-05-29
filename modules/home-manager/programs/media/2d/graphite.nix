{
  config,
  lib,
  pkgs,
  ...
}:
let
  cfg = config.features.programs.media."2d".graphite;
in
{
  options.features.programs.media."2d".graphite.enable = lib.mkEnableOption "graphite";

  config = lib.mkIf cfg.enable {
    home.packages = with pkgs; [
      graphite
    ];
  };
}
