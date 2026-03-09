{
  nhModules,
  pkgs,
  inputs,
  ...
}:
{
  imports = [
    "${nhModules}/programs/browser/zen.nix"
    "${nhModules}/programs/cli/bat.nix"
    "${nhModules}/programs/cli/direnv.nix"
    "${nhModules}/programs/cli/starship.nix"
    "${nhModules}/programs/cli/btop.nix"
    "${nhModules}/programs/music/spicetify.nix"
    "${nhModules}/programs/programming/languages/rust.nix"
    "${nhModules}/programs/programming/languages/typescript.nix"
    "${nhModules}/programs/programming/languages/python.nix"
    "${nhModules}/programs/programming/git"
    "${nhModules}/programs/programming/git/lazygit.nix"
    "${nhModules}/programs/programming/git/github/cli.nix"
    "${nhModules}/programs/programming/ide/vscodium.nix"
    "${nhModules}/programs/programming/ide/idea.nix"
    "${nhModules}/programs/programming/ide/vim.nix"
    # "${nhModules}/programs/razer"
    "${nhModules}/programs/shell/nushell"
    "${nhModules}/programs/terminal/ghostty.nix"
    "${nhModules}/programs/chat/discord/equicord.nix"
  ];

  looks = {
    enable = true;
    theme = "darcula";
    wallpaper = "foggy-forest";
    opacity = 0.8;
    font = {
      name = "ComicShannsMono Nerd Font Mono";
      package = pkgs.nerd-fonts.comic-shanns-mono;
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
          email = "104355555+not-a-cowfr@users.noreply.github.com";

          github = {
            cli.enable = true;
          };

          lazygit.enable = true;
        };

        ide = {
          vscodium.enable = true;
        };
      };
    };
  };

  home.packages = with pkgs; [
    protonmail-desktop
    vlc
    prismlauncher
    zoom-us
    stoat-desktop
    nixfmt
    gparted
    kdePackages.isoimagewriter
    localsend
  ];
}
