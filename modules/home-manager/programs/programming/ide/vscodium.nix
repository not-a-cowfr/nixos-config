{ pkgs, lib, ... }:
{
  home.packages = with pkgs; [
    vscodium-fhs
  ];
}
