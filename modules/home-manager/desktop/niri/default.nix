{
  pkgs,
  lib,
  config,
  inputs,
  configFile,
  ...
}:
{
  imports = [
    inputs.niri.homeModules.niri
    inputs.niri.homeModules.stylix
  ];

  home.packages = with pkgs; [
    xwayland-satellite
    kdePackages.dolphin
    swaybg
    cliphist
    brightnessctl
    wireplumber
    sway-contrib.grimshot
    wl-clipboard

    (writeShellScriptBin "clip-history-selector" (builtins.readFile ./clip-history.sh))
  ];

  services.polkit-gnome.enable = true;

  programs.niri = {
    settings = lib.mkMerge [
      (import ./binds.nix { inherit config; })
      (import ./spawn.nix { inherit config; })
      (import ./input.nix { inherit configFile; })
      ./layout.nix
      ./rules.nix
      ./animations/fold.nix
      {
        hotkey-overlay = {
          skip-at-startup = true;
        };

        prefer-no-csd = true;

        clipboard = {
          disable-primary = true;
        };

        gestures.hot-corners.enable = false;

        cursor = {
          size = config.home.pointerCursor.size;
          theme = config.home.pointerCursor.name;
        };
      }
    ];
  };
}
