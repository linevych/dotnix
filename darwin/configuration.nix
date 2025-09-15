{ config, pkgs, ... }:

{
  # List packages installed in system profile. To search by name, run:
  # $ nix-env -qaP | grep wget
  environment.systemPackages = with pkgs; [
    git
    home-manager
  ];

  # Disable nix-darwin's Nix management (using Determinate Systems installer)
  nix.enable = false;

  # Create /etc/bashrc that loads the nix-darwin environment.
  programs.zsh.enable = true; # default shell on catalina
  # programs.fish.enable = true;

  # Used for backwards compatibility, please read the changelog before changing.
  # $ darwin-rebuild changelog
  system.stateVersion = 4;

  # The platform the configuration will be used on.
  nixpkgs.hostPlatform = "aarch64-darwin";

  # Allow unfree packages
  nixpkgs.config.allowUnfree = true;

  # Enable experimental features
  nix.settings.experimental-features = [
    "nix-command"
    "flakes"
  ];

  # System-wide environment variables
  environment.variables = {
    EDITOR = "nvim";
  };

  # System services (activate-system is now always enabled)

  # User configuration
  users.users.anton = {
    name = "anton";
    home = "/Users/anton";
    shell = pkgs.zsh;
  };

  # Set primary user for system defaults
  system.primaryUser = "anton";

  # System-wide programs
  programs.nix-index.enable = true;

  # Security settings
  security.pam.services.sudo_local.touchIdAuth = true;

  # Fonts
  fonts.packages = with pkgs; [
    nerd-fonts.jetbrains-mono
  ];

  # System preferences (similar to what you had in home-macos.nix)
  system.defaults = {
    # Dock settings
    dock = {
      autohide = true;
      show-recents = false;
      tilesize = 48;
      orientation = "bottom";
    };

    # Finder settings
    finder = {
      ShowPathbar = true;
      ShowStatusBar = true;
      AppleShowAllExtensions = true;
      FXEnableExtensionChangeWarning = false;
    };

    # Screenshot settings
    screencapture = {
      location = "~/Desktop";
      type = "png";
    };

    # Keyboard settings
    NSGlobalDomain = {
      "com.apple.keyboard.fnState" = true;
      "com.apple.swipescrolldirection" = false;
    };

    # Trackpad settings
    trackpad = {
      Clicking = true;
      TrackpadThreeFingerDrag = true;
    };

    # Menu bar settings
    menuExtraClock = {
      Show24Hour = true;
      ShowDate = 1;
    };
  };
}
