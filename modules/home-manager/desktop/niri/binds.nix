{ config, ... }:
{
  binds = with config.lib.niri.actions; {
    "Mod+T".action = spawn "ghostty";
    "Mod+L".action = spawn "hyprlock";
    "Mod+E".action = spawn "dolphin";
    "Alt+Space".action = spawn "fuzzel";
    "Ctrl+Shift+Escape".action = spawn "btop";

    XF86AudioMicMute = {
      allow-when-locked = true;
      action = spawn "wpctl" "set-mute" "@DEFAULT_AUDIO_SOURCE@" "toggle";
    };
    XF86AudioRaiseVolume = {
      allow-when-locked = true;
      action = spawn "wpctl" "set-volume" "@DEFAULT_AUDIO_SINK@" "0.1+" "-l" "1.0";
    };
    XF86AudioLowerVolume = {
      allow-when-locked = true;
      action = spawn "wpctl" "set-volume" "@DEFAULT_AUDIO_SINK@" "0.1-";
    };
    XF86AudioMute = {
      allow-when-locked = true;
      action = spawn "wpctl" "set-mute" "@DEFAULT_AUDIO_SINK@" "toggle";
    };

    XF86MonBrightnessUp = {
      allow-when-locked = true;
      action = spawn "brightnessctl" "--class=backlight" "set" "+10%";
    };
    XF86MonBrightnessDown = {
      allow-when-locked = true;
      action = spawn "brightnessctl" "--class=backlight" "set" "10%-";
    };

    "Ctrl+Q" = {
      action = close-window;
      repeat = false;
    };

    "Ctrl+Mod+Up".action = focus-window-or-workspace-up;
    "Ctrl+Mod+Left".action = focus-column-left;
    "Ctrl+Mod+Down".action = focus-window-or-workspace-down;
    "Ctrl+Mod+Right".action = focus-column-right;

    "Mod+Up".action = move-column-to-workspace-up;
    "Mod+Left".action = move-column-left;
    "Mod+Down".action = move-column-to-workspace-down;
    "Mod+Right".action = move-column-right;

    "Mod+Alt+Up".action = focus-monitor-up;
    "Mod+Alt+Left".action = focus-monitor-left;
    "Mod+Alt+Down".action = focus-monitor-down;
    "Mod+Alt+Right".action = focus-monitor-right;

    "Mod+Alt+Ctrl+Up".action = move-column-to-monitor-up;
    "Mod+Alt+Ctrl+Left".action = move-column-to-monitor-left;
    "Mod+Alt+Ctrl+Down".action = move-column-to-monitor-down;
    "Mod+Alt+Ctrl+Right".action = move-column-to-monitor-right;

    "Mod+Tab".action = toggle-overview;
    "Mod+G".action = consume-or-expel-window-left;
    "Mod+H".action = consume-or-expel-window-right;

    "Mod+Shift+G".action = consume-window-into-column;
    "Mod+Shift+H".action = expel-window-from-column;

    "Mod+R".action = switch-preset-column-width;
    "Mod+Shift+R".action = switch-preset-window-height;
    "Mod+Ctrl+R".action = reset-window-height;

    "Mod+F".action = maximize-column;
    "Mod+Shift+F".action = fullscreen-window;
    "Mod+Ctrl+F".action = expand-column-to-available-width;

    "Mod+Shift+Up".action = set-window-height "-10%";
    "Mod+Shift+Left".action = set-window-width "-10%";
    "Mod+Shift+Down".action = set-window-height "+10%";
    "Mod+Shift+Right".action = set-window-width "+10%";

    "Mod+V".action = toggle-window-floating;
    "Mod+Shift+V".action = switch-focus-between-floating-and-tiling;

    "Print".action = spawn "grimshot" "--notify" "savecopy" "output";
    "Mod+Shift+S".action = spawn "grimshot" "--notify" "savecopy" "area";

    "Mod+Escape" = {
      allow-inhibiting = false;
      action = toggle-keyboard-shortcuts-inhibit;
    };
  };
}
