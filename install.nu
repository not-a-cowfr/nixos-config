#!/usr/bin/env nu

const REPO_URL = "https://github.com/not-a-cowfr/nixos-config.git"
const REPO_DIR = "/tmp/nixos-config"
const ETC_DIR = "/etc/nixos"
const BACKUP_DIR = "/etc/nixos_config_backup"
const CONFIG_FILE = $"($ETC_DIR)/config.toml"

print "cloning repo"
rm -rf $REPO_DIR
git clone $REPO_URL $REPO_DIR

print "copying your current hardware-configuration.nix"
let current_hw = mktemp -d
let hw_files = ls $"($ETC_DIR)/*" | where name == "hardware-configuration.nix" | get path
if ($hw_files | length) == 0 { error make { msg: "did not find hardware-configuration.nix in $ETC_DIR" } }
cp ($hw_files.0) $current_hw

print $"deleting ($ETC_DIR) \(saving your old config to ($BACKUP_DIR)\)"
mkdir $BACKUP_DIR
cp -r $"($ETC_DIR)/*" $BACKUP_DIR
rm -rf $ETC_DIR

print $"copying repo to ($ETC_DIR)"
mkdir $ETC_DIR
cp -r $"($REPO_DIR)/*" $ETC_DIR

print "deleting unnecessary files"
rm -f $"($ETC_DIR)/LICENSE" $"($ETC_DIR)/README.md" $"($ETC_DIR)/install.nu" $"($ETC_DIR)/install-clean.nu"

print "enabling flakes if needed"
mkdir /etc/nix
if (grep "experimental-features" /etc/nix/nix.conf | complete).exit_code != 0 {
    "experimental-features = nix-command flakes" | save -a /etc/nix/nix.conf
}

print "edit the config to match what you like\n"

print "available hosts:"
ls $"($ETC_DIR)/hosts" -s | where type == "dir" | where name !~ "common" | get name | str join ", "

print "\navailable users:"
ls $"($ETC_DIR)/home" -s | where type == "dir" | where name !~ "common" | get name | str join ", "

print "\navailable desktop environments:"
ls $"($ETC_DIR)/modules/nixos/desktop" -s | where type == "dir" | get name | str join ", "

sleep 5sec
vim $CONFIG_FILE </dev/tty >/dev/tty 2>/dev/tty

let HOST = open $CONFIG_FILE | get computer.host
let USERS = open $CONFIG_FILE | get computer.users | from json

print $"Selected host: ($HOST)"
print $"Selected users: ($USERS | str join ", ")"

print "copying your hardware-configuration.nix"
cp -f $current_hw $"($ETC_DIR)/hosts/($HOST)/hardware-configuration.nix"

print "rebuilding nixos"
nixos-rebuild switch --flake $"($ETC_DIR)#($HOST)"

for USER in $USERS {
    print $"running home-manager switch for ($USER)@$HOST"
    home-manager switch --flake $"($ETC_DIR)#($USER)@$HOST"
}
