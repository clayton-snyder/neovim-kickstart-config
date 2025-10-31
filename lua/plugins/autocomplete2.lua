return {
  'saghen/blink.cmp',
  -- optional: provides snippets for the snippet source
  dependencies = { 'rafamadriz/friendly-snippets', 'echasnovski/mini.icons', },

  -- use a release tag to download pre-built binaries
  version = '1.*',
  ---@module 'blink.cmp'
  ---@type blink.cmp.Config
  opts = {
    -- See :h blink-cmp-config-keymap for defining your own keymap
    keymap = { preset = 'default' },

    appearance = {
      nerd_font_variant = 'normal'
      -- nerd_font_variant = 'mono'
    },

    -- (Default) Only show the documentation popup when manually triggered
    -- completion = { documentation = { auto_show = true } },
    completion = {
      documentation = { auto_show = true },
      menu = {
        min_width = 50,
        max_height = 10,
        border = 'padded', -- Defaults to `vim.o.winborder` on nvim 0.11+ or 'padded' when not defined/<=0.10
        winblend = 5,
        winhighlight = 'Normal:BlinkCmpSignatureHelp,FloatBorder:BlinkCmpSignatureHelpBorder',
        scrollbar = true, -- Note that the gutter will be disabled when border ~= 'none'
        -- Which directions to show the window,
        -- falling back to the next direction when there's not enough space,
        -- or another window is in the way
        direction_priority = { 'n', 's' },
        -- Can accept a function if you need more control
        -- direction_priority = function()
        --   if condition then return { 'n', 's' } end
        --   return { 's', 'n' }
        -- end,
    
        -- Disable if you run into performance issues
        draw = {
          padding = { 1, 2 },
          components = {
            kind_icon = {
              text = function(ctx)
                local kind_icon, _, _ = require('mini.icons').get('lsp', ctx.kind)
                return kind_icon
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
            }
          }
        }
      },
    },
    -- window = {
    -- },
    -- Default list of enabled providers defined so that you can extend it
    -- elsewhere in your config, without redefining it, due to `opts_extend`
    sources = {
      default = { 'lsp', 'path', 'snippets', 'buffer' },
    },

    -- (Default) Rust fuzzy matcher for typo resistance and significantly better performance
    -- You may use a lua implementation instead by using `implementation = "lua"` or fallback to the lua implementation,
    -- when the Rust fuzzy matcher is not available, by using `implementation = "prefer_rust"`
    --
    -- See the fuzzy documentation for more information
    fuzzy = { implementation = "prefer_rust_with_warning" }
  },
  opts_extend = { "sources.default" }
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

