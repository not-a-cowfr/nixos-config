{ config, lib, ... }:
let
  cfg = config.features.programs.cli.fzf;
in
{
  options.features.programs.cli.fzf.enable = lib.mkEnableOption "fzf";

  config = lib.mkIf cfg.enable {
    stylix.targets.fzf.enable = false;

    programs.fzf = {
      enable = true;

      defaultCommand = "^find .";
      defaultOptions = [
        "--bind '?:toggle-preview'"
        "--bind 'ctrl-a:select-all'"
        "--bind 'ctrl-e:execute(echo {+} | xargs -o nvim)'"
        "--bind 'ctrl-y:execute-silent(echo {+} | wl-copy)'"
        "--info=inline"
        "--multi"
        "--prompt='~ ' --pointer='▶' --marker='✓'"
      ];
    };
  };
}
