{ pkgs, dsl, ... }: {

  plugins = [
    pkgs.vimPlugins.cmp-nvim-lsp
    pkgs.vimPlugins.cmp-buffer
    pkgs.vimPlugins.cmp-path
    pkgs.vimPlugins.cmp-cmdline
    pkgs.vimPlugins.cmp-nvim-lua
    pkgs.vimPlugins.luasnip
    pkgs.vimPlugins.cmp_luasnip
    pkgs.vimPlugins.cmp-rg
    pkgs.vimPlugins.friendly-snippets
  ];

  use.cmp.setup = dsl.callWith {

    # Disable in telescope buffers
    enabled = dsl.rawLua ''
      function()
          if vim.bo.buftype == "prompt" then
              return false
          end
          return true
      end
    '';

    snippet.expand = dsl.rawLua ''
      function(args)
          require("luasnip").lsp_expand(args.body)
      end
    '';

    mapping = {
      "['<C-n>']" = dsl.rawLua
        "require('cmp').mapping.select_next_item({ behavior = require('cmp').SelectBehavior.Insert })";
      "['<C-p>']" = dsl.rawLua
        "require('cmp').mapping.select_prev_item({ behavior = require('cmp').SelectBehavior.Insert })";
      "['<Down>']" = dsl.rawLua
        "require('cmp').mapping.select_next_item({ behavior = require('cmp').SelectBehavior.Select })";
      "['<Up>']" = dsl.rawLua
        "require('cmp').mapping.select_prev_item({ behavior = require('cmp').SelectBehavior.Select })";
      "['<C-d>']" = dsl.rawLua "require('cmp').mapping.scroll_docs(-4)";
      "['<C-f>']" = dsl.rawLua "require('cmp').mapping.scroll_docs(4)";
      "['<C-e>']" = dsl.rawLua "require('cmp').mapping.abort()";
      "['<CR>']" = dsl.rawLua
        "require('cmp').mapping.confirm({ behavior = require('cmp').ConfirmBehavior.Replace, select = true, })";
      "['<C-r>']" = dsl.rawLua
        "require('cmp').mapping.confirm({ behavior = require('cmp').ConfirmBehavior.Replace, select = true, })";
      "['<Esc>']" = dsl.rawLua ''
        function(_)
            cmp.mapping({
                i = cmp.mapping.abort(),
                c = cmp.mapping.close(),
            })
            vim.cmd("stopinsert") --- Abort and leave insert mode
        end
      '';
      "['<C-l>']" = dsl.rawLua ''
        cmp.mapping(function(_)
            if require("luasnip").expand_or_jumpable() then
                require("luasnip").expand_or_jump()
            end
        end, { "i", "s" })
      '';
    };

    sources = [
      { name = "nvim_lua"; }
      { name = "nvim_lsp"; }
      { name = "luasnip"; }
      { name = "path"; }
      {
        name = "buffer";
        keyword_length = 3;
        max_item_count = 10;
      }
      {
        name = "rg";
        keyword_length = 6;
        max_item_count = 10;
        option = { additional_arguments = "--ignore-case"; };
      }
    ];

    formatting = {
      fields = [ "kind" "abbr" "menu" ];
      format = dsl.rawLua ''
        function(entry, vim_item)
            local kind_icons = {
                Text = "",
                Method = "m",
                Function = "",
                Constructor = "",
                Field = "",
                Variable = "",
                Class = "",
                Interface = "",
                Module = "",
                Property = "",
                Unit = "",
                Value = "",
                Enum = "",
                Keyword = "",
                Snippet = "",
                Color = "",
                File = "",
                Reference = "",
                Folder = "",
                EnumMember = "",
                Constant = "",
                Struct = "",
                Event = "",
                Operator = "",
                TypeParameter = "",
            }
            vim_item.kind = string.format("%s", kind_icons[vim_item.kind])
            vim_item.menu = ({
                luasnip = "[Snippet]",
                buffer = "[Buffer]",
                path = "[Path]",
                rg = "[Grep]",
                nvim_lsp = "[LSP]",
                nvim_lua = "[Lua]",
            })[entry.source.name]
            return vim_item
        end
      '';
    };

    experimental = {
      native_menu = false; # Use cmp menu instead of Vim menu
      ghost_text = true; # Show preview auto-completion
    };

  };

  lua = ''
    -- Use buffer source for `/`
    require('cmp').setup.cmdline("/", {
        sources = {
            { name = "buffer", keyword_length = 5 },
        },
    })

    -- Use cmdline & path source for ':'
    require('cmp').setup.cmdline(":", {
        sources = require('cmp').config.sources({
            { name = "path" },
        }, {
            { name = "cmdline" },
        }),
    })
  '';

}
