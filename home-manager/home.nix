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

    # Graphics
    pkgs.inkscape
    pkgs.gimp
    pkgs.obs-studio

    pkgs.mupdf

    # For configuring the keyboard because Oryx doesn't want to support Firefox
    pkgs.chromium

    # development stuff
    pkgs.go
    pkgs.python3
    pkgs.jetbrains.pycharm-professional
    pkgs.jetbrains.goland
    pkgs.obsidian

    # clipboard manager
    pkgs.copyq

    # reminder: this will be changed when 25.05 is released:
    # https://www.reddit.com/r/NixOS/comments/1h1nc2a/nerdfonts_has_been_separated_into_individual_font/
    (pkgs.nerdfonts.override {
      fonts = [
        "JetBrainsMono"
      ];
    })
  ];
  # For some reason it will not apply Catppuccin if I use pkgs
  programs.bat.enable = true;

  gtk = {
    enable = true;
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
    ./hyprland.nix
    ./waybar.nix
    ./kitty.nix
    ./rofi.nix
  ];

  programs.git = {
    enable = true;
    userName = "antonlinevych";
    userEmail = "anton@linevich.net";
  };
  programs.zsh = {
    enable = true;
    autosuggestion.enable = true;
    syntaxHighlighting.enable = true;
    oh-my-zsh = {
      enable = true;
      theme = "agnoster";
      plugins = [
        "git"
        "sudo"
        "thefuck"
      ];
    };
    envExtra = ''DEFAULT_USER=anton''; # TODO: Remove hardcoded value
  };

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
