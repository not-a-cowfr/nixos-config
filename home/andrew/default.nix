{ pkgs, ... }:
{
  looks = {
    enable = true;
    theme = "darcula";
    wallpaper = "foggy-forest";
    opacity = 0.8;
    font = {
      regular = {
        name = "Comic Sans MS";
        package = pkgs.corefonts;
      };
      mono = {
        name = "ComicShannsMono Nerd Font Mono";
        package = pkgs.nerd-fonts.comic-shanns-mono;
      };
    };
  };
  features = {
    services = {
      flatpak = {
        enable = true;
        packages = [
          "org.vinegarhq.Sober"
          "org.vinegarhq.Vinegar"
        ];
      };
    };

    programs = {
      browsers = {
        zen = {
          enable = true;
          useExperimentalConfig = false;
        };
      };

      chat = {
        discord = {
          equicord = {
            enable = true;
            equibop.enable = true;
          };
        };
      };

      cli = {
        bat.enable = true;
        btop.enable = true;
        direnv.enable = true;
        fastfetch = {
          enable = true;
          image = "nixos-mlm";
        };
        fzf.enable = true;
        starship.enable = true;
      };

      desktop = {
        fuzzel.enable = true;
        waybar = {
          enable = true;
          modules = {
            left = [
              "niri/workspaces"
              "cpu"
              "memory"
              "tray"
              "custom/music"
            ];
            center = [
              "clock"
            ];
            right = [
              "network"
              "bluetooth"
              "backlight"
              "pulseaudio"
              "battery"
              "power-profiles-daemon"
              "custom/power"
            ];
          };
        };
      };

      # hardware = {
      #   razer.enable = false;
      # };

      hypr = {
        lock.enable = true;

        idle = {
          enable = true;
          timeout = 300;
        };
      };

      music = {
        spicetify.enable = true;
      };

      programming = {
        git = {
          enable = true;
          username = "not a cow";
          email = "agielow@proton.me";

          github = {
            cli.enable = true;
          };

          lazygit.enable = true;
        };

        ide = {
          vscodium.enable = true;
        };

        languages = {
          javascript.enable = true;
          python.enable = true;
          rust.enable = true;
        };
      };

      security = {
        gpg.enable = true;
      };

      shells = {
        nushell.enable = true;
      };

      terminal = {
        ghostty.enable = true;
      };
    };
  };

  home.packages = with pkgs; [
    protonmail-desktop
    vlc
    prismlauncher
    zoom-us
    nixfmt
    gparted
    kdePackages.isoimagewriter
    localsend
  ];
}
