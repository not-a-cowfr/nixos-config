{ config, lib, ... }:
let
  cfg = config.features.programs.hypr.idle;
in
{
  options.features.programs.hypr.idle = {
    enable = lib.mkEnableOption "hypridle";
    timeout = lib.mkOption {
      type = lib.types.int;
      default = 300;
      description = "time in seconds before hyprlock activates, after double this time the system will suspend";
    };
  };

  config = lib.mkIf cfg.enable {
    services.hypridle = {
      enable = true;
      settings = {
        general = {
          ignore_dbus_inhibit = false;
          lock_cmd = "hyprlock";
          before_sleep_cmd = "loginctl lock-session";
          after_sleep_cmd = "hyprctl dispatch dpms on";
        };
        listener = [
          {
            timeout = cfg.timeout;
            on-timeout = "hyprlock";
          }
          {
            timeout = cfg.timeout * 2;
            on-timeout = "systemctl suspend";
          }
        ];
      };
    };
  };
}
