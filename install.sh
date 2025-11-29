#!/usr/bin/env bash
set -euo pipefail

REPO_URL="https://github.com/not-a-cowfr/nixos-config.git"
REPO_DIR="/tmp/nixos-config"
ETC_DIR="/etc/nixos"
BACKUP_DIR="/etc/nixos_config_backup"

echo 'cloning repo'
rm -rf "$REPO_DIR"
git clone "$REPO_URL" "$REPO_DIR"

echo 'copying your current hardware-configuration.nix'
CURRENT_HW=$(mktemp)
find $ETC_DIR -maxdepth 1 -name 'hardware-configuration.nix' -exec cp '{}' "$CURRENT_HW" \;

if [ ! -f "$CURRENT_HW" ]; then
    echo 'did not find hardware-configuration.nix in $ETC_DIR'
    exit 1
fi

echo 'deleting $ETC_DIR (saving your old config to $BACKUP_DIR)'
mkdir -p $BACKUP_DIR
cp -r $ETC_DIR/* "$BACKUP_DIR" 2>/dev/null || true
find "$ETC_DIR" -mindepth 1 -maxdepth 1 -exec rm -rf {} +

echo 'copying repo to $ETC_DIR'
cp -r "$REPO_DIR"/* "$ETC_DIR"/

echo 'finding available home configs'
mapfile -t USERS < <(find "$ETC_DIR/home" -maxdepth 1 -mindepth 1 -type d -printf "%f\n" | grep -v "^common$")

if [ ${#USERS[@]} -eq 0 ]; then
    echo "no users found in $ETC_DIR/home"
    exit 1
fi

echo 'available users:'
for i in "${!USERS[@]}"; do
    echo "  [$i] ${USERS[$i]}"
done

while true; do
    read -p "select user by its number: " USER_INDEX </dev/tty
    if [[ "$USER_INDEX" =~ ^[0-9]+$ ]] && [ "$USER_INDEX" -lt "${#USERS[@]}" ]; then
        break
    fi
    echo "invalid selection"
done

USER="${USERS[$USER_INDEX]}"
echo "selected: $USER"

echo 'finding available host configs'
mapfile -t HOSTS < <(find "$ETC_DIR/hosts" -maxdepth 1 -mindepth 1 -type d -printf "%f\n" | grep -v "^common$")

if [ ${#HOSTS[@]} -eq 0 ]; then
    echo "no hosts found in $ETC_DIR/hosts"
    exit 1
fi

echo 'available hosts:'
for i in "${!HOSTS[@]}"; do
    echo "  [$i] ${HOSTS[$i]}"
done

while true; do
    read -p "select host by its number: " HOST_INDEX </dev/tty
    if [[ "$HOST_INDEX" =~ ^[0-9]+$ ]] && [ "$HOST_INDEX" -lt "${#HOSTS[@]}" ]; then
        break
    fi
    echo "invalid selection"
done

HOST="${HOSTS[$HOST_INDEX]}"
echo "selected: $HOST"

echo 'copying your hardware-configuration.nix'
cp -f "$CURRENT_HW" "$ETC_DIR/hosts/$HOST/hardware-configuration.nix"

echo 'deleting unnecessary files'
rm $ETC_DIR/LICENSE $ETC_DIR/README.md $ETC_DIR/install.sh

echo 'enabling flakes + home-manager if needed'
mkdir -p /etc/nix
if ! grep -q 'experimental-features' /etc/nix/nix.conf 2>/dev/null; then
    echo "experimental-features = nix-command flakes" >> /etc/nix/nix.conf
fi

echo 'rebuilding nixos'
nixos-rebuild switch --flake "$ETC_DIR#$HOST"

echo 'running home-manager switch'
home-manager switch --flake "$ETC_DIR#$USER@$HOST"
