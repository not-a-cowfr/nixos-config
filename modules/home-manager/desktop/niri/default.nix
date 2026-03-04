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

    # necessary stuff
    brightnessctl
    wireplumber
    sway-contrib.grimshot
    wl-clipboard
  ];

  services.polkit-gnome.enable = true;

  programs.niri = {
    settings = lib.mkMerge [
      (import ./binds.nix { inherit config; })
      (import ./spawn.nix { inherit config; })
      (import ./input.nix { inherit configFile; })
      ./layout.nix
      ./rules.nix
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
