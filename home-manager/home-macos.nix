{ pkgs, ... }:

{
  home.username = "anton";
  home.homeDirectory = "/Users/anton"; # macOS uses /Users instead of /home

  # This value determines the Home Manager release that your configuration is
  # compatible with. This helps avoid breakage when a new Home Manager release
  # introduces backwards incompatible changes.
  home.stateVersion = "24.05";

  home.packages = [
    pkgs.nil
    pkgs.nixfmt-rfc-style

    # CLI tools
    pkgs.tree
    pkgs.thefuck
    pkgs.netcat
    pkgs.ripgrep
    pkgs.lazygit
    pkgs.lazydocker
    pkgs.docker-compose
    pkgs.gnumake

    # For configuring the keyboard because Oryx doesn't want to support Firefox
    # pkgs.chromium # Not available on ARM64 macOS

    # development stuff
    pkgs.go
    pkgs.golangci-lint
    pkgs.gotools
    pkgs.go-critic
    pkgs.gocyclo
    pkgs.buf
    pkgs.python313
    pkgs.obsidian
    pkgs.postgresql
    pkgs.postgresql.pg_config
    pkgs.libpq

    # Yaml-engineering
    pkgs.kubectl
    # pkgs.minikube # May have issues on ARM64 macOS
    pkgs.kind
    pkgs.kubernetes-helm

    # clipboard manager (macOS alternative)
    # pkgs.copyq # May have issues on ARM64 macOS

    # fonts
    pkgs.nerd-fonts.jetbrains-mono

    # macOS-specific tools
    pkgs.mas # Mac App Store command line interface
    pkgs.terminal-notifier # Better notifications
  ];

  programs.bat.enable = true;

  programs.direnv = {
    enable = true;
    nix-direnv.enable = true;
    enableZshIntegration = true;
  };

  fonts.fontconfig = {
    enable = true;
    defaultFonts = {
      monospace = [
        "JetBrainsMono NF"
        "monospace"
      ];
    };
  };

  catppuccin.enable = true;
  catppuccin.flavor = "macchiato";
  catppuccin.kitty.enable = true;

  imports = [
    ./git.nix
    ./zsh.nix
  ];

  home.sessionVariables = {
    EDITOR = "nvim";
  };

  # macOS-specific configurations
  targets.darwin.defaults = {
    # System preferences
    "com.apple.dock" = {
      autohide = true;
      show-recents = false;
      tilesize = 48;
    };
    "com.apple.finder" = {
      ShowPathbar = true;
      ShowStatusBar = true;
    };
    "com.apple.screencapture" = {
      location = "~/Desktop";
      type = "png";
    };
    "com.apple.terminal" = {
      "Default Window Settings" = "Pro";
      "Startup Window Settings" = "Pro";
    };
  };

  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;
}
