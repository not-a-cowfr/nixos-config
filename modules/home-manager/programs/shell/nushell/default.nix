{ pkgs, ... }:
{
  home.packages = with pkgs; [
    nushell
    nushellPlugins.highlight
  ];

  home.sessionVariables = {
    SHELL = "nu";
  };
}
