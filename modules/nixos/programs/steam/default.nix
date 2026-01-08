{ pkgs, ... }:
{
  programs.steam = {
    enable = true;

    package = pkgs.millennium-steam;

    remotePlay.openFirewall = true;
  };
}
