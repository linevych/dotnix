{
  pkgs,
  config,
  ...
}:
let
  conf = "${config.xdg.configHome}/tmux/tmux.conf";
in
{
  programs.tmux = {
    enable = true;
    prefix = "C-Space";

    plugins = with pkgs.tmuxPlugins; [
      sensible
      vim-tmux-navigator
    ];

    extraConfig = ''
      # Keybinding
      bind | split-window -h
      bind v split-window -v
      bind r source-file ${conf} \; display "Reloaded!"
    '';
  };
}
