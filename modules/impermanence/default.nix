#  ──────────────────────────────────────────
#             Impermanence module
#
#     ╦╔╦╗╔═╗╔═╗╦═╗╔╦╗╔═╗╔╗╔╔═╗╔╗╔╔═╗╔═╗
#     ║║║║╠═╝║╣ ╠╦╝║║║╠═╣║║║║╣ ║║║║  ║╣ 
#     ╩╩ ╩╩  ╚═╝╩╚═╩ ╩╩ ╩╝╚╝╚═╝╝╚╝╚═╝╚═╝
#
#  ─────────────────────────────────────────



{ user, ... }: {

  # imports = [ ./users.nix ];
  users.users.${user}.hashedPassword = "$y$j9T$wYt/.olPs84rNyvFBi5xK/$qFWjsE2NPx.N3D/kFg6baamCj/hS5UIGFCpP70Yj9Z.";
 
  users.users.root.hashedPassword = "$y$j9T$wYt/.olPs84rNyvFBi5xK/$qFWjsE2NPx.N3D/kFg6baamCj/hS5UIGFCpP70Yj9Z.";
  
  programs.fuse.userAllowOther = true;

  environment.persistence."/persist" = {
    directories = [
      "/etc/nixos"
      "/var/lib/libvirt"
      "/var/lib/iwd"
      "/var/lib/bluetooth"
      "/var/lib/nixos"
      "/var/lib/systemd"
      "/var/lib/NetworkManager"
      "/var/lib/flatpak"
      "/var/lib/machines"
      "/var/log"
      "/var/cache"
      "/root/.cache/nix"
    ];

    files = [
      "/etc/machine-id"
    ];
  };

  home-manager.users.${user} = { pkgs, dag, ... }:

    {
      # imports = [ "${impermanence}/home-manager.nix" ]; 

      home.persistence."/persist/home/${user}" = {
        allowOther = true;
        directories = [
          ".android"
          ".mozilla"
          ".ssh"
          ".w3m"
	  ".var"
	  ".ipython"


          ".config/neofetch"
          ".config/htop"
          ".config/kdeconnect"
          ".config/libvirt"
          ".config/lobster"
          ".config/toot"
          ".config/gurk"
          ".config/Signal"
	  ".config/wallpaper"

          ".cache/dconf"
          ".cache/fontconfig"
          ".cache/libvirt"
          ".cache/virtmanager"
          ".cache/mesa_shader_cache"
          ".cache/mozilla"
          ".cache/nix"
          ".cache/nvim"
          ".cache/ytfzf"
          ".cache/qtshadercache-x86_64-little_endian-lp64"

          ".local/share/TelegramDesktop"
          ".local/share/zsh"
          ".local/share/applications"
          ".local/share/password-store"
          ".local/share/gurk"
          ".local/share/gnupg"
          ".local/share/flatpak"

          ".local/state/wireplumber"

         {
          directory = "nixconfig";
          method = "symlink";
         }

         {
          directory = "Downloads";
          method = "symlink";
         }

         {
          directory = "Documents";
          method = "symlink";
         }

         {
          directory = "Videos";
          method = "symlink";
         }

         {
          directory = "testfolder";
          method = "symlink";
         }

         {
          directory = "Pictures";
          method = "symlink";
         }

         {
          directory = "Other";
          method = "symlink";
         }

        ];
        files = [

          ".config/gh/hosts.yml"
          ".config/mimeapps.list"

        ];
      };
    };

}
