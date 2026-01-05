{ pkgs, ... }:
{
  services.displayManager.sddm = {
    enable = true;
    enableHidpi = true;
    wayland.enable = true;
  };
  services.desktopManager.plasma6.enable = true;

  environment.plasma6.excludePackages = with pkgs.kdePackages; [
    baloo-widgets
    elisa
    ffmpegthumbs
    # kate
    khelpcenter
    # konsole # sometimes ghosty service gets reset when switching home-manager so this is a backup
    krdp
    plasma-browser-integration
  ];

  systemd.user.services = {
    "app-org.kde.discover.notifier@autostart".enable = false;
    "app-org.kde.kalendarac@autostart".enable = false;
  };
}
