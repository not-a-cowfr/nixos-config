{
  pkgs,
  config,
  lib,
  ...
}:
let
  cfg = config.features.programs.programming.languages.rust;
in
{
  options.features.programs.programming.languages.rust.enable = lib.mkEnableOption "rust";

  config = lib.mkIf cfg.enable {
    home.packages = with pkgs; [
      rustup
    ];
  };
}
