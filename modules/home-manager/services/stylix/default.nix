{
  pkgs,
  inputs,
  configFile,
  ...
}:
let
  comic-shanns = pkgs.nerd-fonts.comic-shanns-mono;

  opacity = 0.8;
in
{
  imports = [
    inputs.stylix.homeModules.stylix
  ];

  home.pointerCursor = {
    package = pkgs.rose-pine-cursor;
    name = "BreezeX-RosePine-Linux";
    size = 30;
  };

  stylix = {
    enable = true;

    image = "${inputs.self}/assets/wallpapers/${configFile.desktop.wallpaper}.jpg";
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

    fonts = {
      sansSerif = {
        package = comic-shanns;
        name = "ComicShannsMono Nerd Font Mono";
      };
      serif = {
        package = comic-shanns;
        name = "ComicShannsMono Nerd Font Mono";
      };
      monospace = {
        package = comic-shanns;
        name = "ComicShannsMono Nerd Font Mono";
      };
    };

    opacity = {
      applications = opacity;
      desktop = opacity;
      popups = opacity;
      terminal = opacity;
    };
  };
}
