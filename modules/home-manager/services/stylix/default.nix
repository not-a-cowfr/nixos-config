{
  inputs,
  config,
  lib,
  ...
}:
let
  cfg = config.looks;
in
{
  imports = [
    inputs.stylix.homeModules.stylix
    ./darcula.nix
  ];

  config = lib.mkIf cfg.enable {
    home.pointerCursor = {
      package = cfg.cursor.package;
      name = cfg.cursor.name;
      size = cfg.cursor.size;
    };

    stylix = {
      enable = true;

      image = "${inputs.self}/assets/wallpapers/${cfg.wallpaper}.jpg";

      fonts = {
        sansSerif = {
          package = cfg.font.package;
          name = cfg.font.name;
        };
        serif = {
          package = cfg.font.package;
          name = cfg.font.name;
        };
        monospace = {
          package = cfg.font.package;
          name = cfg.font.name;
        };
      };

      opacity = {
        applications = cfg.opacity;
        desktop = cfg.opacity;
        popups = cfg.opacity;
        terminal = cfg.opacity;
      };
    };
  };
}
