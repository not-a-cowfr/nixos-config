{
  nhModules,
  pkgs,
  inputs,
  ...
}:
{
  imports = [
    "${nhModules}/programs/browser/zen.nix"
    "${nhModules}/programs/cli/bat.nix"
    "${nhModules}/programs/cli/direnv.nix"
    "${nhModules}/programs/cli/starship.nix"
    "${nhModules}/programs/git"
    "${nhModules}/programs/ide/vscodium.nix"
    "${nhModules}/programs/ide/idea.nix"
    "${nhModules}/programs/ide/vim.nix"
    "${nhModules}/programs/music/spicetify.nix"
    "${nhModules}/programs/programming/languages/rust.nix"
    "${nhModules}/programs/programming/languages/typescript.nix"
    "${nhModules}/programs/programming/languages/python.nix"
    "${nhModules}/programs/programming/github.nix"
    # "${nhModules}/programs/razer"
    "${nhModules}/programs/shell/nushell"
    "${nhModules}/programs/terminal/ghostty.nix"
    "${nhModules}/programs/discord/equicord.nix"
  ];

  home.packages = with pkgs; [
    vlc
    prismlauncher
    zoom-us
    stoat-desktop
    nixfmt
    gparted
    kdePackages.isoimagewriter
    localsend
  ];
}
