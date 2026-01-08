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
    ../common
    "${nixosModules}/desktop/${configFile.desktop.environment}"
    "${nixosModules}/programs/steam"
    "${nixosModules}/services/disko/btrfs_with_windows.nix"
    inputs.nix-minecraft.nixosModules.minecraft-servers
    inputs.disko.nixosModules.default
  ];

  nixpkgs.overlays = [
    inputs.nix-minecraft.overlay
    inputs.nix-cachyos-kernel.overlay
    inputs.millennium.overlays.default
  ];

  boot.kernelPackages = pkgs.cachyosKernels.linuxPackages-cachyos-latest;

  networking.firewall = {
    allowedTCPPorts = [
      80
      443
      25565
    ];
    allowedTCPPortRanges = [
      {
        from = 1714;
        to = 1764;
      }
    ];
    allowedUDPPortRanges = [
      {
        from = 1714;
        to = 1764;
      }
    ];
  };
}
