{
  inputs,
  pkgs,
  nixosModules,
  ...
}:
{
  imports = [
    ./hardware-configuration.nix
    ../common
    "${nixosModules}/desktop/kde"
    "${nixosModules}/programs/steam"
    inputs.nix-minecraft.nixosModules.minecraft-servers
    inputs.chaotic.nixosModules.nyx-cache
    inputs.chaotic.nixosModules.nyx-overlay
    inputs.chaotic.nixosModules.nyx-registry
  ];

  nixpkgs.overlays = [
    inputs.nix-minecraft.overlay
    inputs.rust-overlay.overlays.default
  ];

  boot.kernelPackages = pkgs.linuxPackages_cachyos-rc;

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
