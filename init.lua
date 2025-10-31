require 'core.options' -- Load general options
require 'core.keymaps' -- Load general keymaps
require 'core.etc' -- Custom code snippets

-- Set up the Lazy plugin manager
local lazypath = vim.fn.stdpath 'data' .. '/lazy/lazy.nvim'
if not (vim.uv or vim.loop).fs_stat(lazypath) then
  local lazyrepo = 'https://github.com/folke/lazy.nvim.git'
  local out = vim.fn.system { 'git', 'clone', '--filter=blob:none', '--branch=stable', lazyrepo, lazypath }
  if vim.v.shell_error ~= 0 then
    error('Error cloning lazy.nvim:\n' .. out)
  end
end
vim.opt.rtp:prepend(lazypath)

-- Set up plugins
require('lazy').setup {
  require 'plugins.lazydev',
  require 'plugins.yazi',
  require 'plugins.colortheme',
  require 'plugins.bufferline',
  require 'plugins.lualine',
  require 'plugins.treesitter',
  require 'plugins.telescope',
  require 'plugins.BK_autocomplete2',
  require 'plugins.gitsigns',
  require 'plugins.alpha',
  require 'plugins.indent-blankline',
  require 'plugins.misc',
  require 'plugins.comment',
  require 'plugins.flash',
  require 'plugins.harpoon',
  require 'plugins.lsp',
}

for _, ft_path in ipairs(vim.api.nvim_get_runtime_file('lua/core/snippets/*.lua', true)) do
  loadfile(ft_path)()
end


-- TODO: These should all go somewhere else probably, but need to find out where they're written.
vim.api.nvim_set_hl(0, "DiagnosticInfo", { fg = 'NvimDarkGray4' })
vim.api.nvim_set_hl(0, "DiagnosticHint", { fg = 'NvimDarkGray3' })
vim.api.nvim_set_hl(0, "NormalFloat", { fg = '#a0a8cd', bg = 'Black' })
vim.api.nvim_set_hl(0, "FloatBorder", { fg = '#a0a8cd', bg = 'Black' })
vim.api.nvim_set_hl(0, "CursorLine", { bg = '#212234' })

-- The line beneath this is called `modeline`. See `:help modeline`
-- vim: ts=2 sts=2 sw=2 et
