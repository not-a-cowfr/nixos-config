{
  pkgs,
  config,
  lib,
  ...
}:
let
  cfg = config.features.programs.programming.ide.vim;
in
{
  options.features.programs.programming.ide.vim.enable = lib.mkEnableOption "vim";

  config = lib.mkIf cfg.enable {
    home.packages = with pkgs; [
      vim
    ];

    home.sessionVariables = {
      EDITOR = "vim";
    };
  };
}
