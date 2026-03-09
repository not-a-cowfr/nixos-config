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

    niri = {
      url = "github:sodiboo/niri-flake";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    # addons
    nix-cachyos-kernel.url = "github:xddxdd/nix-cachyos-kernel/58f338b00bc5619144a6f3082eed5c83e79b279b";

    # apps
    zen-browser = {
      url = "github:0xc000022070/zen-browser-flake/beta";
      inputs.nixpkgs.follows = "nixpkgs";
      inputs.home-manager.follows = "home-manager";
    };

    spicetify-nix.url = "github:Gerg-L/spicetify-nix";
    nixcord.url = "github:FlameFlag/nixcord";
    # when #624 gets merged change this from trivaris to SteamClientHomebrew
    millennium.url = "github:trivaris/millennium?dir=packages/nix";

    # services
    stylix = {
      url = "github:nix-community/stylix";
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

      # read and parse config file
      configFile = builtins.fromTOML (builtins.readFile ./config.toml);
      hostname = configFile.computer.host;

      # function for easily defining new users
      mkUser = username: fullName: {
        ${username} = {
          name = username;
          inherit fullName;
          avatar = ./assets/avatars/${username};
        };
      };

      # add users here as shown
      allUsers = nixpkgs.lib.foldl' nixpkgs.lib.recursiveUpdate { } [
        (mkUser "andrew" "Andrew Gielow")
      ];

      # filter only users enabled in the config file
      enabledUsers = nixpkgs.lib.filterAttrs (
        name: _: builtins.elem name configFile.computer.users
      ) allUsers;

      # call modules for chosen host
      mkNixosConfiguration =
        hostname:
        nixpkgs.lib.nixosSystem {
          specialArgs = {
            inherit
              inputs
              outputs
              hostname
              enabledUsers
              configFile
              ;
            nixosModules = ./modules/nixos;
          };
          modules = [
            ./hosts/${hostname}
            ./hosts/common
          ];
        };

      # call modules for user
      mkHomeConfiguration =
        username: hostname:
        home-manager.lib.homeManagerConfiguration {
          pkgs = import nixpkgs { system = "x86_64-linux"; };
          extraSpecialArgs = {
            inherit inputs outputs configFile;
            userConfig = enabledUsers.${username};
            nhModules = "${self}/modules/home-manager";
          };
          modules = [
            ./home/${username}
            ./home/common
          ];
        };
    in
    {
      nixosConfigurations = {
        ${hostname} = mkNixosConfiguration hostname;
      };

      # run mkHomeConfiguartion for every activated user
      homeConfigurations = nixpkgs.lib.listToAttrs (
        map (username: {
          name = "${username}@${hostname}";
          value = mkHomeConfiguration username hostname;
        }) configFile.computer.users
      );

      overlays = import ./overlays { inherit inputs; };
    };
}
