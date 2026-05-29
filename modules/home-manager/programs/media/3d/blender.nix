{ config, lib, pkgs, ... }:
let
  cfg = config.features.programs.media."3d".blender;
in
{
    options.features.programs.media."3d".blender.enable = lib.mkEnableOption "blender";

  config = lib.mkIf cfg.enable {
  home.packages = with pkgs; [
    blender
  ];
};
}