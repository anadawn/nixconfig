#  ──────────────────────────────────────────
#    specific system configuration for my:           
#                                                
#            ╦  ╔═╗╔═╗╔╦╗╔═╗╔═╗                             
#            ║  ╠═╣╠═╝ ║ ║ ║╠═╝                              
#            ╩═╝╩ ╩╩   ╩ ╚═╝╩  
#
#  flake.nix
#   ├── ./hosts
#   │       ├─ default.nix 
#   │       ├── configuation.nix
#   │       └─ ./laptop
#   │            ├─ default.nix *
#   │            └── hardware-configuration.nix
#   └── modules
#       └── programs
#          └── kdeconnect.nix             
#  ──────────────────────────────────────────

{ pkgs, user, lib, ... }:

{
  imports =
    [
      # Include the results of the hardware scan.
      ./hardware-configuration.nix
      ./cpu.nix
      ./rollback.nix
       ../../modules/impermanence
       ../../modules/programs/plymouth
    ];

  # adb
  programs.adb.enable = true;


  # teamviewer 
  #services.teamviewer.enable = true;

  # Doridcam
  # programs.droidcam.enable = true;

  #opengl
  hardware.opengl = {
    enable = true;
    driSupport = true;
    driSupport32Bit = true;
   
  };


  # services.flatpak.enable = true;

  networking.hostName = "mylaptop";

  # bluetooth 
  hardware.bluetooth.enable = true;
  # services.blueman.enable = true;

  # Bootloader.
  boot = {
    loader = {
      systemd-boot.enable = true;
      timeout = 0;
      # UEFI settings
      efi = {
        canTouchEfiVariables = true;
        efiSysMountPoint = "/boot";
      };
    };
    tmp.useTmpfs = true;
    # get latest kernel
    kernelPackages = pkgs.linuxPackages_latest;
    kernel.sysctl = { "vm.swappiness" = 10; };
    # consoleLogLevel = 3;
    # kernelParams = [ "quiet" ];
  };

   services.flatpak.enable = true;

  #virtualisation
  virtualisation.libvirtd = {
    enable = true;
    package = pkgs.libvirt;
    qemu.ovmf = {
      enable = true;
      packages = [ pkgs.OVMFFull.fd ];
    };
  };

  # Configure network proxy if necessary
  # networking.proxy.default = "http://user:password@proxy:port/";
  # networking.proxy.noProxy = "127.0.0.1,localhost,internal.domain";

  # laptop screen brightness
  programs.light.enable = true;


  # List packages installed in system profile. To search, run:
  # $ nix search wget
  environment.systemPackages = with pkgs; [
    # Do not forget to add an editor to edit configuration.nix! The Nano editor is also installed by default.
    # linuxKernel.packages.linux_6_4.v4l2loopback
  ];


  #  ──────────────────────────────────────────
  #                                                                     #                 
  #    ╦ ╦╔═╗╔╦╗╔═╗   ╔╦╗╔═╗╔╗╔╔═╗╔═╗╔═╗╦═╗
  #    ╠═╣║ ║║║║║╣ ───║║║╠═╣║║║╠═╣║ ╦║╣ ╠╦╝ 
  #    ╩ ╩╚═╝╩ ╩╚═╝   ╩ ╩╩ ╩╝╚╝╩ ╩╚═╝╚═╝╩╚═    
  #        Begin home-manager directives
  #                                                                     #                 
  #  ──────────────────────────────────────────

  home-manager = {
    users.${user} = { config, pkgs, inputs, lib, ... }: {

      imports = [
        ../../modules/WindowManagers/hyprland/default.nix
      ]
      ++ (import ../../modules/services);


      home.packages = with pkgs; [
        neofetch
	unzip
        virt-manager
	signal-desktop
        #htop
        gdu # disk management
        tdesktop # telegram
        gurk-rs
	wl-clipboard

       # lobster-movie # cli tool for streaming movies and series
       # oi # cli program for quick google search
       # tt # cli typing test
       # redqu # media centric reddit client 
       # gogpt # media centric reddit client 
        chpaper
        scripts
      ];


      #zsh
      programs.zsh.shellAliases = {
        # all shell aliases

        # rebuild nixos using flake
        re = "pushd ~/nixconfig
           \n doas nixos-rebuild switch --flake '.#laptop'
           \n popd";

        # turn on laptop screen on and off in sway
        lo = "swaymsg output eDP-1 dpms off";
        ln = "swaymsg output eDP-1 dpms on";
        # nix-shell with rust development tools
        rus =
          " 
            	   cp ~/nixconfig/modules/languages/rust/{flake.nix,flake.lock} ~/rust/\
            	   cd ~/rust \ 
            	   nix develop -c $SHELL\
                       ";
        # update configuation.nix to git repository
        yt = "ytfzf -t --thumb-viewer=kitty -f -s --detach -l --preview-side=right"; # youtube 
      };

    };
  };
} # end of configuration
