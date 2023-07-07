{ ... }:

{
  programs.nushell = {
    enable = true;
    configFile = {
      text = ''
        	       let-env config = {
        	         show_banner: false
        	         completions: {
                           case_sensitive: false # set to true to enable case-sensitive completions
                           quick: true  # set this to false to prevent auto-selecting completions when only one remains
                           partial: true  # set this to false to prevent partial filling of the prompt
                           algorithm: "fuzzy"  # prefix or fuzzy

                           external: {
                            enable: true # set to false to prevent nushell looking into $env.PATH to find more suggestions, `false` recommended for WSL users as this look up may be very slow
                            max_results: 100 # setting it lower can improve completion performance at the cost of omitting some options
                            completer: null # check 'carapace_completer' above as an example
                           }
                         } 
                         cursor_shape: {
                         emacs: line # block, underscore, line, blink_block, blink_underscore, blink_line (line is the default)
                         vi_insert: line # block, underscore, line , blink_block, blink_underscore, blink_line (block is the default)
                         vi_normal: block # block, underscore, line, blink_block, blink_underscore, blink_line (underscore is the default)
                         }
                         edit_mode: vi 
                         keybindings: [
                         {
                          name: completion_menu
                          modifier: none
                          keycode: tab
                          mode: [emacs vi_normal vi_insert]
                          event: {
                           until: [
                           { send: menu name: completion_menu }
                           { send: menunext }
                           ]
                          }
                         }

                         {
                         name: completion_previous
                         modifier: shift
                         keycode: backtab
                         mode: [emacs, vi_normal, vi_insert] # Note: You can add the same keybinding to all modes by using a list
                         event: { send: menuprevious }
                         }
                         ]
                         }
        	       '';
    };
    shellAliases = {
      ll = "ls -l";
      # update nixos using flakes
      update = "pushd ~/nixconfig 
                \ndoas nix flake update
               \npopd";


      gp = "pushd ~/nixconfig
             \ngit add * 
             \ngit commit  
             \ngit push 
             \npopd ";

      # w3m with google search 
      gg = "w3m google.com";
    };

  };

}
