{
  description = "Crappy config that I made";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs?ref=nixos-unstable";

    nix-cachyos-kernel.url = "github:xddxdd/nix-cachyos-kernel/release";

    slippi.url = "github:lytedev/slippi-nix";
    slippi.inputs.nixpkgs.follows = "nixpkgs";

    home-manager = {
      url = "github:nix-community/home-manager/master";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    agenix = {
      url = "github:ryantm/agenix";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    nixpkgs-xr = {
      url = "github:nix-community/nixpkgs-xr";
    };
    nswitch-rcm-nix = {
      url = "github:Swarsel/nswitch-rcm-nix";
    };
    plasma-manager = {
      url = "github:nix-community/plasma-manager";
      inputs.nixpkgs.follows = "nixpkgs";
      inputs.home-manager.follows = "home-manager";
    };
  };

  outputs =
    inputs@{
      self,
      nixpkgs,
      home-manager,
      agenix,
      nixpkgs-xr,
      nswitch-rcm-nix,
      plasma-manager,
      ...
    }:
    {
      nixosConfigurations.nixstrogen = nixpkgs.lib.nixosSystem {
        system = "x86_64-linux";
        specialArgs = { inherit inputs; };
        modules = [
          ./hosts/koishi/configuration.nix
          home-manager.nixosModules.home-manager
          agenix.nixosModules.default
          nswitch-rcm-nix.nixosModules.nswitch-rcm
          {
            home-manager.useGlobalPkgs = true;
            home-manager.useUserPackages = true;
            home-manager.sharedModules = [ plasma-manager.homeModules.plasma-manager ];
            home-manager.backupFileExtension = "backup";
            home-manager.extraSpecialArgs = { inherit inputs; };
            home-manager.users.koishi = import ./hosts/koishi/home.nix;
          }
        ];
      };

      nixosConfigurations.blahaj = nixpkgs.lib.nixosSystem {
        system = "x86_64-linux";
        specialArgs = { inherit inputs; };
        modules = [
          ./hosts/cirno/configuration.nix
          home-manager.nixosModules.home-manager
          agenix.nixosModules.default
          nixpkgs-xr.nixosModules.nixpkgs-xr
          nswitch-rcm-nix.nixosModules.nswitch-rcm
          {
            home-manager.useGlobalPkgs = true;
            home-manager.useUserPackages = true;
            home-manager.backupFileExtension = "backup";
            home-manager.sharedModules = [ inputs.plasma-manager.homeModules.plasma-manager ];
            home-manager.extraSpecialArgs = { inherit inputs; };
            home-manager.users.cirno = import ./hosts/cirno/home.nix;
          }
          {
            nixpkgs.overlays = [ inputs.nix-cachyos-kernel.overlays.pinned ];
          }
        ];
      };
    };
}
