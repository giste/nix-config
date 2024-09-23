{ pkgs, ... }:

{
  wayland.windowManager.hyprland.enable = true;
  wayland.windowManager.hyprland.settings = {
    input = {
      kb_layout = "es";
      kb_model = "pc105";
      kb_options = "eurosign:e";
    };
    "$mainMod" = "SUPER_L";
    "$mod" = "SUPER_L";
    bind =
      [
        "$mod, F, exec, firefox"
        ", Print, exec, grimblast copy area"
        "$mod, Q, exec, kitty"
	      "$mod, M, exec, hyprctl dispatch exit"
      ]
      ++ (
        # workspaces
        # binds $mod + [shift +] {1..10} to [move to] workspace {1..10}
        builtins.concatLists (builtins.genList (
            x: let
              ws = let
                c = (x + 1) / 10;
              in
                builtins.toString (x + 1 - (c * 10));
            in [
              "$mod, ${ws}, workspace, ${toString (x + 1)}"
              "$mod SHIFT, ${ws}, movetoworkspace, ${toString (x + 1)}"
            ]
          )
          10)
      );
    exec-once = "waybar";
  };
  programs.waybar = {
    enable = true;
    settings = {
      mainBar = {
        layer = "top";
        position = "top";
        #height = 48;
        #margin = "7 7 3 7";
        #margin-left = 7;
        #margin-right = 7;
        #margin-top = 7;
        #margin-bottom = 3;
        spacing = 4;
        #output = [
        #  "eDP-1"
        #  "HDMI-A-1"
        #];
        modules-left = [ "hyprland/workspaces" "cpu" "memory" "disk" ];
        modules-center = [ "hyprland/window" ];
        modules-right = [ "idle_inhibitor" "pulseaudio" "clock" "keyboard-state" "tray" "custom/quit" "custom/reboot" "custom/power" ];

        "cpu" = {
          "interval" = 10;
          "format" = "{}% ";
          "max-length" = 10;
        };

        "memory" = {
          "interval" = 30;
          "format" = "{used:0.1f}G/{total:0.1f}G ";
        };

        "disk" = {
          "interval" = 30;
          "format" = "{percentage_free}% free on {path}";
          "path" = "/";
        };

        "idle_inhibitor" = {
          "format" = "{icon}";
          "format-icons" = {
            "activated" = "";
            "deactivated" = "";
          };
        };

        "tray" = {
          "icon-size" = 21;
          "spacing" = 10;
        };

        "custom/quit" = {
            "icon-size" = 32;
            "format" = "󰍃";
            "tooltip" = false;
            "on-click" = "hyprctl dispatch exit";
        };
        "custom/lock" = {
            "format" = "󰍁";
            "tooltip" = false;
            "on-click" = "hyprlock";
        };
        "custom/reboot" = {
            "format" = "󰜉";
            "tooltip" = false;
            "on-click" = "reboot";
        };
        "custom/power" = {
            "format" = "󰐥";
            "tooltip" = false;
            "on-click" = "shutdown now";
        };

        #style = ''
        #  * {
        #    font-family: FontAwesome, "Intel One Mono";
        #    font-size: 64px;
        #  }

        #  #workspaces button {
        #    padding: 0 4px;
        #    /*    background-color: rgba(0,0,0,0.3); */
        #  }
        #'';

      };
    };
  };
}
