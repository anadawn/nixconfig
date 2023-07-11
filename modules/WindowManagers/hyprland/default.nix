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

{ pkgs, ... }: {

  wayland.windowManager.hyprland = {
    enable = true;
    recommendedEnvironment = true;
    extraConfig = ''
                    source=~/testfolder/conf.conf
                    bind=,XF86MonBrightnessDown,exec,${pkgs.light}/bin/light -U 10
                    bind=,XF86MonBrightnessUP,exec,${pkgs.light}/bin/light -A 10

                    monitor= eDP-1, preferred,auto,1.05


                    # Some default env vars.
                    env = XCURSOR_SIZE,24

                    input {
                        kb_layout = us
                        kb_variant =
                        kb_model =
                        kb_options =
                        kb_rules =

                        follow_mouse = 1

                        touchpad {
                            natural_scroll = true 
                        }

                        sensitivity = 0 # -1.0 - 1.0, 0 means no modification.
                    }

                    general {

                        gaps_in = 3
                        gaps_out = 5 
                        border_size = 2

                        layout = master 
                    }

                    decoration {

                        rounding = 10
                    }



                    }


                    dwindle {
                        pseudotile = true # master switch for pseudotiling. Enabling is bound to mainMod + P in the keybinds section below
                        preserve_split = true # you probably want this
                    }

                    master {
                        new_is_master = true
                        new_on_top = true
                    }

                    gestures {
                        workspace_swipe = false
                    }

                    # Example per-device config
                    device:epic-mouse-v1 {
                        sensitivity = -0.5
                    }

                    # animation
                    animation =  windowsMove, 1, 3, default, slide
                    animation = windows, 0, 3, default 
                    animation = fade, 0, 1, default 
                    animation = border, 0, 1, default 
                    animation = borderangle, 0, 1, default 
                    animation = workspaces, 1, 3, default 

                    # Example windowrule v1
                    #windowrule = float, size 100 200, title:^(sway-launcher-desktop)$

                    # launcher 
                    windowrulev2 = float, class:^(launcher)$ 
                    windowrulev2 = size 30% 50%, class:^(launcher)$ 
                    windowrulev2 = center, class:^(launcher)$ 
                    windowrulev2 = dimaround, class:^(launcher)$ 
		    
		    # reserved areas
                    monitor=eDP-1,addreserved,0,150,0,0
		    

                    # mpv
                    windowrulev2 = float, class:^(mpv)$ 
                    windowrulev2 = size 99.5% 78%, class:^(mpv)$ 
                    windowrulev2 = move 0 4, class:^(mpv)$ 

            	    # playlist
                    windowrulev2 = float, class:^(mpv)$,title:^(playlist)$
                    windowrulev2 = size 8% 14.2%, class:^(mpv)$,title:^(playlist)$
                    windowrulev2 = move 90.8% 2.3%, class:^(mpv)$,title:^(playlist)$
                    #windowrulev2 = workspace special, class:^(mpv)$,title:^(playlist)$
                    windowrulev2 = noinitialfocus, class:^(mpv)$,title:^(playlist)$

                    # kitty
                    windowrulev2 = float, class:^(ytfzf)$ 
                    windowrulev2 = size 74% 74%, class:^(ytfzf)$ 
                    windowrulev2 = move 13% 3%, class:^(ytfzf)$ 

                    #sleep and lock
                    # exec = swayidle before-sleep 'swaylock -fc 000000'
                    # exec = swayidle timeout 120 'swaylock -fc 000000'

                    # wallpaper
                    exec = ${pkgs.scripts}/bin/chpaper ${pkgs.catppuccin-wallpaper}
      
                    # workspace on eDP-1
                    workspace = 1, monitor:eDP-1
                    workspace = 3, monitor:eDP-1
                    workspace = 5, monitor:eDP-1
                    workspace = 7, monitor:eDP-1
                    workspace = 9, monitor:eDP-1

                    # workspace on external monitor
                    workspace = 2, monitor:HDMI-A-1,default:true
                    workspace = 4, monitor:HDMI-A-1
                    workspace = 6, monitor:HDMI-A-1
                    workspace = 8, monitor:HDMI-A-1
                    workspace = 0, monitor:HDMI-A-1


                    $mainMod = SUPER

                    # hide waybar
                    bindr = SUPER, SUPER_L, exec, pkill waybar || waybar

                    # floating, fullscreen and focus
                    bind = $mainModSHIFT, SPACE, fullscreen,1
                    bind = $mainMod, F, fullscreen,0
                    bind = MOD4SHIFT, F, fakefullscreen
                    bind = $mainMod, SPACE, cyclenext 
        	    bind = $mainModALT, SPACE, togglefloating

      		    # resizewindow
                    bind= $mainMod,right,resizeactive,10 0
                    bind= $mainMod,left,resizeactive,-10 0
                    bind= $mainMod,up,resizeactive,0 -10
                    bind= $mainMod,down,resizeactive,0 10

      		    # movewindow
                    bind= $mainModSHIFT,right,moveactive,10 0
                    bind= $mainModSHIFT,left,moveactive,-10 0
                    bind= $mainModSHIFT,up,moveactive,0 -10
                    bind= $mainModSHIFT,down,moveactive,0 10


                    bind = $mainMod, RETURN, exec, kitty
                    bind = $mainModSHIFT,Q, killactive,
                    bind = $mainModSHIFT, E, exit,
                    bind = $mainMod, D, exec, rofi -show drun 
                    bind = $mainMod, P, exec, tessen -d rofi

                    # hyprland reload
                    bind = $mainModSHIFT, c, exec, hyprctl reload

                    # swap master window 
                    bind = $mainMod, M, layoutmsg,swapwithmaster
                  	   bind = $mainModSHIFT, M, layoutmsg, focusmaster

                    # firefox
                    bind = $mainMod, B, exec, firefox 
                    bind = $mainModALT, Y, exec, firefox https://www.youtube.com
                    bind = $mainModSHIFT, N , exec, firefox https://mipmip.github.io/home-manager-option-search/
                    bind = $mainMod, N, exec, firefox https://search.nixos.org/packages

                    # ytfzf
                    bind = $mainMod, Y, exec, kitty --class=ytfzf -e ytfzf -t -T chafa -l -s -f --preview-side=right
                    bind = $mainMod, s, exec, kitty --class=ytfzf -e ytfzf -t -T kitty -l -s -f -c S --preview-side=right

            	       

                    # scripts
                    bind = $mainModSHIFT, B, exec, ~/.config/scripts/bookmarks.sh # calls a script which show bookmarks
                    bind = $mainModSHIFT, Y, exec, ~/.config/scripts/yt_cli.sh
                    bind = $mainMod, R, exec, ~/.config/scripts/powermenu.sh
                    bind = $mainModALT, B, exec, ~/.config/scripts/add_bookmark.sh
                    bind = $mainMod, C, exec, ~/.config/scripts/conf.sh
                    bind = $mainMod, O, exec, ~/.config/scripts/laptopscreen.sh
            	    bind = $mainModSHIFT, P, exec, ~/.config/scripts/playlist.sh #ytmusic playlist
            	    bind = $mainModSHIFT, S, exec, ~/.config/scripts/change-sink.sh #change audio sink while connected to external display
            	    bind = $mainModSHIFT, D, exec, ~/.config/scripts/bluetooth.sh #select bluetooth devices


                    # kitty in floating window
                    bind = $mainModSHIFT, RETURN, exec, kitty --class=ytfzf

                    #volume
                    bind = ,XF86AudioRaiseVolume, exec, ~/.config/scripts/volume.sh volume_up # increase volume
                    bind = ,XF86AudioLowerVolume, exec, ~/.config/scripts/volume.sh volume_down
                    bind = ,XF86AudioMute, exec, wpctl set-mute @DEFAULT_AUDIO_SINK@ toggle # mute

                    # Move focus with mainMod + vim keys
                    bind = $mainMod, H, movefocus, l
                    bind = $mainMod, L, movefocus, r
                    bind = $mainMod, K, movefocus, u
                    bind = $mainMod, J, movefocus, d


                    # move window with vim keys
                    bind = $mainModSHIFT, H, movewindow, l
                    bind = $mainModSHIFT, L, movewindow, r
                    bind = $mainModSHIFT, K, movewindow, u
                    bind = $mainModSHIFT, J, movewindow, d

                    # Switch workspaces with mainMod + [0-9]
                    bind = $mainMod, 1, workspace, 1
                    bind = $mainMod, 2, workspace, 2
                    bind = $mainMod, 3, workspace, 3
                    bind = $mainMod, 4, workspace, 4
                    bind = $mainMod, 5, workspace, 5
                    bind = $mainMod, 6, workspace, 6
                    bind = $mainMod, 7, workspace, 7
                    bind = $mainMod, 8, workspace, 8
                    bind = $mainMod, 9, workspace, 9
                    bind = $mainMod, 0, workspace, 10

                    # Move active window to a workspace with mainMod + SHIFT + [0-9]
                    bind = $mainMod SHIFT, 1, movetoworkspace, 1
                    bind = $mainMod SHIFT, 2, movetoworkspace, 2
                    bind = $mainMod SHIFT, 3, movetoworkspace, 3
                    bind = $mainMod SHIFT, 4, movetoworkspace, 4
                    bind = $mainMod SHIFT, 5, movetoworkspace, 5
                    bind = $mainMod SHIFT, 6, movetoworkspace, 6
                    bind = $mainMod SHIFT, 7, movetoworkspace, 7
                    bind = $mainMod SHIFT, 8, movetoworkspace, 8
                    bind = $mainMod SHIFT, 9, movetoworkspace, 9
                    bind = $mainMod SHIFT, 0, movetoworkspace, 10

                    #specialworkspace (scratchpad in sway)
                    bind = $mainModSHIFT, MINUS, movetoworkspace, special
                    bind = $mainMod, MINUS, togglespecialworkspace

                    # Scroll through existing workspaces with mainMod + scroll
                    bind = $mainMod, mouse_down, workspace, e+1
                    bind = $mainMod, mouse_up, workspace, e-1

                    # Move/resize windows with mainMod + LMB/RMB and dragging
                    bindm = $mainMod, mouse:272, movewindow
                    bindm = $mainMod, mouse:273, resizewindow
    '';
  };

}
