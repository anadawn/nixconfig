#  ──────────────────────────────────────────
#           ╔═╗╦═╗╔═╗╔═╗╦═╗╔═╗╔╦╗╔═╗
#           ╠═╝╠╦╝║ ║║ ╦╠╦╝╠═╣║║║╚═╗
#           ╩  ╩╚═╚═╝╚═╝╩╚═╩ ╩╩ ╩╚═╝
#           My essential applications
#
#           flake.nix
#           ├─ ./hosts
#           │    ├── default.nix
#           │    └── configuration.nix 
#           ├── modules
#           └── programs
#               ├── default.nix *
#               └── ... 
#  ──────────────────────────────────────────

[
  ./gh.nix
  ./git.nix
  ./kitty.nix
  ./lf.nix
  ./mpv.nix
  ./htop.nix
  #./nvim.nix
  ./starship.nix
  ./waybar.nix
  #./wofi.nix
  ./firefox.nix
  ./neomutt.nix
  ./password-store.nix
  ./dconf.nix
  #./mako.nix
  #./dunst.nix
  ./pistol.nix
  #./NeST.nix
  #./qute.nix
  ./chromium.nix
  #./atuin.nix
  #./plymouth
  ./nixvim.nix
  ./aria2.nix
  ./rofi.nix
]

# dunst has been replaced by mako
