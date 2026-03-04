{
  lib,
  config,
  configFile,
  ...
}:
{
  programs.hyprlock = {
    enable = true;
    settings = {
      ignore_empty_input = true;

      label = {
        text = "$TIME";
        font_size = 65;
        font_family = "Cantarell Bold";

        position = "0, 0";
        halign = "center";
        valign = "center";
      };

      input-field = {
        size = "250, 50";
        position = "0, -80";
        outline_thickness = 0;
        placeholder_text = "";
      };
    };
  };
}
