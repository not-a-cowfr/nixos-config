{
  inputs,
  pkgs,
  lib,
  ...
}:
let
  spicePkgs = inputs.spicetify-nix.legacyPackages.${pkgs.stdenv.system};
in
{
  imports = [
    inputs.spicetify-nix.homeManagerModules.spicetify
  ];

  stylix.targets.spicetify.colors.enable = false;

  programs.spicetify = {
    enable = true;

    theme = spicePkgs.themes.lucid;

    enabledExtensions = with spicePkgs.extensions; [
      keyboardShortcut
      shuffle
      groupSession
      seekSong
      playlistIcons
      fullAlbumDate
      skipStats
      copyToClipboard
      betterGenres
      adblock
      playNext
      beautifulLyrics
      queueTime
      coverAmbience
    ];
  };
}
