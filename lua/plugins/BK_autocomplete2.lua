return {
  'saghen/blink.cmp',
  -- lazy = false,
  lazy = true,
  dependencies = { 'rafamadriz/friendly-snippets', 'echasnovski/mini.icons', 'L3MON4D3/LuaSnip', },

  -- use a release tag to download pre-built binaries
  version = '1.*',
  ---@module 'blink.cmp'
  ---@type blink.cmp.Config

  opts = {
    -- Default list of enabled providers defined so that you can extend it
    -- elsewhere in your config, without redefining it, due to `opts_extend`
    sources = {
      default = { 'lsp', 'path', 'snippets', 'buffer' },
    },

    -- Enable luasnip to handle snippet expansion for blink.cmp
    snippets = {
      preset = 'luasnip',
      expand = function(args)
        require('luasnip').lsp_expand(args.body)  
      end,
    },

    signature = { enabled = true },

    -- See :h blink-cmp-config-keymap for defining your own keymap
    --
    -- TODO: There might be an alternative for this now, or this might be doable just with blink
    -- actions (like accept w/ callback to start, then snippet_forward/backward fallback)
    keymap = {
      preset = 'default',
      ['<C-j>'] = { 'select_next' },
      ['<C-k>'] = { 'select_prev' },
      ['<C-l>'] = {
        function(cmp)
          local luasnip = require('luasnip')
          if luasnip.expandable() then
          -- if luasnip.expand_or_locally_jumpable() then
            -- luasnip will try to write to the blink window unless we close it first
            cmp.cancel()
            vim.schedule(function() luasnip.expand_or_jump() end)
            return true
          elseif luasnip.jumpable(1) then
            cmp.cancel()
            vim.schedule(function() luasnip.jump(1) end)
            return true
          end
          return false
        end, 'select_and_accept'
        -- end, 'cancel'
      },

    -- TODO: There might be an alternative for this now, or this might be doable just with blink
    -- actions (like accept w/ callback to start, then snippet_forward/backward fallback)
      ['<C-h>'] = {
        function(cmp)
          local luasnip = require('luasnip');
          if luasnip.jumpable(-1) then
            -- luasnip will try to write to the blink window unless we close it first
            cmp.cancel()
            vim.schedule(function() luasnip.jump(-1) end)
            return true
          end
        end
        -- end, 'cancel'
      },
    },


    appearance = {
      nerd_font_variant = 'normal'
      -- nerd_font_variant = 'mono'
    },

    completion = {
      documentation = { auto_show = true, auto_show_delay_ms = 300, window = { border = 'double' }, }, -- TODO: do we prefer this on a keymap?
      menu = {
        auto_show = true,
        auto_show_delay_ms = 400,
        min_width = 15,
        max_height = 12,
        border = 'rounded', -- rounded, single, double, none, or custom box drawing
        -- winblend = 5,
        -- winhighlight = 'Normal:BlinkCmpSignatureHelp,FloatBorder:BlinkCmpSignatureHelpBorder',
        winhighlight = 'Normal:BlinkCmpMenu,FloatBorder:BlinkCmpMenuBorder,CursorLine:BlinkCmpMenuSelection,Search:None',
        scrollbar = true, -- Note that the gutter will be disabled when border ~= 'none'
        direction_priority = { 'n', 's' },
        -- Disable if you run into performance issues
        draw = {
          columns = { {'label', 'label_description', gap = 1}, {'kind_icon', 'kind', gap = 1}, {'source_name'}, },
          treesitter = { 'lsp' },
          padding = { 0, 0 },
          snippet_indicator = '~',
          components = {
            kind_icon = {
              text = function(ctx)
                local kind_icon, _, _ = require('mini.icons').get('lsp', ctx.kind)
                return kind_icon .. ' '
              end,
              -- (optional) use highlights from mini.icons
              highlight = function(ctx)
                local _, hl, _ = require('mini.icons').get('lsp', ctx.kind)
                return hl
              end,
            },
            kind = {
              -- (optional) use highlights from mini.icons
              highlight = function(ctx)
                local _, hl, _ = require('mini.icons').get('lsp', ctx.kind)
                return hl
              end,
            },
            -- TODO: need to make the rest of the components
          },
        },
      },
    },

    -- (Default) Rust fuzzy matcher for typo resistance and significantly better performance
    -- You may use a lua implementation instead by using `implementation = "lua"` or fallback to the lua implementation,
    -- when the Rust fuzzy matcher is not available, by using `implementation = "prefer_rust"`
    --
    -- See the fuzzy documentation for more information
    fuzzy = { implementation = "prefer_rust_with_warning" }
  },
  -- opts_extend = { "sources.default" }
}



    -- -- Experimental signature help support
    -- signature = {
    --   enabled = false,
    --   trigger = {
    --     -- Show the signature help automatically
    --     enabled = true,
    --     -- Show the signature help window after typing any of alphanumerics, `-` or `_`
    --     show_on_keyword = false,
    --     blocked_trigger_characters = {},
    --     blocked_retrigger_characters = {},
    --     -- Show the signature help window after typing a trigger character
    --     show_on_trigger_character = true,
    --     -- Show the signature help window when entering insert mode
    --     show_on_insert = false,
    --     -- Show the signature help window when the cursor comes after a trigger character when entering insert mode
    --     show_on_insert_on_trigger_character = true,
    --   },
    --   window = {
    --     min_width = 1,
    --     max_width = 100,
    --     max_height = 10,
    --     border = nil, -- Defaults to `vim.o.winborder` on nvim 0.11+ or 'padded' when not defined/<=0.10
    --     winblend = 0,
    --     winhighlight = 'Normal:BlinkCmpSignatureHelp,FloatBorder:BlinkCmpSignatureHelpBorder',
    --     scrollbar = false, -- Note that the gutter will be disabled when border ~= 'none'
    --     -- Which directions to show the window,
    --     -- falling back to the next direction when there's not enough space,
    --     -- or another window is in the way
    --     direction_priority = { 'n', 's' },
    --     -- Can accept a function if you need more control
    --     -- direction_priority = function()
    --     --   if condition then return { 'n', 's' } end
    --     --   return { 's', 'n' }
    --     -- end,
    -- 
    --     -- Disable if you run into performance issues
    --     treesitter_highlighting = true,
    --     show_documentation = true,
    --   },
    -- }

