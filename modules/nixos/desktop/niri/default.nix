{
  config,
  inputs,
  pkgs,
  ...
}:
{
  imports = [
    inputs.niri.nixosModules.niri
  ];

  nixpkgs.overlays = [
    inputs.niri.overlays.niri
    (_: prev: {
      niri-unstable-patched = prev.niri-unstable.overrideAttrs (old: {
        patches = (old.patches or [ ]) ++ [
          ./transparent-fullscreen.patch
        ];
        patchFlags = [ "-p1" "--forward" "--fuzz=3" ];
      });
    })
  ];

  programs.niri = {
    enable = true;
    package = pkgs.niri-unstable-patched;
  };

  services.displayManager = {
    gdm = {
      enable = true;
      wayland = true;
    };
  };
}
