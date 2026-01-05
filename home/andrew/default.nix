{
  nhModules,
  pkgs,
  inputs,
  config,
  ...
}:
{
  imports = [
    ../common
    "${nhModules}/desktop/${config.desktop.environment}"
    "${nhModules}/programs/git"
    "${nhModules}/programs/starship"
    "${nhModules}/programs/terminal"
    # "${nhModules}/programs/discord"
    "${nhModules}/programs/spotify"
    "${nhModules}/programs/code-editor"
  ];

  news.display = "silent";

  programs.home-manager.enable = true;

  services.kdeconnect.enable = true;

  home.packages = with pkgs; [
    # dev apps
    github-desktop
    gparted
    unetbootin
    jetbrains.idea-ultimate

    # regular apps
    legcord
    polychromatic
    prismlauncher
    razergenie
    steam-run
    inputs.zen-browser.packages."${pkgs.system}".twilight
    zoom-us
    audacity
    qemu

    # languages
    bun
    python3
    rustup
    zig
    nushell
    nasm
    go

    # cli tools
    cargo-flamegraph
    dioxus-cli
    docker
    docker-compose
    fnm
    mongodb
    mongosh
    nginx
    nodePackages.pnpm
    nixfmt
    nushellPlugins.highlight
    rcon-cli
    rojo
    uv
    valkey
    vim
    dig
    direnv

    # deps
    steamcmd

    # cybersec class stuff
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
