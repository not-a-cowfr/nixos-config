{
  inputs,
  outputs,
  lib,
  config,
  enabledUsers,
  pkgs,
  hostname,
  configFile,
  ...
}:
{
  nixpkgs = {
    overlays = [
      outputs.overlays.stable-packages
    ];

    config = {
      allowUnfree = true;
      allowBroken = true;
    };
  };

  nix.registry = lib.mapAttrs (_: flake: { inherit flake; }) (
    lib.filterAttrs (_: lib.isType "flake") inputs
  );

  nix = {
    package = pkgs.nixVersions.latest;

    settings.trusted-users = [
      "root"
      "@wheel"
    ];

    nixPath = [ "/etc/nix/path" ];

    settings = {
      # enables nix commands and flakes
      experimental-features = "nix-command flakes";
      auto-optimise-store = true;
    };

    # iirc this should delete old nixos configurations
    # i chose 30d because i doubt i will have 30d worth of unbootable configurations to need ones that old
    # automated to run every week
    gc = {
      automatic = true;
      dates = "weekly";
      options = "--delete-older-than 30d";
    };

    # i have no clue what this optimises but optimization is cool so i have it enabled
    optimise = {
      automatic = true;
      dates = [ "weekly" ];
    };
  };

  environment.etc = lib.mapAttrs' (name: value: {
    name = "nix/path/${name}";
    value.source = value.flake;
  }) config.nix.registry;

  environment.sessionVariables = {
    # note to chromium apps that wayland is used
    NIXOS_OZONE_WL = 1;
    # NIX_BUILD_SHELL = "nu";
  };

  boot = {
    loader.efi.canTouchEfiVariables = true;

    # gives 2 seconds to select another boot option before auto booting nixos
    # timer pauses once you do something which is why its only 2 seconds
    loader.timeout = 2;
    # disbaled systemd-boot in order to use grub
    loader.systemd-boot.enable = false;

    # enable grub with os prober
    loader.grub = {
      enable = true;
      devices = [ "nodev" ];
      efiSupport = true;
      useOSProber = true;

      # add grub nixos theme
      theme = pkgs.stdenv.mkDerivation {
        pname = "distro-grub-themes";
        version = "3.1";
        src = pkgs.fetchFromGitHub {
          owner = "AdisonCavani";
          repo = "distro-grub-themes";
          rev = "v3.1";
          hash = "sha256-ZcoGbbOMDDwjLhsvs77C7G7vINQnprdfI37a9ccrmPs=";
        };
        installPhase = "cp -r customize/nixos $out";
      };
    };

    plymouth.enable = true;

    # doesnt work with latest rc kernel
    # kernelModules = [ "v4l2loopback" ];
    # extraModulePackages = with config.boot.kernelPackages; [ v4l2loopback ];
    # extraModprobeConfig = ''
    # options v4l2loopback exclusive_caps=1 card_label="Virtual Camera"
    # '';
  };

  # enable netowrking
  networking = {
    networkmanager.enable = true;
    hostName = hostname;
  };

  systemd.services = {
    NetworkManager-wait-online.enable = false;
    plymouth-quit-wait.enable = false;
  };

  # allows running non-nix-native programs
  programs.nix-ld.enable = true;

  # locale stuff
  # todo: maybe pull this info from config.toml?
  time.timeZone = "America/Los_Angeles";
  i18n.defaultLocale = "en_US.UTF-8";
  i18n.extraLocaleSettings = {
    LC_ADDRESS = "en_US.UTF-8";
    LC_IDENTIFICATION = "en_US.UTF-8";
    LC_MEASUREMENT = "en_US.UTF-8";
    LC_MONETARY = "en_US.UTF-8";
    LC_NAME = "en_US.UTF-8";
    LC_NUMERIC = "en_US.UTF-8";
    LC_PAPER = "en_US.UTF-8";
    LC_TELEPHONE = "en_US.UTF-8";
    LC_TIME = "en_US.UTF-8";
  };
  services.xserver.xkb = configFile.hardware.keyboard;

  # enable bluetooth
  hardware.bluetooth = {
    enable = true;
    powerOnBoot = true;
  };

  environment.localBinInPath = true;

  # misc services, i forgot what most of them do
  services.locate.enable = true;
  # enable openssh
  services.openssh.enable = true;
  services.libinput.enable = true;
  services.dbus.enable = true;
  # enable printing
  services.printing.enable = false;
  services.devmon.enable = true;
  # enable audio stuff
  services.pulseaudio.enable = false;
  security.rtkit.enable = true;
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
    jack.enable = true;
  };

  users.users = lib.mapAttrs (_: user: {
    isNormalUser = true;
    description = user.fullName;
    extraGroups = [
      "networkmanager"
      # todo maybe make some changes to config.toml format to define which users get wheel and which dont
      "wheel"
      "docker"
      "openrazer"
      "libvirtd"
      "vboxusers"
    ];
    shell = pkgs.nushell;
  }) enabledUsers;

  # user avatar
  # system.activationScripts.userAvatars.text =
  # lib.concatStringsSep "\n" (
  #   lib.mapAttrsToList (_: user: ''
  #     mkdir -p /var/lib/AccountsService/{icons,users}
  #     cp ${user.avatar} /var/lib/AccountsService/icons/${user.name}

  #     touch /var/lib/AccountsService/users/${user.name}
  #     if ! grep -q "^Icon=" /var/lib/AccountsService/users/${user.name}; then
  #       echo "[User]" >> /var/lib/AccountsService/users/${user.name}
  #       echo "Icon=/var/lib/AccountsService/icons/${user.name}" \
  #         >> /var/lib/AccountsService/users/${user.name}
  #     fi
  #   '') enabledUsers
  # );

  # security.sudo.wheelNeedsPassword = false;

  systemd.tmpfiles.rules = [
    # for getting qemu to work
    # todo: move to modules/nixos/services/qemu
    "L+ /var/lib/qemu/firmware - - - - ${pkgs.qemu}/share/qemu/firmware"
    # "f /dev/shm/looking-glass 0660 ${user} qemu-libvirtd -"
    # give wheel group full access to /etc/nixos and any user read access
    "d /etc/nixos 0774 root wheel - -"
  ];

  # virtualisation = {
  #   virtualbox.host.enable = true;

  #   # enable qemu
  #   # todo: move to modules/nixos/services/qemu
  #   libvirtd = {
  #     enable = true;
  #     qemu = {
  #       swtpm.enable = true;
  #       # ovmf = {
  #       #   enable = true;
  #       #   packages = [ pkgs.OVMFFull.fd ];
  #       # };
  #     };
  #   };

  #   spiceUSBRedirection.enable = true;

  #   # enable docker service
  #   # todo: move to modules/nixos/services/docker
  #   docker = {
  #     enable = true;
  #     rootless.enable = true;
  #     rootless.setSocketVariable = true;
  #   };
  # };

  # enable xwayland
  programs.xwayland.enable = true;

  # install comic-shanns-mono
  # todo: install ms comic sans
  fonts.packages = with pkgs; [
    nerd-fonts.comic-shanns-mono
  ];

  environment.systemPackages = with pkgs; [
    efibootmgr
  ];

  environment.shells = [ pkgs.nushell ];

  # nixos version
  system.stateVersion = "26.11";
}
