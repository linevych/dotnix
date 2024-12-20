{ config, pkgs, ... }:
let
  startupScript = pkgs.pkgs.writeShellScriptBin "start" ''
    ${pkgs.waybar}/bin/waybar &
    ${pkgs.networkmanager}/bin/nm-applet &
  '';
in
{
  wayland.windowManager.hyprland = {

    enable = true;

    settings = {
      # Custom variables
      "$mod" = "SUPER";
      "$menu" = "rofi -show drun -show-icons";
      "$terminal" = "kitty";

      exec-once = ''${startupScript}/bin/start'';
      monitor = [
        "HDMI-A-2, 3840x2160@144, 0x0, 1"
        "Unknown-1, disable" # Disables phantom monitor that is probably generated by integrated AMD graphics
      ];
      # Visual appearance
      animations.enabled = false; # We want to be fast, not fancy!
      general = {
        gaps_in = 1;
        gaps_out = 1;
      };
      # Keybinds
      bind =
        [
          "$mod, RETURN, exec, $terminal"
          "$mod, D, exec, $menu"
          "$mod SHIFT, Q, exit"
          "$mod SHIFT, E, killactive"
        ]
        ++ (
          # workspaces
          # binds $mod + [shift +] {1..9} to [move to] workspace {1..9}
          builtins.concatLists (
            builtins.genList (
              idx:
              let
                ws = idx + 1;
              in
              [
                "$mod, code:1${toString idx}, workspace, ${toString ws}"
                "$mod SHIFT, code:1${toString idx}, movetoworkspace, ${toString ws}"
              ]
            ) 9
          )
        );
    };
  };
}
