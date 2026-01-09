{ lib, ... }:
{
  options.wallpaper = lib.mkOption {
    type = lib.types.path;
    default = ./image.jpg;
    readOnly = true;
  };
}
