{ pkgs, lib, ... }:
{
  programs.git = {
    enable = true;

    settings = {
      # todo: dont hardcode user info
      user = {
        name = "not a cow";
        email = "104355555+not-a-cowfr@users.noreply.github.com";
      };

      pull.rebase = true;
      push.autoSetupRemote = true;

      init.defaultBranch = "main";
      credential.helper = "store";

      safe.directory = [ "/etc/nixos" ];
    };
  };
}
