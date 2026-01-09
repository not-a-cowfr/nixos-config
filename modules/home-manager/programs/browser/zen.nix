{ inputs, pkgs, ... }:
{
  home.packages = [
    inputs.zen-browser.packages."${pkgs.system}".twilight
  ];

  home.sessionVariables = {
    BROWSER = "zen";
  };
}
