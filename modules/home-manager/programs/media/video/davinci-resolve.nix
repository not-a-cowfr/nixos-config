{ config, lib, pkgs, ... }:
let
  cfg = config.features.programs.media.video.davinci-resolve;
in
{
    options.features.programs.media.video.davinci-resolve.enable = lib.mkEnableOption "DaVinci Resolve";

  config = lib.mkIf cfg.enable {
  home.packages = with pkgs; [
    davinci-resolve
  ];
};
}