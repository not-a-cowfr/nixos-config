{
  pkgs,
  lib,
  config,
  ...
}:
let
  cfg = config.features.programs.programming.git;
in
{
  imports = [
    ./github
    ./lazygit.nix
  ];

  options.features.programs.programming.git = {
    enable = lib.mkEnableOption "git";

    username = lib.mkOption {
      type = lib.types.str;
      description = "name to sign commits with";
    };
    email = lib.mkOption {
      type = lib.types.str;
      description = "email to sign commits with";
    };
  };

  config = lib.mkIf cfg.enable {
    programs.git = {
      enable = true;
      lfs.enable = true;

      settings = {
        # todo: dont hardcode user info
        user = {
          name = cfg.username;
          email = cfg.email;
        };

        pull.rebase = true;
        push.autoSetupRemote = true;

        init.defaultBranch = "main";
        credential.helper = "store";

        safe.directory = [ "/etc/nixos" ];
      };
    };
  };
}
