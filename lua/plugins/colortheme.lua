return {
  'folke/tokyonight.nvim',
  lazy = false,
  priority = 1000,
  config = function()
    -- Example config in lua
    -- Load the colorscheme
    require('tokyonight').setup {
      styles = {
        comments = { italic = false },
      },
    }

    vim.cmd.colorscheme 'tokyonight-night'
  end,
}
