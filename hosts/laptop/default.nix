{
  inputs,
  pkgs,
  nixosModules,
  config,
  ...
}:
{
  imports = [
    ./hardware-configuration.nix
    ../common
    "${nixosModules}/desktop/${config.desktop.environment}"
    "${nixosModules}/programs/steam"
    inputs.nix-minecraft.nixosModules.minecraft-servers
  ];

  nixpkgs.overlays = [
    inputs.nix-minecraft.overlay
    inputs.rust-overlay.overlays.default
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
