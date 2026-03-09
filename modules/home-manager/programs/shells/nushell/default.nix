{
  config,
  lib,
  pkgs,
  ...
}:
let
  cfg = config.features.programs.shells.nushell;
in
{
  options.features.programs.shells.nushell.enable = lib.mkEnableOption "nushell";

  config = lib.mkIf cfg.enable {
    home = {
      packages = with pkgs; [
        nushell
        nushellPlugins.highlight
      ];

      sessionVariables = {
        SHELL = "nu";
      };
    };
  };
}
