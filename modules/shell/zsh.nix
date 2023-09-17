#  ──────────────────────────────────────────
#                   ══╗╔═╗╦ ╦
#                   ╔═╝╚═╗╠═╣
#                   ╚══╚═╝╩ ╩
#                 My zsh config
#
#           flake.nix
#           ├─ ./hosts
#           │    ├── default.nix
#           │    └── configuration.nix 
#           └── modules
#               └── shell 
#                    └── zsh.nix *
#  ──────────────────────────────────────────


{ pkgs, config, ... }:

{

  # shell(zsh)
  programs.zsh = {
    enable = true;
    enableCompletion = true;
    syntaxHighlighting.enable = true;
    enableAutosuggestions = true;
    dotDir = ".config/zsh";
    history.path = "${config.xdg.dataHome}/zsh/zsh_history";
    autocd = true;
    shellAliases = {
      mo = ''find Videos/ -type f -printf "%f\n" | dmenu -i -p "Movies" |
xargs -I '{}' find ~/Videos/ -name {} | xargs mpv'';
      ll = "ls -l";
      ls = "ls --color=always";
      nt = ''pushd /persist/home/aruna; find nixconfig/notes -name '*.md' | fzf --preview="glow {}" | xargs vi; popd'';
      sc = ''pushd /persist/home/aruna; find nixconfig/config/scripts -name '*.sh' | fzf --preview="pistol {}" | xargs vi; popd'';
      notes = ''glow  /persist/home/aruna/nixconfig/notes'';
      conf = ''pushd /persist/home/aruna; find nixconfig -name '*.nix' | fzf --preview="pistol {}" | xargs vi; popd''; # nixos configuration
      # update nixos using flakes
      update = "pushd ~/nixconfig 
                \n doas nix flake update
                \n popd";


      gp = "pushd ~/nixconfig
            \n git add * 
            \n git commit  
            \n git push 
            \n popd ";

      pg = "pass git push";

      # w3m with google search 
      gg = "w3m google.com";

      search = "nix search nixpkgs";
    };

    completionInit = "autoload -Uz compinit
                      zstyle ':completion:*' menu select
                      zmodload zsh/complist
                      compinit
                      ";


     envExtra = ''
	       export NIXPKGS_ALLOW_UNFREE=1
	     '';

    # defaultKeymap = "viins";
    profileExtra = ''
      if [ -z $DISPLAY ] && [ "$(tty)" = "/dev/tty1" ] ; then
       exec Hyprland
      fi
    '';
    initExtra =
      ''eval "$(starship init zsh)"

      export KEYTIMEOUT=1

      TodayDate=$(date +%d)
      TodayTime=$(date +%R)
      MonthNum=$(date +%b)
      if [ "$TodayDate" -eq "14" ]; #-a "$TodayTime" -eq 02:04 ];
      then
      echo "


╦ ╦╔═╗╔═╗╔═╗╦ ╦  ╔═╗╔╗╔╔╗╔╦╦  ╦╔═╗╦═╗╔═╗╔═╗╦═╗╦ ╦  ╔═╗╦ ╦╔═╗╦═╗╦ ╦
╠═╣╠═╣╠═╝╠═╝╚╦╝  ╠═╣║║║║║║║╚╗╔╝║╣ ╠╦╝╚═╗╠═╣╠╦╝╚╦╝  ║  ╠═╣╠═╣╠╦╝║ ║
╩ ╩╩ ╩╩  ╩   ╩   ╩ ╩╝╚╝╝╚╝╩ ╚╝ ╚═╝╩╚═╚═╝╩ ╩╩╚═ ╩   ╚═╝╩ ╩╩ ╩╩╚═╚═╝

"
fi



      # launch w3m with a search query

      ww(){
      "w3m" "http://localhost:8080/search?q=$*"
      }

      clone(){
      repo=$1
       case "$1" in
          github.com)
            "git" "clone" "git@$1:$2" $3
	  ;;
          gitlab.com)
            "git" "clone" "https://$1/$2" $3
	  ;;
	esac
      }


      unsetopt BEEP

      # vi mode
      source ${pkgs.zsh-vi-mode}/share/zsh-vi-mode/zsh-vi-mode.plugin.zsh

      # custom syntax highlighting
      ZSH_HIGHLIGHT_HIGHLIGHTERS+=(main brackets pattern root line)

      # Declare the variable
      typeset -A ZSH_HIGHLIGHT_STYLES

      # To have paths colored instead of underlined
      ZSH_HIGHLIGHT_STYLES[path]='fg=magenta'

      ZSH_HIGHLIGHT_STYLES[command-substitution]='fg=cyan,bold'

      ZSH_HIGHLIGHT_STYLES[command-substitution-unquoted]='fg=cyan,bold'

      ZSH_HIGHLIGHT_STYLES[single-hyphen-option]='fg=magenta,bold'

      ZSH_HIGHLIGHT_STYLES[double-hyphen-option]='fg=magenta,bold'

      ZSH_HIGHLIGHT_STYLES[arg0]='fg=cyan,bold'

      ZSH_HIGHLIGHT_STYLES[default]='fg=cyan'

      ZSH_HIGHLIGHT_STYLES[command]='fg=blue,bold'

      ZSH_HIGHLIGHT_STYLES[alias]='fg=blue,bold'

      ZSH_HIGHLIGHT_STYLES[suffix-alias]='fg=blue,bold'

      ZSH_HIGHLIGHT_STYLES[global-alias]='fg=blue,bold'

      ZSH_HIGHLIGHT_STYLES[builtin]='fg=blue,bold'
      '';




  };

}

