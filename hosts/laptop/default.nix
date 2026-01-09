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
    inputs.nix-minecraft.nixosModules.minecraft-servers
    # inputs.disko.nixosModules.default
  ];

  nixpkgs.overlays = [
    inputs.nix-minecraft.overlay
    inputs.nix-cachyos-kernel.overlay
    inputs.millennium.overlays.default
  ];

  # use cachyos rc kernel
  boot.kernelPackages = pkgs.cachyosKernels.linuxPackages-cachyos-rc;

  # enable open razer
  hardware.openrazer.enable = true;

  networking.firewall = {
    allowedTCPPorts = [
      # http
      80
      # https
      443
      # minecraft
      25565
    ];
    allowedTCPPortRanges = [
      # kde connect
      {
        from = 1714;
        to = 1764;
      }
    ];
    allowedUDPPortRanges = [
      # kde connect
      {
        from = 1714;
        to = 1764;
      }
    ];
  };
}
