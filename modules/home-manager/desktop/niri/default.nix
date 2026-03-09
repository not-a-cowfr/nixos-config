{
  pkgs,
  lib,
  nhModules,
  config,
  inputs,
  configFile,
  ...
}:
{
  imports = [
    inputs.niri.homeModules.niri
    inputs.niri.homeModules.stylix
    "${nhModules}/programs/hyprlock"
    "${nhModules}/programs/hypridle"
    "${nhModules}/programs/fuzzel"
    "${nhModules}/programs/waybar"
    # ../waybar/niri.nix
  ];

  home.packages = with pkgs; [
    xwayland-satellite
    kdePackages.dolphin
    swaybg
    cliphist

    # necessary stuff
    brightnessctl
    wireplumber
    sway-contrib.grimshot
    wl-clipboard

    (writers.writeNuBin "clip-hist-selector" ''
      ${lib.getExe pkgs.cliphist} list
        | cut -f 2-
        | ${lib.getExe pkgs.fuzzel} --dmenu --placeholder "Clipboard"
        | ${pkgs.wl-clipboard}/bin/wl-copy
    '')
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
