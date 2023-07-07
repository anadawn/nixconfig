#  ──────────────────────────────────────────
#             Impermanence module
#
#     ╦╔╦╗╔═╗╔═╗╦═╗╔╦╗╔═╗╔╗╔╔═╗╔╗╔╔═╗╔═╗
#     ║║║║╠═╝║╣ ╠╦╝║║║╠═╣║║║║╣ ║║║║  ║╣ 
#     ╩╩ ╩╩  ╚═╝╩╚═╩ ╩╩ ╩╝╚╝╚═╝╝╚╝╚═╝╚═╝
#
#  ─────────────────────────────────────────



{ user, ... }: {

  imports = [ ./users.nix ];



  programs.fuse.userAllowOther = true;

  environment.persistence."/nix/persist" = {
    directories = [
      "/etc/nixos"
      "/etc/NetworkManager/system-connections"
      "/var/lib/libvirt"
      "/var/lib/bluetooth"
      "/var/lib/nixos"
      "/var/lib/systemd"
      "/var/lib/flatpak"
      "/var/log"
      "/var/cache"
      "/root/.cache/nix"
    ];

    files = [
      "/etc/machine-id"
      "/var/lib/logrotate.status"
      "/etc/ssh/ssh_host_ed25519_key"
      "/etc/ssh/ssh_host_ed25519_key.pub"
      "/etc/ssh/ssh_host_rsa_key"
      "/etc/ssh/ssh_host_rsa_key.pub"
    ];
  };

  home-manager.users.${user} = { pkgs, dag, ... }:

    {
      # imports = [ "${impermanence}/home-manager.nix" ]; 

      home.persistence."/nix/persist/home/${user}" = {
        allowOther = true;
        directories = [
          ".android"
          ".mozilla"
          "nixconfig"
          ".ssh"
          ".w3m"

          "Desktop"
          "testfolder"
          "Downloads"
          "Documents"

          ".config/neofetch"
          ".config/htop"
          ".config/kdeconnect"
          ".config/libvirt"
          ".config/lobster"
          ".config/toot"
          ".config/gurk"

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


        ];
        files = [

          ".config/gh/hosts.yml"
          ".config/mimeapps.list"
          ".gogpt"

        ];
      };
    };

}
