To add a user first add them to the `allUsers` var in [flake.nix](../flake.nix)

Then add the username to the `computer.users` key in [config.toml](../config.toml)

Finally, add a nix config file in `/home/<username>/default.nix`, you can use other user configs for reference
