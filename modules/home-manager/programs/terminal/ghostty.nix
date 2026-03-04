{
  configFile,
  config,
  pkgs,
  ...
}:
{
  programs.ghostty = {
    enable = true;

    settings = {
      font-size = 10;

      cursor-style = "bar";
      cursor-style-blink = false;

      command = "nu";

      maximize = configFile.desktop.environment != "niri";
    };
  };
}
