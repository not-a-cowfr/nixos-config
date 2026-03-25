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
  ];

  nixpkgs.overlays = [
    inputs.nix-cachyos-kernel.overlay
    inputs.millennium.overlays.default
  ];

  services.thinkfan = {
    enable = true;

    # max speed always
    levels = [
      [
        7
        0
        32767
      ]
    ];
  };

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

  services = {
    upower.enable = true;
    power-profiles-daemon.enable = true;
  };
}
