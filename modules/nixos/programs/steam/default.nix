{ pkgs, ... }:
{
  programs.steam = {
    enable = true;
    package = pkgs.steam-millennium;

    remotePlay.openFirewall = true;
  };
}
