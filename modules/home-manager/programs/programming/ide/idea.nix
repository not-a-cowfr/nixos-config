{
  pkgs,
  config,
  lib,
  ...
}:
let
  cfg = config.features.programs.programming.ide.jetbrains.idea;
in
{
  options.features.programs.programming.ide.jetbrains.idea.enable =
    lib.mkEnableOption "Intellij Idea";

  config = lib.mkIf cfg.enable {
    home.packages = with pkgs; [
      jetbrains.idea
    ];
  };
}
