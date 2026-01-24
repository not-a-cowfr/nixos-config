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
    "${nhModules}/programs/hyprlock"
    "${nhModules}/programs/hypridle"
    # ../waybar/niri.nix
  ];

  home.packages = with pkgs; [
    xwayland-satellite
    fuzzel
    kdePackages.dolphin
    btop
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
      (import ./input.nix { inherit configFile; })
      ./layout.nix
      ./rules.nix
      ./spawn.nix
      {
        hotkey-overlay = {
          skip-at-startup = true;
        };

        overview = {
          workspace-shadow.enable = false;
        };

        prefer-no-csd = true;

        clipboard = {
          disable-primary = true;
        };
      }
    ];
  };
}
