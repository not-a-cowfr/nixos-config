{ config, lib, ... }:
let
  cfg = config.features.programs.cli.delta;
in
{
  options.features.programs.cli.delta.enable = lib.mkEnableOption "delta";

  config = lib.mkIf cfg.enable {
    programs.delta = {
      enable = true;

      enableGitIntegration = config.features.programs.programming.git.enable;
    };
  };
}
