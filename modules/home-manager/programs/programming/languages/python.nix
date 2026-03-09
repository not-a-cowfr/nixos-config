{
  pkgs,
  config,
  lib,
  ...
}:
let
  cfg = config.features.programs.programming.languages.python;
in
{
  options.features.programs.programming.languages.python.enable = lib.mkEnableOption "python";

  config = lib.mkIf cfg.enable {
    home.packages = with pkgs; [
      python3
      uv
    ];
  };
}
