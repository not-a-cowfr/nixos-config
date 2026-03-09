{ config, lib, ... }:
let
  cfg = config.features.programs.desktop.fuzzel;
in
{
  options.features.programs.desktop.fuzzel.enable = lib.mkEnableOption "fuzzel";

  config = lib.mkIf cfg.enable {
    programs.fuzzel = {
      enable = true;
    };
  };
}
