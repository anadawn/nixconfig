{ pkgs, config, ... }: {

  programs.nixvim = {
    enable = true;
    vimAlias = true;
    viAlias = true;


    options = {
      relativenumber = true;
      number = true;
      ignorecase = true;
      splitright = true;
      splitbelow = true;
      termguicolors = true;
      list = true;
      showmode = false;
      clipboard = "unnamedplus";
      wrap = true;
    };

    globals = {
      mapleader = " ";
      qs_highlight_on_keys = [ "f" "F" "t" "T" ];
    };

    maps = {
      normal = {
        "j" = "gj";
        "k" = "gk";

        "<Leader>j" = {
          silent = true;
          action = ":bp<CR>";
        };

        "<Leader>k" = {
          silent = true;
          action = ":bn<CR>";
        };

        "<Leader>q" = {
          silent = true;
          action = ":bp<CR>:bd #<CR>";
        };

        "<Leader>z" = {
          silent = true;
          action = ":split term://zsh<CR>";
        };

        "<Leader>t" = {
          silent = true;
          action = ":NvimTreeToggle<CR>";
        };

        "<Leader>v" = {
          silent = true;
          action = ":VimtexCompile<CR>";
        };

        "<Leader>e" = {
          silent = true;
          action = ":TroubleToggle<CR>";
        };

        "<Leader>w" = {
          silent = true;
          action = "<C-w>k";
        };

        "<Leader>a" = {
          silent = true;
          action = "<C-w>h";
        };

        "<Leader>s" = {
          silent = true;
          action = "<C-w>j";
        };

        "<Leader>d" = {
          silent = true;
          action = "<C-w>l";
        };

        "<Leader>p" = {
          silent = true;
          action = ":w !python<CR>";
        };

      };
      terminal = {
        "<Leader><Esc>" = {
          silent = true;
          action = "exit<CR>";
        };
      };
    };

    extraPlugins = with pkgs.vimPlugins; [
      catppuccin-nvim
      git-blame-nvim
      quick-scope
      vimwiki
      friendly-snippets
    ];

    extraPackages = with pkgs; [
      nil
    ];

    colorscheme = "catppuccin";

    extraConfigLuaPre = ''
                   require("catppuccin").setup {
                   flavour = "mocha",
                   compile_path = vim.fn.stdpath "cache" .. "/catppuccin",
                   color_overrides = { 
                    mocha = { 
            	base = "#161718", },
            	}, 
            	} 

            vim.g.gitblame_date_format = '%r'
            vim.g.gitblame_message_when_not_committed = '''

      	'';
    extraConfigLua = '' 
                   require("lualine").setup { 
                   tabline = {
		    lualine_a = {
                    {
		     "buffers",
                     separator = { left = "", right = ""},
		     right_padding = 5,
                     top_padding = 5,
                     symbols = { alternate_file = "" },
                    },
                   },
	          },
                  }
		  require'lspconfig'.nil_ls.setup{}
		  '';


    plugins = {
      treesitter = {
        enable = true;
        grammarPackages = with config.programs.nixvim.plugins.treesitter.package.builtGrammars; [
          bash
          gitcommit
          gitignore
          git_rebase
          markdown
          markdown_inline
          nix
          rust
          toml
          yaml
          go
          latex
        ];
        indent = true;
        incrementalSelection.enable = true;

      };

      nvim-cmp = {
        enable = true;
        sources = [
          { name = "buffer"; }
          { name = "nvim_lsp"; }
          { name = "nvim_lsp_document_symbol"; }
          { name = "nvim_lsp_signature_help"; }
          { name = "treesitter"; }
          { name = "luasnip"; }
        ];
        snippet = {
          expand = "luasnip";
        };
        mapping = {
          "<CR>" = "cmp.mapping.confirm({select = true})";
          "<Tab>" = {
            modes = [ "i" "s" ];
            action = ''
              function(fallback)
                if cmp.visible() then
                  cmp.select_next_item()
                elseif luasnip.expandable() then
                  luasnip.expand()
                elseif luasnip.expand_or_jumpable() then
                  luasnip.expand_or_jump()
                elseif check_backspace() then
                  fallback()
                else
                  fallback()
                end
              end
            '';
          };
        };
      };
      cmp-buffer.enable = true;
      cmp-nvim-lsp.enable = true;
      cmp-nvim-lsp-document-symbol.enable = true;
      cmp-nvim-lsp-signature-help.enable = true;
      cmp-treesitter.enable = true;
      cmp_luasnip.enable = true;

      luasnip = {
        enable = true;
	fromVscode = [
	  {}
	  { lazyLoad = true; }
	];

      };

      lsp = {
        enable = true;
        servers = {
          # rnix-lsp.enable = true;
          rust-analyzer.enable = true;
	  pylsp.enable = true;
        };
      };

      nvim-autopairs.enable = true;
      comment-nvim.enable = true;
      trouble.enable = true;
      vimtex = {
        enable = true;
        extraConfig = {
          compiler_enabled = true;
        };
      };

      indent-blankline = {
        enable = true;
        showEndOfLine = true;
      };

      nvim-tree = {
        enable = true;
        disableNetrw = true;
        hijackCursor = true;
        hijackNetrw = true;
        syncRootWithCwd = true;
        filesystemWatchers.enable = true;
        git = {
          enable = true;
          ignore = true;
        };
        updateFocusedFile = {
          enable = true;
        };
        view = {
          width = 25;
        };
        renderer = {
          indentMarkers.enable = true;
        };

      };

      lualine = {
        enable = true;
        globalstatus = true;
        componentSeparators = {
          left = "|";
          right = "|";
        };
        sectionSeparators = {
          left = "";
          right = "";
        };
        sections = {
          lualine_a = [{ separator = { left = ""; }; }];
          lualine_b = [ "filename" "branch" "diff" ];
          lualine_c = [ ];
          lualine_x = [ ];
          lualine_y = [ "filetype" "progress" ];
          lualine_z = [{ separator = { right = ""; }; }];
        };

        inactiveSections = {

          lualine_a = [ "filename" ];
          lualine_b = [ ];
          lualine_c = [ ];
          lualine_x = [ ];
          lualine_y = [ ];
          lualine_z = [ ];

        };



      };

    };


  };

}
