{
  pkgs,
  config,
  lib,
  ...
}:
let
  cfg = config.features.programs.programming.languages.zig;
in
{
  options.features.programs.programming.languages.zig.enable = lib.mkEnableOption "zig";

  config = lib.mkIf cfg.enable {
    home.packages = with pkgs; [
      zig
    ];
  };
}
