{
  description = "Anton's system";

  inputs = {
    # NixOS
    nixpkgs.url = "github:nixos/nixpkgs/release-25.05";

    # Home Manager
    home-manager.url = "github:nix-community/home-manager/release-25.05";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";

    # nix-darwin for macOS system configuration
    darwin = {
      url = "github:LnL7/nix-darwin/nix-darwin-25.05";
      inputs.nixpkgs.follows = "nixpkgs";
    };

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
      darwin,
      nixvim,
      ...
    }:
    let
      inherit (self) inputs;
      inherit (self) outputs;
      supportedSystems = [
        "x86_64-linux"
        "aarch64-darwin"
        "x86_64-darwin"
      ];
      forAllSystems = nixpkgs.lib.genAttrs supportedSystems;

      # Configure nixpkgs with allowUnfree, allowUnsupportedSystem, and allowBroken
      pkgsFor =
        system:
        import nixpkgs {
          inherit system;
          config = {
            allowUnfree = true;
            allowUnsupportedSystem = true;
            allowBroken = true;
          };
        };
    in
    {
      formatter = forAllSystems (system: nixpkgs.legacyPackages.${system}.nixfmt-rfc-style);

      # Keep NixOS configuration for Linux
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

      # nix-darwin configuration for macOS
      darwinConfigurations = {
        macbook = darwin.lib.darwinSystem {
          specialArgs = {
            inherit inputs outputs;
          };
          modules = [
            ./darwin/configuration.nix
          ];
        };
      };

      # Home Manager configurations for both Linux and macOS
      homeConfigurations = {
        # Linux configuration
        "anton@devBox" = home-manager.lib.homeManagerConfiguration {
          pkgs = pkgsFor "x86_64-linux";
          extraSpecialArgs = {
            inherit inputs outputs;
          };
          modules = [
            nixvim.homeManagerModules.nixvim
            catppuccin.homeModules.catppuccin
            ./home-manager/home.nix
            ./home-manager/hyprland.nix
            ./home-manager/waybar.nix
            ./home-manager/kitty.nix
            ./home-manager/rofi.nix
            ./home-manager/nvim.nix
          ];
        };

        # macOS configuration
        "anton@macbook" = home-manager.lib.homeManagerConfiguration {
          pkgs = pkgsFor "aarch64-darwin";
          extraSpecialArgs = {
            inherit inputs outputs;
          };
          modules = [
            nixvim.homeManagerModules.nixvim
            catppuccin.homeModules.catppuccin
            ./home-manager/home-macos.nix
            ./home-manager/kitty.nix
            ./home-manager/nvim.nix
          ];
        };
      };
    };
}
