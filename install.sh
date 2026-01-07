#!/usr/bin/env bash
set -euo pipefail

REPO_URL="https://github.com/not-a-cowfr/nixos-config.git"
REPO_DIR="/tmp/nixos-config"
ETC_DIR="/etc/nixos"
BACKUP_DIR="/etc/nixos_config_backup"
CONFIG_FILE="$ETC_DIR/config.toml"

echo "cloning repo"
rm -rf "$REPO_DIR"
git clone "$REPO_URL" "$REPO_DIR"

echo "copying your current hardware-configuration.nix"
CURRENT_HW=$(mktemp)
find $ETC_DIR -name "hardware-configuration.nix" -exec cp "{}" "$CURRENT_HW" \;

if [ ! -s "$CURRENT_HW" ]; then
    echo "did not find hardware-configuration.nix in $ETC_DIR"
    exit 1
fi

echo "deleting $ETC_DIR (saving your old config to $BACKUP_DIR)"
mkdir -p $BACKUP_DIR
cp -r $ETC_DIR/* $BACKUP_DIR
rm -rf $ETC_DIR

echo "copying repo to $ETC_DIR"
mkdir $ETC_DIR
cp -r $REPO_DIR/* $ETC_DIR/

echo "deleting unnecessary files"
rm $ETC_DIR/LICENSE $ETC_DIR/README.md $ETC_DIR/install.sh

echo "enabling flakes if needed"
mkdir -p /etc/nix
if ! grep -q "experimental-features" /etc/nix/nix.conf 2>/dev/null; then
    echo "experimental-features = nix-command flakes" >> /etc/nix/nix.conf
fi

echo -e "edit the config to match what you like\n"
echo -e "available hosts:\n$(find "$ETC_DIR/hosts" -maxdepth 1 -mindepth 1 -type d -printf "%f\n" | grep -v common)\n"
echo -e "available users:\n$(find "$ETC_DIR/home" -maxdepth 1 -mindepth 1 -type d -printf "%f\n" | grep -v common)\n"
echo -e "available desktop environments:\n$(find $ETC_DIR/modules/nixos/desktop -maxdepth 1 -mindepth 1 -type d -printf "%f\n")\n"
sleep 1
vim $CONFIG_FILE </dev/tty >/dev/tty 2>/dev/tty

HOST=$(tq -f $CONFIG_FILE -r "computer.host")
USERS_JSON=$(tq -f $CONFIG_FILE "computer.users")
readarray -t USERS < <(echo "$USERS_JSON" | jq -r ".[]")

echo "Selected host: $HOST"
echo "Selected users: ${USERS[*]}"

echo "copying your hardware-configuration.nix"
cp -f $CURRENT_HW "$ETC_DIR/hosts/$HOST/hardware-configuration.nix"

echo "rebuilding nixos"
nixos-rebuild switch --flake "$ETC_DIR#$HOST"

for USER in "${USERS[@]}"; do
    echo "running home-manager switch for $USER@$HOST"
    home-manager switch --flake "$ETC_DIR#$USER@$HOST"
done
