#! like jetbrains darcula but a little darker
{
  pkgs,
  lib,
  config,
  ...
}:
{
  config = lib.mkIf (config.looks.theme == "darcula") {
    stylix = {
      polarity = "dark";
      base16Scheme = {
        name = "Darcula Dark";
        slug = "darcula-dark";

        base00 = "1d1d1d";
        base01 = "242424";
        base02 = "2f2f2f";
        base03 = "787c80";
        base04 = "acb0be";
        base05 = "ffffff";
        base06 = "f9f9f9";
        base07 = "ffffff";
        base08 = "ff5555";
        base09 = "ff9549";
        base0A = "f0be6e";
        base0B = "63945c";
        base0C = "72939c";
        base0D = "99c2ff";
        base0E = "93689c";
        base0F = "d97934";
      };
    };
  };
}
