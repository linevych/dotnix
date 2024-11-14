{
  description = "Anton's system";

  inputs = {
    # NixOS
    nixpkgs.url = "github:nixos/nixpkgs?ref=24.05";

    # Home Manager
    home-manager.url = "github:nix-community/home-manager/release-24.05";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";
  };

  outputs = { self, nixpkgs,
    home-manager, ... } @ inputs:
  let
  inherit (self) inputs;
  inherit (self) outputs;
  system = "x86_64-linux";
      pkgs = import nixpkgs {
        inherit system;
        config = {
            allowUnfree = true;
        };
      };
  in
  {
    nixosConfigurations = {
        devBox = nixpkgs.lib.nixosSystem {
           specialArgs = {inherit inputs outputs;};
           modules = [
            ./nixos/configuration.nix
           ];
        };
    };
     homeConfigurations = {
      "anton@devBox" = home-manager.lib.homeManagerConfiguration {
        inherit pkgs;
        extraSpecialArgs = {inherit inputs outputs;};
        modules = [
          ./home-manager/home.nix
        ];
      };
    };
  };
}
