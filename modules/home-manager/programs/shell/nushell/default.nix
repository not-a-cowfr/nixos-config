{ pkgs, ... }:
{
  home.packages = with pkgs; [
    nushell
    nushellPlugins.highlight
  ];
}
