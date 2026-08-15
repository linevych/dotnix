{ pkgs, pkgsUnstable, ... }:

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
    pkgs.nixfmt

    # CLI tools
    pkgs.tree
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
    pkgs.libreoffice-fresh

    pkgs.mupdf
    pkgs.imagemagick
    pkgs.exiftool
    pkgs.feh

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
    pkgs.jetbrains.pycharm
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
    pkgsUnstable.zoom-us
  ];
  programs.codex = {
    enable = true;
    package = pkgsUnstable.codex;
  };

  # For some reason it will not apply Catppuccin if I use pkgs
  programs.bat.enable = true;

  gtk = {
    enable = true;
    theme = {
      name = "Adwaita-dark";
      package = pkgs.gnome-themes-extra;
    };
    colorScheme = "dark";
    gtk4.theme = null;
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
      wallpaper = [
        {
          monitor = "HDMI-A-2";
          path = "/home/anton/projects/nixos/wallpaper.png";
          fit_mode = "cover";
        }
      ];
    };
  };

  catppuccin.enable = true;
  catppuccin.autoEnable = true;
  catppuccin.flavor = "macchiato";

  imports = [
    ./git.nix
    ./zsh.nix
    ./hyprland.nix
    ./waybar.nix
    ./kitty.nix
    ./rofi.nix
    ./nvim.nix
    ./tmux.nix
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
