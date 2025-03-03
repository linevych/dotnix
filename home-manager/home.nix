{ config, pkgs, ... }:

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
    pkgs.jetbrains.pycharm-professional
    pkgs.nil
    pkgs.nixfmt-rfc-style

    # CLI tools
    pkgs.tree
    pkgs.bat
    pkgs.thefuck

    # Hyprland dependencies (todo: move the module if possible)
    pkgs.waybar
    pkgs.dunst
    pkgs.swww
    pkgs.kitty
    pkgs.rofi-wayland

    # Graphics
    pkgs.inkscape
    pkgs.gimp

    # For configuring the keyboard because Oryx doesn't want to support Firefox
    pkgs.chromium

    # development stuff
    pkgs.go

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

  imports = [
    ./hyprland.nix
    ./waybar.nix
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

  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;
}
