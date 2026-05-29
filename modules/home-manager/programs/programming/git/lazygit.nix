{
  config,
  lib,
  ...
}:
let
  cfg = config.features.programs.programming.git.lazygit;
  deltaCfg = config.features.programs.cli.delta;
in
{
  options.features.programs.programming.git.lazygit.enable = lib.mkEnableOption "lazygit";

  config = lib.mkIf cfg.enable {
    programs.lazygit = {
      enable = true;

      settings = {
        git = {
          pagers = [
            (lib.mkIf deltaCfg.enable { pager = "delta --dark --paging=never"; })
            { colorArg = "never"; }
          ];
        };
      };
    };
  };
}
