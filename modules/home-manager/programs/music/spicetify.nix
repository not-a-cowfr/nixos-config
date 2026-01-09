{
  inputs,
  pkgs,
  ...
}:
let
  spicePkgs = inputs.spicetify-nix.legacyPackages.${pkgs.stdenv.system};
in
{
  imports = [
    inputs.spicetify-nix.homeManagerModules.spicetify
  ];

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
