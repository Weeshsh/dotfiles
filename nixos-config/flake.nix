{
  description = "Mikolaj's NixOS configuration";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-26.05";

    home-manager = {
      url = "github:nix-community/home-manager/release-26.05";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = { nixpkgs, home-manager, ... }: {
    nixosConfigurations.nixoson_michael = nixpkgs.lib.nixosSystem {
      modules = [
        ./hosts/nixoson_michael

        home-manager.nixosModules.home-manager
        {
          home-manager = {
            useGlobalPkgs = true;
            useUserPackages = true;
            backupFileExtension = "hm-backup";
            users.mikolaj = import ./home/mikolaj;
          };
        }
      ];
    };
  };
}
