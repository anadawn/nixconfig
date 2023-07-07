{ pkgs, ... }:



{
  # sway 
  wayland.windowManager.sway.xwayland = true;
  wayland.windowManager.sway = {
    enable = true;
    systemd.enable = true;
    wrapperFeatures.gtk = true;

    #   extraSessionCommands = ''export XDG_SESSION_TYPE=wayland
    #                           export XDG_SESSION_DESKTOP=sway
    #                           export XDG_CURRENT_DESKTOP=sway
    #                           export SDL_VIDEODRIVER=wayland
    #                           export QT_QPA_PLATFORM=wayland
    #                           export QT_WAYLAND_DISABLE_WINDOWDECORATION="1"
    #                          export _JAVA_AWT_WM_NONREPARENTING=1
    #                           export MOZ_ENABLE_WAYLAND=1
    #                           export WLR_NO_HARDWARE_CURSORS=1
    #                         '';

    # sway config
    config = {
      # touchpad config 
      input = {
        "1739:32382:PNP0C50:0e_06CB:7E7E_Touchpad" = {
          dwt = "enable";
          tap = "enable";
          natural_scroll = "enabled";
          middle_emulation = "enabled";
        };
      };

      terminal = "${pkgs.kitty}/bin/kitty";
      menu = "${pkgs.sway-launcher-desktop}/bin/sway-launcher-desktop";
      modifier = "Mod4";
      gaps.inner = 7;
      window.border = 2;

      startup = [
        # Lock on lid close after some time 
        {
          command = ''
            ${pkgs.swayidle}/bin/swayidle \
                before-sleep '${pkgs.swaylock}/bin/swaylock -fc 000000'
          '';
          always = true;
        }
        # autolock after some time of inactivity
        {
          command = ''
            ${pkgs.swayidle}/bin/swayidle \
              timeout 120 '${pkgs.swaylock}/bin/swaylock -fc 000000' \
          '';
          always = true;
        }

        { command = "${pkgs.polkit_gnome}/libexec/polkit-gnome-authentication-agent-1"; }

      ];

      workspaceOutputAssign = [
        { output = "HDMI-A-1"; workspace = "2"; }
        { output = "HDMI-A-1"; workspace = "4"; }
        { output = "HDMI-A-1"; workspace = "6"; }
        { output = "HDMI-A-1"; workspace = "8"; }
        { output = "eDP-1"; workspace = "1"; }
        { output = "eDP-1"; workspace = "3"; }
        { output = "eDP-1"; workspace = "5"; }
        { output = "eDP-1"; workspace = "7"; }
        { output = "eDP-1"; workspace = "9"; }
      ];
      defaultWorkspace = "workspace number 2";

      colors = {
        focused = {
          background = "#ffffff";
          border = "#ffffff";
          childBorder = "#BAC2DE";
          indicator = "#BAC2DE";
          text = "#ffffff";
        };

      };


      # keybindings 
      keybindings = {
        "mod4+b" = "exec firefox"; # opens firefox
        "mod4+r" = "exec ~/.config/scripts/powermenu.sh"; # calls a script which shows all the powermenu options 
        "mod4+p" = "exec tessen -d rofi"; # calls password-store with rofi interface 
        "mod4+m" = "exec ~/.config/scripts/ytmpv.sh"; # plays youtube in mpv 
        "mod4+Alt+b" = "exec ~/.config/scripts/add_bookmark.sh"; # calls a script to add bookmarks
        "mod4+Shift+b" = "exec ~/.config/scripts/bookmarks.sh"; # calls a script which show bookmarks

        "mod4+Shift+y" = "exec firefox https://www.youtube.com"; # opens youtube in firefox
        "mod4+Shift+n" = "exec firefox https://mipmip.github.io/home-manager-option-search/"; # opens home-manager search
        "mod4+n" = "exec firefox https://search.nixos.org/packages"; # opens nixos search 
        "mod4+Shift+q" = "kill"; # close windows
        "mod4+Return" = "exec kitty"; # open terminal 
        "mod4+Shift+Return" = "exec kitty --class=ytfzf"; # open terminal in a floating window
        "mod4+d" = "exec kitty --class=launcher -e sway-launcher-desktop"; # opens sway-launcher-desktop 
        "mod4+y" = "exec kitty --class=ytfzf -e ytfzf -t -T chafa -l -s -f --preview-side=right"; # youtube in terminal
        "mod4+c" = "exec ~/.config/scripts/conf.sh"; # calls a script to edit nix configurations
        "mod4+o" = "exec ~/.config/scripts/laptopscreen.sh"; # calls a scripts to turn laptop screen on and off

        "mod4+s" = "exec kitty --class=ytfzf -e ytfzf -t -T chafa -l -s -f -c S --preview-side=right"; # youtube subscriptions in terminal
        "mod4+Shift+c" = "reload"; # reload sway

        # exit sway 
        "mod4+shift+e" = "exec swaynag - t warning -m 'you pressed the exit shortcut.Do you really want to exit sway?' -B 'yes' 'swaymsg exit'";

        #scratchpad
        "mod4+Shift+minus" = "move scratchpad";
        "mod4+minus" = "scratchpad show";

        # moving aroud
        "mod4+Down" = "focus down";
        "mod4+Up" = "focus up";
        "mod4+Right" = "focus right";
        "mod4+Left" = "focus left";
        # use vim keys to move around
        "mod4+j" = "focus down";
        "mod4+k" = "focus up";
        "mod4+l" = "focus right";
        "mod4+h" = "focus left";

        # move focused window
        "mod4+Shift+l" = "move right";
        "mod4+Shift+Left" = "move left";
        "mod4+Shift+j" = "move down";
        "mod4+Shift+Down" = "move down";
        "mod4+Shift+h" = "move left";
        "mod4+Shift+Right" = "move right";
        "mod4+Shift+k" = "move up";
        "mod4+Shift+Up" = "move up";

        # workspaces
        "mod4+1" = "workspace number 1";
        "mod4+2" = "workspace number 2";
        "mod4+3" = "workspace number 3";
        "mod4+4" = "workspace number 4";
        "mod4+5" = "workspace number 5";
        "mod4+6" = "workspace number 6";
        "mod4+7" = "workspace number 7";
        "mod4+8" = "workspace number 8";
        "mod4+9" = "workspace number 9";
        # move focused container to workspaces
        "mod4+Shift+1" = "move container to workspace number 1";
        "mod4+Shift+2" = "move container to workspace number 2";
        "mod4+Shift+3" = "move container to workspace number 3";
        "mod4+Shift+4" = "move container to workspace number 4";
        "mod4+Shift+5" = "move container to workspace number 5";
        "mod4+Shift+6" = "move container to workspace number 6";
        "mod4+Shift+7" = "move container to workspace number 7";
        "mod4+Shift+8" = "move container to workspace number 8";
        "mod4+Shift+9" = "move container to workspace number 9";

        "mod4+f" = "fullscreen"; # full screen
        "mod4+space" = "focus mode_toggle"; # toggle focus window
        "mod4+Shift+space" = "floating toggle"; # floating window
        "XF86MonBrightnessDown" = "exec light -U 10"; # increase increase brightness
        "XF86MonBrightnessUp" = "exec light -A 10"; # decrease brightness 
        "XF86AudioRaiseVolume" = "exec --no-startup-id ~/.config/scripts/volume.sh volume_up"; # increase volume
        "XF86AudioLowerVolume" = "exec --no-startup-id ~/.config/scripts/volume.sh volume_down"; # decrease volume
        "XF86AudioMute" = "exec 'wpctl set-mute @DEFAULT_AUDIO_SINK@ toggle'"; # mute
      };


      # swaybar config
      bars = [{
        fonts.size = 15.0;
        command = "waybar";
        position = "top";
        hiddenState = "hide";
        mode = "hide";
        extraConfig = "modifier mod4";
      }];

      # output      
      output = {
        # external monitor
        # "*".bg =  "~/.config/wallpapers/three_squares.png fill";        
        "HDMI-A-1".mode = "1366x768";
        "HDMI-A-1".position = "0,1920";
      };
    };

    # extra configurations
    extraConfig = '' 
     exec autotiling 
     exec_always ~/.config/chpaper.sh
     include /home/krizdavezz/.config/sway/extraconf
     for_window [app_id="^launcher$"] floating enable, sticky enable, resize set 30 ppt 60 ppt, border pixel 2
     for_window [app_id="mpv"] floating enable, sticky enable, resize set width 100ppt, move position 0 0,resize set width 99ppt 
     for_window [app_id="^ytfzf$"] floating enable, sticky enable, resize set 80 ppt 80 ppt, border pixel 2
       '';

  }; # end of sway


  home.packages = with pkgs; [

    swaylock
    swayidle
    sway-launcher-desktop
    wl-clipboard
    wf-recorder
    wtype
    autotiling
    slurp
    chafa
  ];
}




