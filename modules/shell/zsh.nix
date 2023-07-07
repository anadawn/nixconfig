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
    enableSyntaxHighlighting = true;
    enableAutosuggestions = true;
    dotDir = ".config/zsh";
    history.path = "${config.xdg.dataHome}/zsh/zsh_history";
    autocd = true;
    shellAliases = {
      ll = "ls -l";
      ls = "ls --color=always";
      nt = ''pushd ~; find nixconfig/notes -name '*.md' | fzf --preview="glow {}" | xargs vi; popd'';
      sc = ''pushd ~; find nixconfig/config/scripts -name '*.sh' | fzf --preview="glow {}" | xargs vi; popd'';
      notes = ''pushd ~; find Documents/notes/vimwiki/ -name '*.md' | fzf --preview="glow {}" | xargs glow -p; popd'';
      conf = ''pushd ~; find nixconfig -name '*.nix' | fzf --preview="pistol {}" | xargs vi; popd''; # nixos configuration
      # update nixos using flakes
      update = "pushd ~/nixconfig 
                \n doas nix flake update
                \n popd";


      gp = "pushd ~/nixconfig
            \n git add * 
            \n git commit  
            \n git push 
            \n popd ";

      # w3m with google search 
      gg = "w3m google.com";
    };

    completionInit = "autoload -Uz compinit
                      zstyle ':completion:*' menu select
                      zmodload zsh/complist
                      compinit
                      ";


    # envExtra = 

    # defaultKeymap = "viins";
    profileExtra = ''
      if [ -z $DISPLAY ] && [ "$(tty)" = "/dev/tty1" ] ; then
       exec Hyprland
      fi
    '';
    initExtra =
      ''eval "$(starship init zsh)"  
      export KEYTIMEOUT=1
      unsetopt BEEP
      # bindkey -M menuselect 'h' vi-backward-char
      # bindkey -M menuselect 'k' vi-up-line-or-history
      # bindkey -M menuselect 'l' vi-forward-char
      # bindkey -M menuselect 'j' vi-down-line-or-history
      # bindkey -v '^?' backward-delete-char
      #
      # function zle-keymap-select {
      #  if [[ ''${KEYMAP} == vicmd ]] ||
      #     [[ $1 = 'block' ]]; then 
      #   echo -ne '\e[1 q'
      #  elif [[ ''${KEYMAP} == main ]] ||
      #       [[ ''${KEYMAP} == viins ]] ||
      #       [[ ''${KEYMAP} == ' ' ]] ||
      #       [[ $1 = 'beam' ]]; then 
      #     echo -ne '\e[5 q'
      #    fi
      #  }
      # zle -N zle-keymap-select
      # zle-line-init() {
      #   zle -K viins
      #   echo -ne "\e[5q"
      # }
      # zle -N zle-line-init
      # echo -ne '\e[5 q'
      # preexec() { echo -ne '\e[5 q' ;}
      #

      source ${pkgs.zsh-vi-mode}/share/zsh-vi-mode/zsh-vi-mode.plugin.zsh

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

