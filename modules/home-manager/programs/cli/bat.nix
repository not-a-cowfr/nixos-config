{ config, lib, ... }:
let
  cfg = config.features.programs.cli.bat;
in
{
  options.features.programs.cli.bat.enable = lib.mkEnableOption "bat";

  config = lib.mkIf cfg.enable {
    programs.bat = {
      enable = true;
    };
  };
}
