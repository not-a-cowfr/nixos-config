{ config, lib, ... }:
let
  cfg = config.features.programs.cli.direnv;
in
{
  options.features.programs.cli.direnv.enable = lib.mkEnableOption "direnv";

  config = lib.mkIf cfg.enable {
    programs = {
      direnv = {
        enable = true;
        enableNushellIntegration = true; # todo check if nushell is installed for enabling this
        nix-direnv.enable = true;
      };
    };
  };
}
