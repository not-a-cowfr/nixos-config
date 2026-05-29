{
  config,
  lib,
  pkgs,
  ...
}:
let
  cfg = config.features.programs.media.text.obsidian;
in
{
  options.features.programs.media.text.obsidian.enable = lib.mkEnableOption "Obsidian";

  config = lib.mkIf cfg.enable {
    home.packages = with pkgs; [
      obsidian
    ];
  };
}
