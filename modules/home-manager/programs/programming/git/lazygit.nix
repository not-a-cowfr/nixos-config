{
  config,
  lib,
  ...
}:
let
  cfg = config.features.programs.programming.git.lazygit;
in
{
  options.features.programs.programming.git.lazygit.enable = lib.mkEnableOption "lazygit";

  config = lib.mkIf cfg.enable {
    programs.lazygit = {
      enable = true;
    };
  };
}
