{ configFile, ... }:
{
  input = {
    keyboard = {
      xkb = {
        layout = "${configFile.hardware.keyboard.layout},${configFile.hardware.keyboard.variant}";
        options = "";
      };
    };

    touchpad = {
      tap = true;
      natural-scroll = true;
      scroll-factor = 0.2;
      accel-speed = -0.09;
    };

    mouse = {
      accel-profile = "flat";
    };
  };

  cursor = {
    size = 16;
  };
}
