{ pkgs, ... }:
{
  home.packages = with pkgs; [
    bun
    nodePackages.pnpm
    fnm
  ];
}
