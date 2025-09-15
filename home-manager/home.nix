{ pkgs, ... }:

{
  home.username = "anton";
  home.homeDirectory = "/home/anton";

  # This value determines the Home Manager release that your configuration is
  # compatible with. This helps avoid breakage when a new Home Manager release
  # introduces backwards incompatible changes.
  #
  # You should not change this value, even if you update Home Manager. If you do
  # want to update the value, then make sure to first check the Home Manager
  # release notes.
  home.stateVersion = "24.05"; # Please read the comment before changing.

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

    # Graphics
    pkgs.inkscape
    pkgs.gimp
    pkgs.obs-studio

    pkgs.mupdf

    # For configuring the keyboard because Oryx doesn't want to support Firefox
    pkgs.chromium

    # development stuff
    pkgs.go
    pkgs.golangci-lint
    pkgs.gotools
    pkgs.go-critic
    pkgs.gocyclo
    pkgs.buf
    pkgs.gcc
    pkgs.python313
    pkgs.jetbrains.pycharm-professional
    pkgs.jetbrains.goland
    pkgs.jetbrains.webstorm
    pkgs.obsidian
    pkgs.postgresql
    pkgs.postgresql.pg_config
    pkgs.libpq

    # Yaml-engineering. Move into it's own flake probably
    pkgs.kubectl
    pkgs.minikube
    pkgs.kind
    pkgs.kubernetes-helm

    # clipboard manager
    pkgs.copyq

    # fonts
    pkgs.nerd-fonts.jetbrains-mono

    # Glitchy piece of garbage
    pkgs.zoom-us
  ];
  # For some reason it will not apply Catppuccin if I use pkgs
  programs.bat.enable = true;

  gtk = {
    enable = true;
    theme = {
      name = "Adwaita-dark";
      package = pkgs.gnome-themes-extra;
    };
  };
  programs.direnv = {
    enable = true;
    nix-direnv.enable = true; # enables `use flake`
    enableZshIntegration = true; # or:
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
  home.pointerCursor = {
    package = pkgs.bibata-cursors;
    name = "Bibata-Modern-Classic";
    size = 24;
  };
  services.hyprpaper = {
    enable = true;
    settings = {
      # TODO: figure out how to set base directory dynamically
      preload = [ "~/projects/nixos/wallpaper.png" ];
      wallpaper = [
        "HDMI-A-2, ~/projects/nixos/wallpaper.png"
      ];
    };
  };

  catppuccin.enable = true;
  catppuccin.flavor = "macchiato";

  imports = [
    ./git.nix
    ./zsh.nix
    ./hyprland.nix
    ./waybar.nix
    ./kitty.nix
    ./rofi.nix
    ./nvim.nix
  ];


  home.sessionVariables = {
    EDITOR = "nvim";
  };

  xdg = {
    mime.enable = true;
    desktopEntries.mupdfcustom = {
      name = "mupdfcustom";
      exec = "mupdf-gl -A 8";
      type = "Application";
      terminal = false;
      mimeType = [ "application/pdf" ];
    };
    # After changing these setting restart the system or run:
    # `systemctl --user import-environment PATH && systemctl --user restart xdg-desktop-portal.service`
    mimeApps = {
      enable = true;
      defaultApplications = {
        "default-web-browser" = [ "firefox.desktop" ];
        "text/html" = [ "firefox.desktop" ];
        "x-scheme-handler/http" = [ "firefox.desktop" ];
        "x-scheme-handler/https" = [ "firefox.desktop" ];
        "x-scheme-handler/about" = [ "firefox.desktop" ];
        "application/pdf" = [ "mupdfcustom.desktop" ];
      };
    };
  };
  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;
}
