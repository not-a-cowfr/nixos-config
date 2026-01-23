{ pkgs, ... }:
{
  home.packages = with pkgs; [
    razergenie
    polychromatic
    openrazer-daemon
  ];
}
