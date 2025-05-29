{
  description = "Anton's system";

  inputs = {
    # NixOS
    nixpkgs.url = "github:nixos/nixpkgs/release-25.05";

    # Home Manager
    home-manager.url = "github:nix-community/home-manager/release-25.05";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";

    # Hyprland
    hyprland.url = "git+https://github.com/hyprwm/Hyprland?submodules=1";

    # Fancy colors
    catppuccin.url = "github:catppuccin/nix";

    # Neovim but it's harder to debug probably
    nixvim = {
      url = "github:nix-community/nixvim/nixos-25.05";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs =
    {
      self,
      nixpkgs,
      catppuccin,
      home-manager,
      nixvim,
      ...
    }@inputs:
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
      formatter.x86_64-linux = nixpkgs.legacyPackages.x86_64-linux.nixfmt-rfc-style;
      nixosConfigurations = {
        devBox = nixpkgs.lib.nixosSystem {
          specialArgs = {
            inherit inputs outputs;
          };
          modules = [
            ./nixos/configuration.nix
            catppuccin.nixosModules.catppuccin
          ];
        };
      };
      homeConfigurations = {
        "anton@devBox" = home-manager.lib.homeManagerConfiguration {
          inherit pkgs;
          extraSpecialArgs = {
            inherit inputs outputs;
          };
          modules = [
            nixvim.homeManagerModules.nixvim
            catppuccin.homeModules.catppuccin
            ./home-manager/home.nix
          ];
        };
      };
    };
}
