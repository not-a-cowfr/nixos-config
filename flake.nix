{
  description = "my nix config";
  inputs = {
    # packages stuff
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    nixpkgs-stable.url = "github:nixos/nixpkgs/nixos-25.11";
    # nixos-hardware.url = "github:nixos/nixos-hardware";

    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    nix-flatpak.url = "github:gmodena/nix-flatpak";

    # desktop environment/window manager configs
    plasma-manager = {
      url = "github:AlexNabokikh/plasma-manager";
      inputs.nixpkgs.follows = "nixpkgs";
      inputs.home-manager.follows = "home-manager";
    };

    cosmic-manager = {
      url = "github:HeitorAugustoLN/cosmic-manager";
      inputs.nixpkgs.follows = "nixpkgs";
      inputs.home-manager.follows = "home-manager";
    };

    hyprland = {
      url = "github:hyprwm/Hyprland";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    # addons
    nix-cachyos-kernel.url = "github:xddxdd/nix-cachyos-kernel";

    # apps
    zen-browser = {
      url = "github:0xc000022070/zen-browser-flake/beta";
      inputs.nixpkgs.follows = "nixpkgs";
      inputs.home-manager.follows = "home-manager";
    };

    spicetify-nix.url = "github:Gerg-L/spicetify-nix";

    # needs to be in this format for submodules to work
    # using my fork because new branch doesnt have flake support and legacy branch has a bug
    millennium.url = "git+https://github.com/not-a-cowfr/Millennium.git";

    # services
    nix-minecraft.url = "github:Infinidoge/nix-minecraft";

    rust-overlay = {
      url = "github:oxalica/rust-overlay";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs =
    {
      self,
      nixpkgs,
      home-manager,
      ...
    }@inputs:
    let
      inherit (self) outputs;

      config = builtins.fromTOML (builtins.readFile ./config.toml);
      hostname = config.computer.host;

      system = "x86_64-linux";

      mkUser = username: fullName: {
        ${username} = {
          name = username;
          inherit fullName;
          avatar = ./assets/avatars/${username};
        };
      };

      allUsers = nixpkgs.lib.foldl' nixpkgs.lib.recursiveUpdate { } [
        (mkUser "andrew" "Andrew Gielow")
      ];

      enabledUsers = nixpkgs.lib.filterAttrs (name: _: builtins.elem name config.computer.users) allUsers;

      mkNixosConfiguration =
        hostname:
        nixpkgs.lib.nixosSystem {
          specialArgs = {
            inherit
              inputs
              outputs
              hostname
              enabledUsers
              config
              ;
            nixosModules = ./modules/nixos;
          };
          modules = [ ./hosts/${hostname} ];
        };

      mkHomeConfiguration =
        username: hostname:
        home-manager.lib.homeManagerConfiguration {
          pkgs = import nixpkgs { inherit system; };
          extraSpecialArgs = {
            inherit inputs outputs config;
            userConfig = enabledUsers.${username};
            nhModules = "${self}/modules/home-manager";
          };
          modules = [
            ./home/${username}
          ];
        };
    in
    {
      nixosConfigurations = {
        ${hostname} = mkNixosConfiguration hostname;
      };

      homeConfigurations = nixpkgs.lib.listToAttrs (
        map (username: {
          name = "${username}@${hostname}";
          value = mkHomeConfiguration username hostname;
        }) config.computer.users
      );

      overlays = import ./overlays { inherit inputs; };
    };
}
