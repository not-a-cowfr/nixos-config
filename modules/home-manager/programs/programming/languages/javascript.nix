{
  pkgs,
  config,
  lib,
  ...
}:
let
  cfg = config.features.programs.programming.languages.javascript;
in
{
  options.features.programs.programming.languages.javascript.enable = lib.mkEnableOption "JavaScript";

  config = lib.mkIf cfg.enable {
    home.packages = with pkgs; [
      bun
      nodePackages.pnpm
    ];
  };
}
