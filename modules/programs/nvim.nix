{ pkgs, ... }: {

  programs.neovim = {
    enable = true;
    viAlias = true;
    extraPackages = with pkgs; [ rnix-lsp rust-analyzer ];
    extraConfig = ''  set relativenumber 
                     set ignorecase 
                     set splitright
                     set splitbelow
                     set termguicolors
		     set clipboard+=unnamedplus
                     colorscheme catppuccin
                     map j gj
                     map k gk
                     let mapleader = " "
                     map <Leader>j :bp<CR>
                     map <Leader>k :bn<CR>
                     map <Leader>q :bp<CR>:bd #<CR>
                     map <Leader>z :split term://zsh<CR>
                     map <Leader>t :NvimTreeFocus<CR>
                     map <Leader>w <C-w>k
                     map <Leader>a <C-w>h
                     map <Leader>s <C-w>j
                     map <Leader>d <C-w>l
                     tmap <Leader><Esc> exit<CR>

                     let g:qs_highlight_on_keys = ['f', 'F', 't', 'T']
                     highlight QuickScopePrimary gui=underline cterm=underline
                     highlight QuickScopeSecondary gui=underline cterm=underline

                     let g:vimwiki_list = [{'path': '~/.nixconfig/notes/vimwiki/', 'syntax': 'markdown', 'ext': '.md'}]
                    '';
    #plugins
    plugins = with pkgs.vimPlugins; [
      #vim-nix #nix language syntaxhighlighting 
      coc-rust-analyzer # rust language support  
      quick-scope # hightlight character with f or t to move between them
      vimwiki
      cmp-nvim-lsp
      luasnip
      cmp_luasnip
      friendly-snippets



      {
        plugin = (pkgs.vimPlugins.nvim-treesitter.withPlugins (plugins: with plugins; [
          nix
          rust
          gitcommit
          gitignore
          git_rebase
          markdown
          bash
        ]));
        type = "lua";
        config = ''require'nvim-treesitter.configs'.setup {
                    highlight = {
                     enable = true,
                     additional_vim_regex_highlighting = false,
                     },
                    }'';
      }


      {
        plugin = nvim-lspconfig;
        type = "lua";
        config = ''
                    require'lspconfig'.rnix.setup{}
          	  require'lspconfig'.rust_analyzer.setup{}
        '';
      }

      {
        plugin = git-blame-nvim;
        config = ''
          let g:gitblame_date_format = '%r'
          let g:gitblame_message_when_not_committed = '''
        '';
      }

      # {
      #   plugin = rust-tools-nvim;
      #   type = "lua";
      #   config = ''
      #    require("rust-tools")
      #   '';
      # }

      {
        plugin = nvim-cmp;
        type = "lua";
        config = ''
          require('luasnip.loaders.from_vscode').lazy_load()
           vim.opt.completeopt = {'menu', 'menuone', 'noselect'}
           local cmp = require('cmp')
           local luasnip = require('luasnip')
           local check_backspace = function()
             local col = vim.fn.col(".") - 1
             return col == 0 or vim.fn.getline("."):sub(col, col):match("%s")
           end
           cmp.setup{
             completion = { autocomplete = true },
             snippet = {
               expand = function(args)
                 luasnip.lsp_expand(args.body)
               end
             },
             sources = cmp.config.sources({
               { name = 'path' },
             }, {
               { name = 'luasnip' },
               { name = 'buffer' },
             }),
             matching = {
               disallow_fuzzy_matching=true,
               disallow_partial_matching=true,
               disallow_prefix_matching=true,
             },
             mapping = {
               ['<CR>'] = cmp.mapping.confirm({select = true }),
               ['<C-Tab>'] = cmp.mapping.complete_common_string(),
               ['<Tab>'] = cmp.mapping(function(fallback)
                 if cmp.visible() then
                   if not cmp.complete_common_string() then
                     cmp.select_next_item(select_opts)
                   end
                 elseif check_backspace() then
                   fallback()
                 elseif luasnip.expandable() then
                   luasnip.expand()
                 elseif luasnip.expand_or_locally_jumpable() then
                   luasnip.expand_or_jump()
                 else
                   cmp.complete()
                 end
               end, {'i', 's'}),
               ['<S-Tab>'] = cmp.mapping(function(fallback)
                 if cmp.visible() then
                   cmp.select_prev_item(select_opts)
                 elseif luasnip.locally_jumpable(-1) then
                   luasnip.jump(-1)
                 else
                   fallback()
                 end
               end, {'i', 's'}),
             }
           }
        '';
      }

      {
        plugin = nvim-autopairs; # auto pair parantheses and quotes
        type = "lua";
        config = ''require("nvim-autopairs").setup {}'';
      }

      {
        plugin = markdown-preview-nvim;
        type = "lua";
      }

      {
        plugin = catppuccin-nvim; # theme
        type = "lua";
        config = ''require("catppuccin").setup {
       flavour = "mocha",
       background = {
       light = "latte",
       dark = "mocha",
       },
       compile_path = vim.fn.stdpath "cache" .. "/catppuccin",
       color_overrides = {
       mocha = {
       base = "#161718",
         },
        },
       integrations = {
       nvimtree = true,
         },
        }
         '';
      }




      {
        plugin = lualine-nvim; # statusline for neovim
        type = "lua";
        config = '' local cp = require("catppuccin.palettes").get_palette()
                   local custom_catppuccin = require "lualine.themes.catppuccin"
                   custom_catppuccin.normal.b.bg = cp.surface0
                   custom_catppuccin.normal.c.bg = cp.base
                   custom_catppuccin.insert.b.bg = cp.surface0
                   custom_catppuccin.command.b.bg = cp.surface0
                   custom_catppuccin.visual.b.bg = cp.surface0
                   custom_catppuccin.replace.b.bg = cp.surface0
                   custom_catppuccin.inactive.a.bg = cp.base
                   custom_catppuccin.inactive.b.bg = cp.base
                   custom_catppuccin.inactive.b.fg = cp.surface0
                   custom_catppuccin.inactive.c.bg = cp.base 
                   
                   require("lualine").setup {
                    options = {
		    theme = custom_catppuccin,
		    component_separators = "|",
		    section_separators = { left = "", right = ""},
                    },
	           sections = {
		    lualine_a = { { "mode", separator = { left = "" }, right_padding = 2 } },
		    lualine_b = { "filename", "branch", { "diff", colored = false } },
		    lualine_c = {},
		    lualine_x = {},
		    lualine_y = { "filetype", "progress" },
		    lualine_z = { { "location", separator = { right = ""}, left_padding = 2 } },
                    },
                   inactive_sections = {
		    lualine_a = { "filename" },
		    lualine_b = {},
		    lualine_c = {},
		    lualine_x = {},
		    lualine_y = {},
		    lualine_z = {},
                    },
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
                 }'';
      } # end of lualine config

      {
        plugin = nvim-tree-lua; # side folder for neovim
        type = "lua";
        config = ''                    
                  require("nvim-tree").setup{
                   disable_netrw = true,
	           hijack_netrw = true,
	           open_on_tab = false,
	           hijack_cursor = true,
	           hijack_unnamed_buffer_when_opening = false,
	           update_cwd = true,
                   
	           update_focused_file = {
                    enable = true,
                    update_cwd = false,
                   },

	           sync_root_with_cwd = true,
                   
                   view = {
		    width = 25,
		    hide_root_folder = false,
                   },

	           git = {
		    enable = false,
		    ignore = true,
                   },

	           actions = {
		    open_file = {
		     resize_window = true,
		    },
	           },

	           renderer = {
                    indent_markers = {
                    enable = false,
                    },
                   },
                  } '';
      } # end of nvim tree config
    ]; # end of neovim plugins
  }; # end of neovim



}
