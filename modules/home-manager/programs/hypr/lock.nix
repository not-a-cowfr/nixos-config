{
  config,
  lib,
  userConfig,
  ...
}:
let
  cfg = config.features.programs.hypr.lock;
  font = config.stylix.fonts.monospace.name;
  c = config.stylix.base16Scheme;

  rgb = hex: "rgb(${hex})";
  rgba =
    hex: a:
    let
      alpha = lib.toHexString (builtins.floor (a * 255.0));
      alphaPadded = if builtins.stringLength alpha == 1 then "0${alpha}" else alpha;
    in
    "rgba(${hex}${alphaPadded})";
in
{
  options.features.programs.hypr.lock.enable = lib.mkEnableOption "hyprlock";

  config = lib.mkIf cfg.enable {
    programs.hyprlock = {
      enable = true;
      settings = {
        background = {
          monitor = "";
          path = config.stylix.image;
          blur_passes = 3;
          contrast = 0.8916;
          brightness = 0.8172;
          vibrancy = 0.1696;
          vibrancy_darkness = 0.0;
        };

        general = {
          no_fade_in = false;
          grace = 0;
          disable_loading_bar = false;
        };

        image = [
          {
            monitor = "";
            path = "/var/lib/AccountsService/icons/${userConfig.name}";
            border_size = 0;
            size = 120;
            rounding = -1;
            rotate = 0;
            reload_time = -1;
            reload_cmd = "";
            position = "0, 60";
            halign = "center";
            valign = "center";
          }
        ];

        label = [
          {
            monitor = "";
            text = ''cmd[update:1000] echo -e "$(LC_TIME=en_US.UTF-8 date +"%A, %B %d")"'';
            color = rgba c.base05 0.9;
            font_size = 25;
            font_family = font;
            position = "0, 350";
            halign = "center";
            valign = "center";
          }
          {
            monitor = "";
            text = ''cmd[update:1000] echo "<span>$(date +"%I:%M")</span>"'';
            color = rgba c.base05 0.9;
            font_size = 120;
            font_family = font;
            position = "0, 230";
            halign = "center";
            valign = "center";
          }
          {
            monitor = "";
            text = userConfig.fullName;
            color = rgba c.base05 0.8;
            font_size = 16;
            font_family = font;
            position = "0, -30";
            halign = "center";
            valign = "center";
          }
        ];

        "input-field" = lib.mkForce {
          monitor = "";
          size = "280, 55";
          outline_thickness = 2;
          dots_size = 0.2;
          dots_spacing = 0.2;
          dots_center = true;
          outer_color = rgba c.base0D 0.8;
          inner_color = rgba c.base01 0.9;
          font_color = rgb c.base04;
          fade_on_empty = false;
          font_family = font;
          placeholder_text = "Enter Password";
          hide_input = false;
          position = "0, -110";
          halign = "center";
          valign = "center";
        };
      };
    };
  };
}
