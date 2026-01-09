{
  outputs,
  userConfig,
  pkgs,
  nhModules,
  configFile,
  ...
}:
{
  imports = [
    "${nhModules}/desktop/${configFile.desktop.environment}" # import nix config for desktop environment from config file
    # default apps
    "${nhModules}/programs/gpg"
    "${nhModules}/programs/flatpak"
    "${nhModules}/programs/cli/fzf.nix"
    "${nhModules}/programs/cli/fastfetch.nix"
  ]
  # import all desktop modules enabled in config file
  ++ map (
    name: "${nhModules}/desktop/${configFile.desktop.environment}/${name}"
  ) configFile.desktop.modules or [ ];

  # i forgot why i added this, i think it was to update nix everytime i rebuilt home-manager because nix got outdated
  nix.package = pkgs.nix;

  nixpkgs = {
    overlays = [
      outputs.overlays.stable-packages
    ];

    config = {
      allowUnfree = true;
      allowBroken = true;
    };
  };

  # required for home-manager to work
  systemd.user.startServices = "sd-switch";
  programs.home-manager.enable = true;
  home.stateVersion = "26.05";

  # remove home manager news
  news.display = "silent";

  # sets up user config using the passed in name
  home = {
    username = "${userConfig.name}";
    homeDirectory = "/home/${userConfig.name}";
  };

  # more default apps
  home.packages = with pkgs; [
    fd
    jq
    ripgrep
    curl
    zip
    unzip
    gcc
    glib

    libgbm
  ];
}
