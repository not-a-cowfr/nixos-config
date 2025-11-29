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

# TODO

- [ ] comment stuff more to make it readable for other people
- [ ] add script that will set up this as your config, with options to select which home and host config to use
