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
    };

    mouse = {
      accel-profile = "flat";
    };
  };
}
