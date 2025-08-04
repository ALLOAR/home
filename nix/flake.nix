{
  description = "My system conf";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-25.05";

    home-manager = {
      url = "github:nix-community/home-manager/release-25.05";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = { nixpkgs, home-manager, ... }: let
    colors = import ./home-configs/colors.nix;
    system = "x86_64-linux";
    pkgs = nixpkgs.legacyPackages.${system};
  in {
    nixosConfigurations = {
      nixos = nixpkgs.lib.nixosSystem {
        system = system;
        modules = [ ./configuration.nix ];
      };

      laptop = nixpkgs.lib.nixosSystem {
        system = system;
        modules = [ ./configurations/laptop.nix ];
      };
    };

    homeConfigurations = {
      alloar = home-manager.lib.homeManagerConfiguration {
        pkgs = pkgs;
        modules = [ ./home.nix ];
		extraSpecialArgs = {
        	inherit colors; # Передаём colors в модули
      };
      };	
    };
  };
}

