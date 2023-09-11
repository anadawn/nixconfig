#
#  Hyprland Home-manager configuration
#
#  flake.nix
#   ├─ ./hosts
#   │   └─ ./<host>
#   │       └─ home.nix
#   └─ ./modules
#       └─ ./desktop
#           └─ ./hyprland
#               └─ home.nix *
#

{ pkgs, config, ... }: {

  wayland.windowManager.hyprland = {
    enable = true;
    systemdIntegration = true;
    xwayland.enable = true;
    settings = {

      source = "~/testfolder/conf.conf";

      exec-once = [

        "hyprctl setcursor ${config.gtk.cursorTheme.name} 29"

        # sort files
        # "${pkgs.scripts}/bin/filecheck"

      ];


      # wallpaper
      exec = "${pkgs.scripts}/bin/chpaper ${config.xdg.userDirs.pictures}/Wallpapers";

      monitor = [


        "eDP-1,  preferred,  auto,   1.05"

        "eDP-1,addreserved,0,240,0,0"

      ];


      input = {
        kb_layout = "us";
        kb_variant = " ";
        kb_model = " ";
        kb_options = " ";
        kb_rules = " ";

        follow_mouse = 1;

        touchpad = {
          natural_scroll = true;
        };

        sensitivity = 0; # -1.0 - 1.0, 0 means no modification.
      };

      general = {

        gaps_in = 5;
        gaps_out = 13;
        border_size = 2;
        cursor_inactive_timeout = 7;
        resize_on_border = true;
        hover_icon_on_border = true;

        layout = "master";
      };

      decoration = {

        rounding = 10;
        inactive_opacity = 0.8;
        dim_inactive = true;
        dim_special = 0;

        blur = {

          # special = false;

        };
      };



      misc = {
        disable_hyprland_logo = true;
        disable_splash_rendering = true;
      };

      dwindle = {
        pseudotile = true; # master switch for pseudotiling. 
        preserve_split = true; # you probably want this
      };

      master = {
        new_is_master = true;
        new_on_top = true;
      };

      gestures = {
        workspace_swipe = true;
      };

      # Example per-device config
      # device:epic-mouse-v1  = {
      #     sensitivity = -0.5
      # }

      # animation
      animation = [

        "windowsMove, 1, 3, default, slide"
        "windows, 0, 3, default"
        "fade, 0, 1, default"
        "border, 0, 1, default"
        "borderangle, 0, 1, default"
        "workspaces, 1, 3, default"

      ];


      windowrulev2 = [

        # launcher 
        "float, class:^(launcher)$"
        "size 30% 50%, class:^(launcher)$"
        "center, class:^(launcher)$"
        "dimaround, class:^(launcher)$"

         # mpv
        "float, class:^(mpv)$"
        "size 99.5% 66%, class:^(mpv)$"
        "move 0 4, class:^(mpv)$"

        # imv
        "float, class:^(imv)$"
        "size 99.5% 66%, class:^(imv)$"
        "move 0 4, class:^(imv)$"


        # kitty
       "float, class:^(ytfzf)$" 
       "size 74% 63%, class:^(ytfzf)$" 
       "move 13% 3%, class:^(ytfzf)$" 
 
        # JupyterLab
       "float, class:^(jupyterlab-desktop)$" 
       "size 99.5% 66%, class:^(jupyterlab-desktop)$" 
       "move 0 4, class:^(jupyterlab-desktop)$" 
 

        # playlist
        "float, class:^(mpv)$,title:^(playlist)$"
        "size 8% 14.2%, class:^(mpv)$,title:^(playlist)$"
        "move 90.8% 2.3%, class:^(mpv)$,title:^(playlist)$"
        "noinitialfocus, class:^(mpv)$,title:^(playlist)$"

        # kitty
        "float, class:^(ytfzf)$"
        "size 74% 74%, class:^(ytfzf)$"
        "center, class:^(ytfzf)$"

      ];


      workspace = [

        # workspace on eDP-1
        "1, monitor:eDP-1"
        "3, monitor:eDP-1"
        "5, monitor:eDP-1"
        "7, monitor:eDP-1"
        "9, monitor:eDP-1"

        # workspace on external monitor
        "2, monitor:HDMI-A-1,default:true"
        "4, monitor:HDMI-A-1"
        "6, monitor:HDMI-A-1"
        "8, monitor:HDMI-A-1"
        "0, monitor:HDMI-A-1"

      ];

      "$mainMod" = "SUPER";

      bindr = [

        # hide waybar
        "SUPER, SUPER_L, exec, pkill waybar || waybar"

      ];


      bind = [

        #wallpaper
        "SUPER, W, exec, ${pkgs.scripts}/bin/chpaper $(wallhaven ${config.xdg.userDirs.pictures}/Wallpapers)"

        # brightness
        ",KP_Subtract,exec,${pkgs.light}/bin/light -U 10"
        ",KP_Add,exec,${pkgs.light}/bin/light -A 10"

        # floating, fullscreen and focus
        "$mainModSHIFT, SPACE, fullscreen,1"
        "$mainMod, F, fullscreen,0"
        "$mainModSHIFT, F, fakefullscreen"
        "$mainMod, SPACE, cyclenext "
        "$mainModALT, SPACE, togglefloating"

        # general
        "$mainMod, RETURN, exec, kitty"
        "$mainModSHIFT,Q, killactive,"
        "$mainModSHIFT, E, exit,"
        "$mainMod, D, exec, rofi -show drun"
        "$mainMod, P, exec, tessen -d rofi"

        # hyprland reload
        "$mainModSHIFT, c, exec, hyprctl reload"

        # swap master window 
        "$mainMod, M, layoutmsg, swapwithmaster master"
        "$mainModSHIFT, M, layoutmsg, focusmaster"

        # firefox
        "$mainMod, B, exec, firefox "
        "$mainModALT, Y, exec, firefox https://www.youtube.com"
        "$mainModSHIFT, N , exec, firefox https://mipmip.github.io/home-manager-option-search/"
        "$mainMod, N, exec, firefox https://search.nixos.org/packages"

        # ytfzf
        "$mainMod, Y, exec, kitty --class=ytfzf -e ytfzf -t -T kitty -l -s -f --preview-side=right"
        "$mainMod, s, exec, kitty --class=ytfzf -e ytfzf -t -T kitty -l -s -f -c S --preview-side=right"

        # scripts
        "$mainModSHIFT, B, exec, ~/.config/scripts/bookmarks.sh" # calls a script which show bookmarks
        "$mainModSHIFT, Y, exec, ~/.config/scripts/yt_cli.sh"
        "$mainMod, R, exec, ~/.config/scripts/powermenu.sh"
        "$mainModALT, B, exec, ~/.cofig/scripts/add_bookmark.sh"
        "$mainMod, C, exec, ~/.config/scripts/conf.sh"
        "$mainMod, O, exec, ~/.config/scripts/laptopscreen.sh"
        "$mainModSHIFT, P, exec, ~/.config/scripts/playlist.sh" #ytmusic playlist
        "$mainModSHIFT, S, exec, ~/.config/scripts/change-sink.sh" #change audio sink while connected to external display
        "$mainModSHIFT, D, exec, ~/.config/scripts/bluetooth.sh" #select bluetooth devices
        "$mainMod, M, exec, ~/.config/scripts/movie.sh" #select bluetooth devices

        # kitty in floating window
        "$mainModSHIFT, RETURN, exec, kitty --class=ytfzf"

        ",XF86AudioMute, exec, wpctl set-mute @DEFAULT_AUDIO_SINK@ toggle" # mute

        # Move focus with mainMod + vim keys
        "$mainMod, H, movefocus, l"
        "$mainMod, L, movefocus, r"
        "$mainMod, K, movefocus, u"
        "$mainMod, J, movefocus, d"

        # pin a window
        "$mainModALT, P, pin"

        # bring activewindow to top
        "$mainMod, A, bringactivetotop "

        # blur window
        "$mainMod, DELETE, togglespecialworkspace, special:hello "
        "$mainMod, DELETE, exec, hyprctl keyword decoration:blur:special true "

        # move window with vim keys
        "$mainModSHIFT, H, movewindow, l"
        "$mainModSHIFT, L, movewindow, r"
        "$mainModSHIFT, K, movewindow, u"
        "$mainModSHIFT, J, movewindow, d"

        # Switch workspaces with mainMod + [0-9]
        "$mainMod, 1, workspace, 1"
        "$mainMod, 2, workspace, 2"
        "$mainMod, 3, workspace, 3"
        "$mainMod, 4, workspace, 4"
        "$mainMod, 5, workspace, 5"
        "$mainMod, 6, workspace, 6"
        "$mainMod, 7, workspace, 7"
        "$mainMod, 8, workspace, 8"
        "$mainMod, 9, workspace, 9"
        "$mainMod, 0, workspace, 10"

        # Move active window to a workspace with mainMod + SHIFT + [0-9]
        "$mainMod SHIFT, 1, movetoworkspace, 1"
        "$mainMod SHIFT, 2, movetoworkspace, 2"
        "$mainMod SHIFT, 3, movetoworkspace, 3"
        "$mainMod SHIFT, 4, movetoworkspace, 4"
        "$mainMod SHIFT, 5, movetoworkspace, 5"
        "$mainMod SHIFT, 6, movetoworkspace, 6"
        "$mainMod SHIFT, 7, movetoworkspace, 7"
        "$mainMod SHIFT, 8, movetoworkspace, 8"
        "$mainMod SHIFT, 9, movetoworkspace, 9"
        "$mainMod SHIFT, 0, movetoworkspace, 10"

        #specialworkspace (scratchpad in sway)
        "$mainModSHIFT, MINUS, movetoworkspace, special"
        "$mainMod, MINUS, togglespecialworkspace"
        "$mainMod, MINUS, exec, hyprctl keyword decoration:blur:special false  "

        # Scroll through existing workspaces with mainMod + scroll
        "$mainMod, mouse_down, workspace, e+1"
        "$mainMod, mouse_up, workspace, e-1"

      ];

      binde = [

        # resizewindow
        "$mainMod,right,resizeactive,10 0"
        "$mainMod,left,resizeactive,-10 0"
        "$mainMod,up,resizeactive,0 -10"
        "$mainMod,down,resizeactive,0 10"

        # movewindow
        "$mainModSHIFT,right,moveactive,10 0"
        "$mainModSHIFT,left,moveactive,-10 0"
        "$mainModSHIFT,up,moveactive,0 -10"
        "$mainModSHIFT,down,moveactive,0 10"

        #volume
        ",XF86AudioRaiseVolume, exec, ~/.config/scripts/volume.sh volume_up" # increase volume
        ",XF86AudioLowerVolume, exec, ~/.config/scripts/volume.sh volume_down" # decreases volume

      ];


      bindm = [

        # Move/resize windows with mainMod + LMB/RMB and dragging
        "$mainMod, mouse:272, movewindow"
        "$mainMod, mouse:273, resizewindow"

      ];


    };
  };

}
