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
  # todo: create ext4 config and just do "${nixosModules}/services/disko/${configFile.filesystem.type}.nix"
  imports = lib.mkIf (configFile.filesystem.type == "btrfs") [
    "${nixosModules}/services/disko/btrfs.nix"
  ];

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
      experimental-features = "nix-command flakes";
      auto-optimise-store = true;
    };

    gc = {
      automatic = true;
      dates = "weekly";
      options = "--delete-older-than 30d";
    };

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
    NIXOS_OZONE_WL = 1;
    # NIX_BUILD_SHELL = "nu";
  };

  boot = {
    loader.efi.canTouchEfiVariables = true;

    loader.timeout = 2;
    loader.systemd-boot.enable = false;

    loader.grub = {
      enable = true;
      devices = [ "nodev" ];
      efiSupport = true;
      useOSProber = true;

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

  networking = {
    networkmanager.enable = true;
    hostName = hostname;
  };

  systemd.services = {
    NetworkManager-wait-online.enable = false;
    plymouth-quit-wait.enable = false;
  };

  programs.nix-ld.enable = true;

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

  hardware.openrazer.enable = true;
  hardware.bluetooth = {
    enable = true;
    powerOnBoot = true;
  };

  services.libinput.enable = true;

  services.xserver.xkb = {
    layout = "us";
    variant = "";
  };

  services.dbus.enable = true;

  environment.localBinInPath = true;

  services.printing.enable = false;

  services.devmon.enable = true;

  services.pulseaudio.enable = false;
  security.rtkit.enable = true;
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
    jack.enable = true;
  };

  services.flatpak.enable = true;

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

  environment.systemPackages = with pkgs; [
    gcc
    glib
    gnumake
    killall
    mesa
  ];

  systemd.tmpfiles.rules = [
    "L+ /var/lib/qemu/firmware - - - - ${pkgs.qemu}/share/qemu/firmware"
    # "f /dev/shm/looking-glass 0660 ${user} qemu-libvirtd -"
    "d /etc/nixos 0774 root wheel - -"
  ];

  virtualisation = {
    virtualbox.host.enable = true;

    libvirtd = {
      enable = true;
      qemu = {
        swtpm.enable = true;
        # ovmf = {
        #   enable = true;
        #   packages = [ pkgs.OVMFFull.fd ];
        # };
      };
    };

    spiceUSBRedirection.enable = true;

    docker = {
      enable = true;
      rootless.enable = true;
      rootless.setSocketVariable = true;
    };
  };

  programs.xwayland.enable = true;

  fonts.packages = with pkgs; [
    nerd-fonts.comic-shanns-mono
  ];

  services.locate.enable = true;

  services.openssh.enable = true;

  system.stateVersion = "25.11";
}
