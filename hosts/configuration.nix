# ──────────────────────────────────────────
#        ╔╦╗╔═╗╦╔╗╔╔═╗╔═╗╔╗╔╔═╗╦╔═╗
#        ║║║╠═╣║║║║║  ║ ║║║║╠╣ ║║ ╦
#        ╩ ╩╩ ╩╩╝╚╝╚═╝╚═╝╝╚╝╚  ╩╚═╝
#         Main configuration file 
#
#         flake.nix
#         ├─ ./hosts
#         │    ├── configuration.nix *
#         │    ├── default.nix
#         │    ├── laptop
#         │    │    ├── default.nix
#         │    │    └── hardware-configuration.nix
#         │    └── vm
#         │         ├── default.nix
#         │         └── hardware-configuration.nix
#         ├── modules
#         ├── programs
#         │    └─ default.nix
#         ├── shell
#         │    └── zsh.nix
#         └── WindowManagers
#              └── sway.nix
#  ──────────────────────────────────────────

{ pkgs, user, ... }:

{
  imports =
    [
      #./hardware-configuration.nix
    ];


  # Enable flakes 
  nix = {
    package = pkgs.nixFlakes;
    settings = {
      auto-optimise-store = true;
      experimental-features = [ "nix-command" "flakes" ];
    };
  };# 

  # move nix daemon from ram to disk 
  systemd.services.nix-daemon = {
    environment = {
      #location for temporary files
      TMPDIR = "/var/cache/nix";
    };
    serviceConfig = {
      # create /var/cache/nix automatically on nix deamon start
      CacheDirectory = "nix";
    };
  };# ∇

  # Enable networking
  networking.networkmanager.enable = true;

  # Set your time zone.
  time.timeZone = "Asia/Kolkata";

  # Select internationalisation properties.
  i18n.defaultLocale = "en_US.UTF-8";

  #tty 
  console = {
    keyMap = "us";
    font = "Lat2-Terminus16";
  };# 

  #autologint
  services.getty.autologinUser = "aruna";

  # enable zram
  # zramSwap.enable = true;
  # zramSwap.memoryPercent = 50;



  # dconf (for gtk apps to work properly)
  programs.dconf = {
    enable = true;
  };


  # git 
  programs.git.enable = true;

  #pam 
  security.pam.services = {
    swaylock = { }; # for swaylock to work 
    # gpg 
    ${user}.gnupg = {
      enable = true;
    };
  }; 

  # Define a user account. Don't forget to set a password with ‘passwd’. 
  users = {
    defaultUserShell = pkgs.zsh;
    users.${user} = {
      isNormalUser = true;
      extraGroups = [ "networkmanager" "wheel" "video" "libvirtd" "audio" "adbusers" ];
      packages = with pkgs; [
        # user packages 
      ];
    };
  }; 

  programs.zsh.enable = true;

  # allow unfree packages
  nixpkgs.config.allowUnfree = true;


  environment.systemPackages = with pkgs; [
    git-crypt
    wget
  ];

  # remove installed by default packages like nano
  environment.defaultPackages = [ ];

  # bash 
  programs.bash = {
    enableCompletion = true;
    enableLsColors = true;
    promptInit = ''eval "$(starship init bash)"'';
  }; 


  # enable doas 
  security = {
    doas = {
      enable = true;
      # Configure doas 
      extraRules = [{
        users = [ "${user}" ];
        keepEnv = true;
        persist = true;
      }];  
    };
    sudo.enable = false; # disable sudo
  }; 

  # fonts
  fonts.packages = with pkgs; [
    carlito
    vegur
    noto-fonts
    (nerdfonts.override { fonts = [ "Ubuntu" ]; }) # for swaybar config
  ];  


  # qt5 
  qt = {
    platformTheme = "qt5ct";
    style = "gtk2";
  };  

  environment = {
    pathsToLink = [ "/share/zsh" ];
    shells = [ pkgs.zsh ];
    variables = {
      TERMINAL = "kitty";
      NIX_REMOTE = "daemon"; # force nix command to call the daemon
      EDITOR = "nvim";
      VISUAL = "nvim";
      QT_QPA_PLATFORMTHEME = "qt5ct";
      ANDROID_HOME = ''"$XDG_DATA_HOME"/android'';
      CARGO_HOME = ''"$XDG_DATA_HOME"/cargo'';
    };
  };


  # Gtk theme 
  #environment.sessionVariables = {GTK_THEME="WhiteSur-Dark-solid";};

  # pipewire 
  security.rtkit.enable = true;
  services.pipewire = {
    enable = true;
    wireplumber = {
      enable = true;
    };
    alsa = {
      enable = true;
      support32Bit = true;
    };
    pulse.enable = true;
    jack.enable = true;
  };  

  # authorisation
  security.polkit.enable = true;

  # recent fix for break 
  #systemd.user.services.pipewire-pulse.path = [ pkgs.pulseaudio ];

  # xdg-desktop-portal works by exposing a series of D-Bus interfaces
  # known as portals under a well-known name
  # (org.freedesktop.portal.Desktop) and object path
  # (/org/freedesktop/portal/desktop).
  # The portal interfaces include APIs for file access, opening URIs,
  # printing and others.

  # dbus 
  services.dbus = {
    enable = true;
    packages = with pkgs; [ gcr gcr_4 ]; # for gpg authorisation
  };

  #xdg 
  xdg = {
    mime = {
      enable = true;
      defaultApplications = {
        "application/pdf" = "firefox.desktop";
        "image/png" = "imv";
      };
    };
    portal = {
      enable = true;
      wlr.enable = true;
      extraPortals = [ pkgs.xdg-desktop-portal-gtk ];
    };
  };  


  # Enable the OpenSSH daemon 
  services.openssh = {
    enable = true;
    ports = [ 22 ];
    settings = {
      PermitRootLogin = "no";
    };
    hostKeys = [
      {
        path = "/etc/ssh/keys/ssh_host_ed25519_key";
        type = "ed25519";
      }
      {
        path = "/etc/ssh/keys/ssh_host_rsa_key";
        type = "rsa";
        bits = "4096";
      }
    ];
  };


  # Open ports in the firewall.
  networking.firewall = {
    allowedTCPPortRanges = [
      # kdconnect
      { from = 1714; to = 1764; }
    ];
    allowedTCPPorts = [
      #8080 8000 
    ]; # sharing
  };

  networking.firewall.allowedUDPPortRanges = [
    # kdeconnect 
    { from = 1741; to = 1764; }
  ];



  # Or disable the firewall altogether.
  # networking.firewall.enable = false;

  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It‘s perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "22.05"; # Did you read the comment?


  #  ──────────────────────────────────────────
  #                                                                                      
  #    ╦ ╦╔═╗╔╦╗╔═╗   ╔╦╗╔═╗╔╗╔╔═╗╔═╗╔═╗╦═╗
  #    ╠═╣║ ║║║║║╣ ───║║║╠═╣║║║╠═╣║ ╦║╣ ╠╦╝ 
  #    ╩ ╩╚═╝╩ ╩╚═╝   ╩ ╩╩ ╩╝╚╝╩ ╩╚═╝╚═╝╩╚═    
  #        Begin home-manager directives
  #                                                                                      
  #  ──────────────────────────────────────────

  home-manager = {
    users.${user} = { config, pkgs, inputs, ... }: {

      imports = [
        # ../modules/WindowManagers/sway.nix
      ]
      ++ (import ../modules/programs)
      ++ (import ../modules/shell);


      programs.home-manager = {
        enable = true;
      };

      # fzf
      programs.fzf = {
        enable = true;
        enableZshIntegration = true;
      };


      home = {
        packages = with pkgs; [
          w3m # terminal browser
          glow # terminal markdown reader
          xdg-utils # for xdg-open to work
          ytfzf # terminal youtube 
          glib # gsettings
          toot # mastodon cli client
          wtype
          ripgrep
          swaylock
          wl-clipboard
        ];

        file = {
          ".themes".source = ../modules/themes/.themes;
          ".config/scripts".source = ../config/scripts;
          ".config/ytfzf/subscriptions".source = ../config/ytfzf/subscriptions;
          ".w3m/keymap".source = ../config/w3m/keymap;

        };
        stateVersion = "22.05";
      };


      #default home directories
      xdg = {
        enable = true;
        userDirs = {
          enable = true;
          createDirectories = true;
          templates = null;
          publicShare = null;
          music = null;
          desktop = null;
          extraConfig = {
            XDG_OTHER_DIR = "${config.home.homeDirectory}/Other";
          };
        };
      };

      # themes
      gtk = {
        enable = true;
        gtk2.configLocation = "${config.xdg.configHome}/gtk-2.0/gtkrc";
        theme = {
          name = "Catppuccin-Mocha";
        };
        cursorTheme = {
          name = "Catppuccin-Mocha-Dark-Cursors";
          package = pkgs.catppuccin-cursors.mochaDark;
          size = 29;
        };
      };

      qt = {
        enable = true;
        platformTheme = "gtk";
      };


    }; #end of home-manager programs



  }; # end of home-manager

} # end of configuration

