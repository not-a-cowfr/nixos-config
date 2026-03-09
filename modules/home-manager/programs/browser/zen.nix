{
  inputs,
  pkgs,
  config,
  lib,
  ...
}:
let
  cfg = config.features.programs.browsers.zen;
in
{
  options.features.programs.browsers.zen = {
    enable = lib.mkEnableOption "zen-browser";
    useExperimentalConfig = lib.mkEnableOption "zen flake declaritive config";
  };

  config = lib.mkIf (cfg.enable && !cfg.useExperimentalConfig) {
    home = {
      packages = [
        inputs.zen-browser.packages."${pkgs.stdenv.hostPlatform.system}".twilight
      ];

      sessionVariables = {
        BROWSER = "zen";
      };
    };
  };
}
