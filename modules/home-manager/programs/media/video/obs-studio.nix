{ config, lib, pkgs, ... }:
let
  cfg = config.features.programs.media.video.obs-studio;
in
{
    options.features.programs.media.video.obs-studio.enable = lib.mkEnableOption "OBS Studio";

  config = lib.mkIf cfg.enable {
  home.packages = with pkgs; [
    obs-studio
  ];
};
}