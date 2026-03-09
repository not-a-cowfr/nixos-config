{
  pkgs,
  lib,
  config,
  ...
}:
let
  cfg = config.features.programs.music.spotify;
in
{
  options.features.programs.music.spotify.enable = lib.mkEnableOption "spotify";

  config = lib.mkIf cfg.enable {
    home.packages = with pkgs; [
      spotify
    ];
  };
}
