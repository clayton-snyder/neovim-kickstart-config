-- Standalone plugins with less than 10 lines of config go here
return {
  -- {
  --   -- Tmux & split window navigation
  --   'christoomey/vim-tmux-navigator',
  -- },
  {
    -- Detect tabstop and shiftwidth automatically
    'tpope/vim-sleuth',
    event = "VeryLazy",
  },
  {
    -- Powerful Git integration for Vim
    'tpope/vim-fugitive',
    event = "VeryLazy",
  },
  {
    -- GitHub integration for vim-fugitive
    'tpope/vim-rhubarb',
    event = "VeryLazy",
  },
  {
    -- Hints keybinds
    'folke/which-key.nvim',
    event = "VeryLazy",
    opts = {
      win = {
        border = 'double',
        -- padding = 0,
        padding = { 0, 0 },
        -- wo = {
          -- winblend = 75,
          -- winhighlight = NameOfHighlightGroup,
        -- },
      }
    },
  },
 {
    -- Autoclose parentheses, brackets, quotes, etc.
    'windwp/nvim-autopairs',
    event = 'InsertEnter',
    config = true,
    opts = {},
  },
  {
    -- Highlight todo, notes, etc in comments
    'folke/todo-comments.nvim',
    event = 'VimEnter',
    dependencies = { 'nvim-lua/plenary.nvim' },
    opts = { signs = false },
  },
  {
    -- High-performance color highlighter
    'norcalli/nvim-colorizer.lua',
    config = function()
      require('colorizer').setup()
    end,
  },
}
