{
  inputs,
  pkgs,
  nixosModules,
  configFile,
  ...
}:
{
  imports = [
    ./hardware-configuration.nix
    "${nixosModules}/desktop/${configFile.desktop.environment}" # import nix config to enable desktop environment from config file
    "${nixosModules}/programs/steam"
    # "${nixosModules}/services/disko/btrfs_with_windows.nix"
    # inputs.disko.nixosModules.default
  ];

  nixpkgs.overlays = [
    inputs.nix-cachyos-kernel.overlay
    inputs.millennium.overlays.default
  ];

  # use cachyos rc kernel
  boot.kernelPackages = pkgs.cachyosKernels.linuxPackages-cachyos-rc;

  # enable open razer
  # hardware.openrazer.enable = true;

  networking.firewall = {
    allowedTCPPorts = [
      80 # http
      443 # https
      25565 # minecraft
      53317 # localsend
    ];
    allowedTCPPortRanges = [ ];
    allowedUDPPortRanges = [ ];
  };
}
