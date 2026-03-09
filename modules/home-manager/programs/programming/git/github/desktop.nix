{
  pkgs,
  config,
  lib,
  ...
}:
let
  cfg = config.features.programs.programming.git.github.desktop;
in
{
  options.features.programs.programming.git.github.desktop.enable =
    lib.mkEnableOption "GitHub desktop";

  config = lib.mkIf cfg.enable {
    home.packages = with pkgs; [
      github-desktop
    ];
  };
}
