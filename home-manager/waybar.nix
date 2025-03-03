{ ... }:
{

  programs.waybar = {
    enable = true;
    style = builtins.readFile ../waybar/style.css;
    settings = [
      {
        layer = "top";
        position = "top";
        mod = "dock";
        exclusive = true;
        passtrough = false;
        gtk-layer-shell = true;
        height = 0;
        modules-left = [
          "hyprland/workspaces"
        ];
        modules-center = [ "hyprland/window" ];
        modules-right = [
          "tray"
          "network"
          "custom/divider"
          "pulseaudio"
          "custom/divider"
          "cpu"
          "custom/divider"
          "memory"
          "custom/divider"
          "clock"
        ];
        "hyprland/window" = {
          format = "{}";
        };
        "wlr/workspaces" = {
          on-scroll-up = "hyprctl dispatch workspace e+1";
          on-scroll-down = "hyprctl dispatch workspace e-1";
          all-outputs = true;
          on-click = "activate";
        };
        cpu = {
          interval = 10;
          format = "󰻠 {}%";
          max-length = 10;
          on-click = "";
        };
        memory = {
          interval = 30;
          format = "  {}%";
          format-alt = " {used:0.1f}G";
          max-length = 10;
        };
        tray = {
          icon-size = 13;
          tooltip = false;
          spacing = 10;
        };
        network = {
          format = "󰖩 {essid}";
          format-disconnected = "󰖪 disconnected";
        };
        clock = {
          format = " {:%I:%M %p   %m/%d} ";
          tooltip-format = ''
            <big>{:%Y %B}</big>
            <tt><small>{calendar}</small></tt>'';
        };
        pulseaudio = {
          format = "{icon} {volume}%";
          tooltip = false;
          format-muted = " Muted";
          on-click = "pamixer -t";
          on-scroll-up = "pamixer -i 5";
          on-scroll-down = "pamixer -d 5";
          scroll-step = 5;
          format-icons = {
            headphone = "";
            hands-free = "";
            headset = "";
            phone = "";
            portable = "";
            car = "";
            default = [
              ""
              ""
              ""
            ];
          };
        };
        "pulseaudio#microphone" = {
          format = "{format_source}";
          tooltip = false;
          format-source = " {volume}%";
          format-source-muted = " Muted";
          on-click = "pamixer --default-source -t";
          on-scroll-up = "pamixer --default-source -i 5";
          on-scroll-down = "pamixer --default-source -d 5";
          scroll-step = 5;
        };
        "custom/divider" = {
          format = " | ";
          interval = "once";
          tooltip = false;
        };
        "custom/endright" = {
          format = "_";
          interval = "once";
          tooltip = false;
        };
      }
    ];
  };
}
