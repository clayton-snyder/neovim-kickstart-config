return
{
  {
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
  },
  {
      "tiagovla/tokyodark.nvim",
      opts = {
          -- custom options here
          transparent_background = true,
      },
      config = function(_, opts)
          require("tokyodark").setup(opts) -- calling setup is optional
          vim.cmd [[colorscheme tokyodark]]
      end,
  },
}
