{ pkgs, config, ... }:
let
  hexToRgba =
    hex: alpha:
    let
      r = "0x${builtins.substring 0 2 hex}";
      g = "0x${builtins.substring 2 2 hex}";
      b = "0x${builtins.substring 4 2 hex}";
    in
    "rgba(${r}, ${g}, ${b}, ${builtins.toString alpha})";

  c = config.stylix.base16Scheme;
  opacity = config.stylix.opacity;

  cssBase16Colors = ''
    @define-color base00 #${c.base00};
    @define-color base00-40 ${hexToRgba c.base00 0.4};
    @define-color base00-20 ${hexToRgba c.base00 0.2};
    @define-color base01 #${c.base01};
    @define-color base02 #${c.base02};
    @define-color base03 #${c.base03};
    @define-color base04 #${c.base04};
    @define-color base05 #${c.base05};
    @define-color base06 #${c.base06};
    @define-color base07 #${c.base07};
    @define-color base08 #${c.base08};
    @define-color base09 #${c.base09};
    @define-color base0A #${c.base0A};
    @define-color base0B #${c.base0B};
    @define-color base0C #${c.base0C};
    @define-color base0D #${c.base0D};
    @define-color base0E #${c.base0E};
    @define-color base0F #${c.base0F};
  '';
in
{
  home.packages = with pkgs; [
    playerctl
    blueman
    nwg-bar
  ];

  stylix.targets.waybar.enable = false;

  programs.waybar = {
    enable = true;

    settings = {
      mainBar = {
        layer = "top";
        "modules-left" = [
          "niri/workspaces"
          "cpu"
          "memory"
          "tray"
          "custom/music"
        ];
        "modules-center" = [
          "clock"
        ];
        "modules-right" = [
          "network"
          "bluetooth"
          "backlight"
          "pulseaudio"
          "battery"
          "power-profiles-daemon"
          "custom/power"
        ];
        pulseaudio = {
          tooltip = false;
          "scroll-step" = 5;
          format = "{icon} {volume}%";
          "format-muted" = "{icon} {volume}%";
          "on-click" = "wpctl set-mute @DEFAULT_AUDIO_SINK@ toggle";
          "format-icons" = {
            default = [
              ""
              ""
              ""
            ];
          };
        };
        network = {
          tooltip = false;
          "format-wifi" = "  {essid}";
          "format-ethernet" = "󰈀 {ifname} | {bandwidthUpBytes} {bandwidthDownBytes}";
        };
        backlight = {
          tooltip = false;
          format = " {}%";
          interval = 1;
          "on-scroll-up" = "brightnessctl --class=backlight set +5%";
          "on-scroll-down" = "brightnessctl --class=backlight set 5%-";
        };
        battery = {
          states = {
            good = 95;
            warning = 30;
            critical = 10;
          };
          format = "{icon}  {capacity}%";
          "format-charging" = "  {capacity}%";
          "format-plugged" = "  {capacity}%";
          "format-icons" = [
            ""
            ""
            ""
            ""
            ""
          ];
        };
        tray = {
          "icon-size" = 18;
          spacing = 10;
        };
        clock = {
          format = "{:%I:%M  %Y-%m-%d}";
          tooltip = false;
        };
        cpu = {
          interval = 15;
          format = "  {usage}%";
          "max-length" = 10;
        };
        memory = {
          interval = 15;
          format = "  {}%";
          "max-length" = 10;
        };
        bluetooth = {
          format = " {status}";
          "format-connected" = " {device_alias}";
          "format-connected-battery" = " {device_alias} {device_battery_percentage}%";
          "tooltip-format" = "{controller_alias}\t{controller_address}\n\n{num_connections} connected";
          "tooltip-format-connected" =
            "{controller_alias}\t{controller_address}\n\n{num_connections} connected\n\n{device_enumerate}";
          "tooltip-format-enumerate-connected" = "{device_alias}\t{device_address}";
          "tooltip-format-enumerate-connected-battery" =
            "{device_alias}\t{device_address}\t{device_battery_percentage}%";
          "on-click" = "blueman-manager";
        };
        "custom/launcher" = {
          format = "∞";
          "on-click" = "fuzzel";
          "on-click-right" = "killall fuzzel";
        };
        "custom/power" = {
          format = "⏻";
          "on-click" = "nwg-bar";
        };
        user = {
          format = "{user}";
          interval = 60;
          height = 30;
          width = 30;
          icon = true;
          "on-click" = "fuzzel";
          "on-click-right" = "killall fuzzel";
        };
        "custom/notifications" = {
          format = "";
        };
        "niri/workspaces" = {
          format = "{icon}";
          "format-icons" = {
            active = "";
            default = "";
          };
        };
        "power-profiles-daemon" = {
          format = "{icon}";
          "tooltip-format" = "Power profile: {profile}\nDriver: {driver}";
          tooltip = true;
          "format-icons" = {
            default = "";
            performance = "";
            balanced = "";
            "power-saver" = "";
          };
        };
        "custom/music" = {
          exec = builtins.readFile ./spotify.sh;
          interval = 2;
          "on-click" = "playerctl play-pause";
          "on-scroll-up" = "playerctl next";
          "on-scroll-down" = "playerctl previous";
        };
      };
    };

    style = cssBase16Colors + (builtins.readFile ./style.css);
  };
}
