# My NixOS config

![wakatime](https://wakatime.com/badge/github/not-a-cowfr/nixos-config.svg)

Decided to move my nixos config to its own repo

I hope that this repo will be readable enough for someone to use as reference when making their own config

Some thing are easily configurabe via [config.toml] file, but other things like software you will have to go in to the nix config for your user and change manually
I think this is the best way because if every bit of software was configurable from the config.toml file it would be just as much effort to even know what to change as to just go in and add/remove what you want
plus, the config.toml would be so overly complex if you want to configure different users idividually
thats why im keeping to system-wide configurations like desktop environment, hostname, and what users to include

<!-- > [!CAUTION]
> This config uses disko so using this to install nixos will wipe your disk -->

# Organization

| path        | purpose                                     |
| ----------- | ------------------------------------------- |
| `assets/`   | assets like images or showcase videos       |
| `hosts/`    | configs for different computers             |
| `home/`     | configs for different users                 |
| `modules/`  | reusable modules for home-manager and nixos |
| `overlays/` | custom nixpkgs overlays                     |

<!-- # Installing

```bash
sudo nix-shell -p curl git vim tomlq --run "curl -fsSL https://not-a-cowfr.github.io/nixos-config/install.sh | bash"
``` -->

# TODO

### for repo

- [ ] comment stuff more to make it readable for other people
- [ ] add script that will set up this as your config, with options to select which home and host config to use (check `install-script` branch for updates)

### for config

- [x] try out switching from ext4 to btrfs
- [x] make a niri config
- [ ] convert my equicord json config to nixcord nix config
- [x] get milennium for steam working
- [x] sort programs stuff into categories that are easy to enable/disable different parts

[config.toml]: ./config.toml
