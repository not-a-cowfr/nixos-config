{ inputs, lib, ... }:
{
  imports = [
    inputs.nixcord.homeModules.nixcord
  ];

  programs.nixcord = {
    enable = true;
    equibop.enable = true;
    discord.enable = false;

    quickCss = lib.strings.trim (builtins.readFile ./quickCss.css);
    config = {
      autoUpdate = true;
      autoUpdateNotification = true;
      # eagerPatches = false;
      enabledThemes = [ ];
      # enabledThemeLinks = [];
      # themeNames = {};
      enableReactDevtools = false;
      frameless = false;
      transparent = false;
      # winCtrlQ = false;
      disableMinSize = false;
      # winNativeTitleBar = false;
      plugins = {
        copyFileContents.enable = true;
        crashHandler.enable = true;
        favoriteGifSearch.enable = true;
        messageClickActions.enable = true;
        messageLogger.enable = true;
        musicControls.enable = true;
        polishWording.enable = true;
        spotifyCrack.enable = true;
        spotifyShareCommands.enable = true;
        validReply.enable = true;
        webScreenShareFixes.enable = true;
      };
    };
  };
}
