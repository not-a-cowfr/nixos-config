#!/usr/bin/env nu

const REPO_URL = "https://github.com/not-a-cowfr/nixos-config.git"
const TARGET_DIR = "/mnt/etc/nixos"
const CONFIG_FILE = "/mnt/etc/nixos/config.toml"

let mounted = (mountpoint -q /mnt | complete).exit_code
if $mounted != 0 {
    print "/mnt is not mounted"
    print "are you sure you're running this from a NixOS installer live boot environment?"
    exit 1
}

let PART = lsblk | detect columns --guess | where TYPE == part | get NAME | str replace -ra "\\W" "" | input list "Select partition to use"
let ESP_PART = lsblk | detect columns --guess | where TYPE == part | get NAME | str replace -ra "\\W" "" | append "none" | input list "Select EFI partition to use"

sed -i $"s|__ROOT_PART__|($PART)|" $"($TARGET_DIR)/modules/nixos/services/disko/btrfs.nix"
if $ESP_PART != "none" {
    sed -i $"s|__ESP_PART__|($ESP_PART)|" $"($TARGET_DIR)/modules/nixos/services/disko/btrfs.nix"
} else {
    sed -i $"s|__ESP_PART__|null|" $"($TARGET_DIR)/modules/nixos/services/disko/btrfs.nix"
}

print "\nIMPORTANT: this will erase the target partition"

if ((input "Type YES in all caps to continue: ") != "YES") {
    print "aborted"
    exit 1
}

print "cloning repo"
rm -rf $TARGET_DIR
git clone $REPO_URL $TARGET_DIR

print "deleting unnecessary files"
rm -f $"($TARGET_DIR)/LICENSE" $"($TARGET_DIR)/README.md" $"($TARGET_DIR)/install.nu" $"($TARGET_DIR)/install-clean.nu"

print "enabling flakes"
mkdir /mnt/etc/nix
if (grep experimental-features /mnt/etc/nix/nix.conf | complete).exit_code != 0 {
    "experimental-features = nix-command flakes" | save -a /mnt/etc/nix/nix.conf
}

print "edit the config to match what you like\n"

print "available hosts:"
ls $"($TARGET_DIR)/hosts" -s | where name !~ "common" | where type == "dir" | get name | str join ", "

print "\navailable users:"
ls $"($TARGET_DIR)/home" -s | where name !~ "common" | where type == "dir" | get name | str join ", "

print "\navailable desktop environments:"
ls $"($TARGET_DIR)/modules/nixos/desktop" -s | where type == "dir" | get name | str join ", "

sleep 5sec
vim $CONFIG_FILE </dev/tty >/dev/tty 2>/dev/tty

let HOST = open $CONFIG_FILE | get computer.host

print $"Selected host: ($HOST)"

print "generating hardware-configuration.nix"
nixos-generate-config --root /mnt --no-filesystems

cp /mnt/etc/nixos/hardware-configuration.nix $"($TARGET_DIR)/hosts/($HOST)/hardware-configuration.nix"

print "running nixos-install"
nixos-install --flake $"($TARGET_DIR)#($HOST)"
