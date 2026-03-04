{
  inputs,
  lib,
  config,
  ...
}:
{
  imports = [
    inputs.nixcord.homeModules.nixcord
  ];

  stylix.targets.nixcord.enable = false;

  programs.nixcord = {
    enable = true;
    equibop.enable = true;
    discord.enable = false;

    quickCss = lib.strings.trim (builtins.readFile ./quickCss.css);
    config = {
      autoUpdate = false;
      autoUpdateNotification = false;
      # eagerPatches = false;
      enabledThemes = [ ];
      # enabledThemeLinks = [];
      # themeNames = {};
      enableReactDevtools = false;
      frameless = false;
      transparent = true;
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

  # equibop settings
  home.file."${config.home.homeDirectory}/.config/equibop/settings.json".text = builtins.toJSON {
    discordBranch = "canary";
    tray = true;
    minimizeToTray = true;
    arRPC = true;
    trayColor = "";
    trayMainOverride = false;
    spellCheckLanguages = [
      "en-US"
      "en"
    ];
    enableSplashScreen = true;
    splashProgress = true;
    clickTrayToShowHide = true;
    badgeOnlyForMentions = true;
    openLinksWithElectron = false;
  };
}
