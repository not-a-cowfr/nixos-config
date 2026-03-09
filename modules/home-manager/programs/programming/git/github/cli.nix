{
  pkgs,
  config,
  lib,
  ...
}:
let
  cfg = config.features.programs.programming.git.github.cli;
in
{
  options.features.programs.programming.git.github.cli.enable = lib.mkEnableOption "GitHub cli";

  config = lib.mkIf cfg.enable {
    home.packages = with pkgs; [
      gh
    ];
  };
}
