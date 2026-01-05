{ config, ... }:
{
  programs.alacritty = {
    enable = true;

    settings = {
      window = {
        startup_mode = "Maximized";
      };

      font = {
        normal = {
          family = "ComicShannsMono Nerd Font Mono";
        };
      };

      cursor = {
        style = {
          shape = "Beam";
          blinking = "Off";
        };
      };

      terminal = {
        osc52 = "CopyPaste";
        shell = {
          program = "${config.home.homeDirectory}/.nix-profile/bin/nu";
        };
      };
    };
  };
}
