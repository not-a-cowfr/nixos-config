# My NixOS config

Decided to move my nixos config to its own repo

I hope that this repo will be readable enough for someone to use as reference when making their own config

# Organization

| path        | purpose                                     |
| ----------- | ------------------------------------------- |
| `assets/`   | assets like images or showcase videos       |
| `hosts/`    | configs for different computers             |
| `home/`     | configs for different users                 |
| `modules/`  | reusable modules for home-manager and nixos |
| `overlays/` | custom nixpkgs overlays                     |

# Installing

```bash
sudo nix-shell -p curl git --run "curl -fsSL https://raw.githubusercontent.com/not-a-cowfr/nixos-config/refs/heads/main/install.sh | bash"
```

# TODO

### for repo

- [ ] comment stuff more to make it readable for other people
- [x] add script that will set up this as your config, with options to select which home and host config to use
  - [ ] script needs to like update flake.nix based on chosen host and home configs idk this a problem for future me, right now its not a problem since theres only one user and host though

### for config

- [ ] try out switching from ext4 to btrfs
- [ ] make a niri config
- [ ] convert my equicord json config to nixcord nix config
- [x] get milennium for steam working
- [ ] sort programs stuff into categories that are easy to enable/disable different parts
