{
  config,
  inputs,
  pkgs,
  lib,
  ...
}:
let
  cfg = config.features.services.flatpak;
in
{
  imports = [
    inputs.nix-flatpak.homeManagerModules.nix-flatpak
  ];

  options.features.services.flatpak = {
    enable = lib.mkEnableOption "flatpak";
    packages = lib.mkOption {
      type = lib.types.listOf lib.types.str;
      default = [ ];
      description = "A list of flatpaks to install.";
    };
  };

  config = lib.mkIf cfg.enable {
    services.flatpak = {
      enable = true;
      uninstallUnmanaged = true;
      update.auto.enable = true;

      packages = cfg.packages;
    };

    home.packages = [ pkgs.flatpak ];

    xdg.systemDirs.data = [
      "/var/lib/flatpak/exports/share"
      "${config.home.homeDirectory}/.local/share/flatpak/exports/share"
    ];

    systemd.user.sessionVariables = {
      XDG_DATA_DIRS = lib.mkForce (
        "/var/lib/flatpak/exports/share:${config.home.homeDirectory}/.local/share/flatpak/exports/share"
        + ":$XDG_DATA_DIRS"
      );
    };
  };
}
