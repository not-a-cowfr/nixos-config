{ config, pkgs, lib, ... }:
let
  cfg = config.features.programs.games.kerbal-space-program;

  ksp = pkgs.writeShellScriptBin "ksp" ''
    GAME_EXE="${cfg.gameDir}/KSP_x64.exe"
    PROTON_ROOT="$HOME/.proton/KSP_x64.exe"
    STEAM_ROOT="$HOME/.steam/root"

    cd "${cfg.gameDir}"
    mkdir -p "$PROTON_ROOT"

    STEAM_COMPAT_DATA_PATH="$PROTON_ROOT" \
    STEAM_COMPAT_CLIENT_INSTALL_PATH="$STEAM_ROOT" \
      steam-run "$STEAM_ROOT/steamapps/common/Proton - Experimental/proton" run "$GAME_EXE"
  '';
in
{
  options.features.programs.games.kerbal-space-program = {
    enable = lib.mkEnableOption "Kerbal Space Program";
    gameDir = lib.mkOption {
      type = lib.types.path;
      description = "Path to the Kerbal Space Program root directory containing KSP_x64.exe";
    };
  };

  config = lib.mkIf cfg.enable {
    home.packages = [ ksp pkgs.ckan ];

    home.file.".local/share/applications/ksp.desktop" = {
      text = ''
        [Desktop Entry]
        Name=Kerbal Space Program
        GenericName=Space Simulator
        Exec=${ksp}/bin/ksp
        Icon=${cfg.gameDir}/icon.png
        Type=Application
        Categories=Game;Simulation;
        StartupNotify=false
        Terminal=false
      '';
    };
  };
}