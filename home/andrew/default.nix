{
  nhModules,
  pkgs,
  inputs,
  configFile,
  ...
}:
{
  imports = [
    ../common
    "${nhModules}/desktop/${configFile.desktop.environment}"
    "${nhModules}/programs/browser/zen.nix"
    "${nhModules}/programs/cli/bat.nix"
    "${nhModules}/programs/cli/direnv.nix"
    "${nhModules}/programs/cli/starship.nix"
    "${nhModules}/programs/git"
    "${nhModules}/programs/ide/vscodium.nix"
    "${nhModules}/programs/ide/vim.nix"
    "${nhModules}/programs/music/spicetify.nix"
    "${nhModules}/programs/programming/languages/rust.nix"
    "${nhModules}/programs/programming/languages/typescript.nix"
    "${nhModules}/programs/programming/languages/python.nix"
    "${nhModules}/programs/programming/github.nix"
    "${nhModules}/programs/razer"
    "${nhModules}/programs/shell/nushell"
    "${nhModules}/programs/steam"
    "${nhModules}/programs/terminal/ghostty.nix"
  ];

  news.display = "silent";

  programs.home-manager.enable = true;

  services.kdeconnect.enable = true;

  home.packages = with pkgs; [
    legcord
    prismlauncher
    zoom-us
    nixfmt

    # cybersec class stuff
    # todo: remove after wednesday
    sherlock
    nmap
    wireshark-qt
    tcpdump
    stegseek
    exiftool
    foremost
  ];

  home.stateVersion = "25.11";
}
