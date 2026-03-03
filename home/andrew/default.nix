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
    "${nhModules}/programs/music/spicetify.nix"
    "${nhModules}/programs/programming/languages/rust.nix"
    "${nhModules}/programs/programming/languages/typescript.nix"
    "${nhModules}/programs/programming/languages/python.nix"
    "${nhModules}/programs/programming/git"
    "${nhModules}/programs/programming/git/lazygit.nix"
    "${nhModules}/programs/programming/git/github.nix"
    "${nhModules}/programs/programming/ide/vscodium.nix"
    "${nhModules}/programs/programming/ide/idea.nix"
    "${nhModules}/programs/programming/ide/vim.nix"
    # "${nhModules}/programs/razer"
    "${nhModules}/programs/shell/nushell"
    "${nhModules}/programs/terminal/ghostty.nix"
    "${nhModules}/programs/discord/equicord.nix"
  ];

  home.packages = with pkgs; [
    protonmail-desktop
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
