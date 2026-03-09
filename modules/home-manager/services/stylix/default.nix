{
  inputs,
  config,
  lib,
  pkgs,
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

  options.looks = {
    enable = lib.mkEnableOption "theme";
    theme = lib.mkOption {
      type = lib.types.str;
      description = "name of theme to use";
      default = "darcula";
    };
    wallpaper = lib.mkOption {
      type = lib.types.str;
      description = "name of wallpaper to use";
    };
    opacity = lib.mkOption {
      type = lib.types.float;
      description = "opacity";
      default = 1.0;
    };

    font = {
      regular = {
        name = lib.mkOption {
          type = lib.types.str;
          default = "DejaVu Sans";
          description = "font to use";
        };
        package = lib.mkOption {
          type = lib.types.package;
          default = pkgs.dejavu_fonts;
          description = "font package to use";
        };
      };
      mono = {
        name = lib.mkOption {
          type = lib.types.str;
          default = "JetBrains Mono";
          description = "font to use";
        };
        package = lib.mkOption {
          type = lib.types.package;
          default = pkgs.jetbrains-mono;
          description = "font package to use";
        };
      };
      # size = {
      #   small = lib.mkOption {
      #     type = lib.types.str;
      #     default = "10";
      #     description = "The size of the font to use for small text. (e.g. terminals)";
      #   };
      #   medium = lib.mkOption {
      #     type = lib.types.str;
      #     default = "14";
      #     description = "The size of the font to use for medium text. (e.g. waybar)";
      #   };
      #   large = lib.mkOption {
      #     type = lib.types.str;
      #     default = "18";
      #     description = "The size of the font to use for large text.";
      #   };
      # };
    };

    cursor = {
      name = lib.mkOption {
        type = lib.types.str;
        default = "BreezeX-RosePine-Linux";
        description = "cursor pack to use";
      };
      package = lib.mkOption {
        type = lib.types.package;
        default = pkgs.rose-pine-cursor;
        description = "cursor package to use";
      };
      size = lib.mkOption {
        type = lib.types.int;
        default = 30;
        description = "cursor size";
      };
    };
  };

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
        sansSerif = cfg.font.regular;
        serif = cfg.font.regular;
        monospace = cfg.font.mono;
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
