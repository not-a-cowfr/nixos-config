{
  lib,
  config,
  ...
}:
let
  background = "rgb(0,0,0)";
  foreground = "rgb(255,255,255)";
  blue = "rgb(79,201,214)";
  red = "rgb(224,16,54)";
  wallpaper = "/etc/nixos/assets/wallpapers/dark_fern/image.jpg";
  font = "Comic Sans MS";
in
{
  programs.hyprlock = {
    enable = true;

    settings = {
      general = {
        hide_cursor = true;
        ignore_empty_input = true;
      };

      background = {
        monitor = "";
        path = wallpaper;
        blur_passes = 2;
        blur_size = 4;
      };

      input-field = lib.mkForce {
        monitor = "";
        size = "200, 50";
        outline_thickness = 3;
        dots_size = 0.33;
        dots_spacing = 0.15;
        dots_center = true;
        # dots_rounding = -1;
        outer_color = foreground;
        inner_color = background;
        font_color = foreground;
        fade_on_empty = true;
        fade_timeout = 1000;
        placeholder_text = "<i>password...</i>";
        hide_input = false;
        # rounding = -1;
        check_color = blue;
        fail_color = red;
        fail_text = "<i>$FAIL <b>($ATTEMPTS)</b></i>";
        fail_transition = 300;
        capslock_color = -1;
        numlock_color = -1;
        bothlock_color = -1;
        invert_numlock = false;
        swap_font_color = false;
        position = "0, -20";
        halign = "center";
        valign = "center";
      };

      label = [
        # Day-Month-Date
        {
          monitor = "";
          text = ''cmd[update:1000] echo -e "$(date +"%A, %B %d")"'';
          color = foreground;
          font_size = 28;
          font_family = font;
          position = "0, 250";
          halign = "center";
          valign = "center";
          shadow_passes = 5;
          shadow_size = 10;
        }
        # Time
        {
          monitor = "";
          text = ''cmd[update:1000] echo "<span>$(date +"%H:%M")</span>"'';
          color = foreground;
          font_size = 120;
          font_family = font;
          position = "0, 380";
          halign = "center";
          valign = "center";
        }
        # USER
        {
          monitor = "";
          text = "  $USER";
          color = foreground;
          outline_thickness = 2;
          dots_size = 0.2;
          dots_spacing = 0.2;
          dots_center = true;
          font_size = 18;
          font_family = font;
          position = "0, -180";
          halign = "center";
          valign = "center";
        }
      ];
    };
  };
}
