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
    "${nhModules}/desktop/${configFile.desktop.environment}"
    "${nhModules}/programs/gpg"
    "${nhModules}/programs/flatpak"
    "${nhModules}/programs/cli/fzf.nix"
    "${nhModules}/programs/cli/fastfetch.nix"
  ]
  ++ map (
    name: "${nhModules}/desktop/${configFile.desktop.environment}/${name}"
  ) configFile.desktop.modules or [ ];

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

  systemd.user.startServices = "sd-switch";

  home = {
    username = "${userConfig.name}";
    homeDirectory = "/home/${userConfig.name}";
  };

  home.packages = with pkgs; [
    fd
    jq
    ripgrep
    curl
    zip
    unzip

    openrazer-daemon
    libgbm
  ];
}
