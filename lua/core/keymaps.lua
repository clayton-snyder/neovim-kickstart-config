-- Set leader key
vim.g.mapleader = ' '
vim.g.maplocalleader = ' '

-- Disable the spacebar key's default behavior in Normal and Visual modes
vim.keymap.set({ 'n', 'v' }, '<Space>', '<Nop>', { silent = true })

-- TODO: don't use opts, and instead supply descriptions. Or make a func to add desc. Actually yeah do that second one
local opts = { noremap = true, silent = false }


-- save file
vim.keymap.set('n', '<C-s>', '<cmd> w <CR>', opts)

-- save file without auto-formatting
vim.keymap.set('n', '<leader>sn', '<cmd>noautocmd w <CR>', opts)

-- quit file
-- vim.keymap.set('n', '<C-q>', '<cmd> q <CR>', opts)
vim.keymap.set('n', '<leader>q', ':bnext<CR> :bdelete #<CR>')

-- Don't overwrite copy register when deleting or pasting
vim.keymap.set('n', 'x', '"_x', opts)
vim.keymap.set('n', 'dd', '"_dd', { noremap = true, silent = true, desc = 'Delete without copying.' })
vim.keymap.set('n', 'D', '"_D', { noremap = true, silent = true, desc = 'Delete without copying.' })
vim.keymap.set('v', 'd', '"_d', { noremap = true, silent = true, desc = 'Delete without copying.' })
vim.keymap.set('v', 'D', '"_D', { noremap = true, silent = true, desc = 'Delete without copying.' })
vim.keymap.set('v', 'p', '"_dP', { noremap = true, silent = true, desc = 'Paste without copying.' })
vim.keymap.set('n', 'cw', '"_cw', { noremap = true, silent = true, desc = 'Change without copying.' })
vim.keymap.set('n', 'ciw', '"_ciw', { noremap = true, silent = true, desc = 'Change without copying.' })
vim.keymap.set('n', 'caw', '"_caw', { noremap = true, silent = true, desc = 'Change without copying.' })

-- Vertical scroll
vim.keymap.set('n', '<C-d>', '10j', opts)
vim.keymap.set('n', '<C-u>', '10k', opts)

-- Jump to previous buffer (toggles)
vim.keymap.set('n', '<leader>H', ':b#<CR>', { noremap = true, desc = 'Jump to previous buffer (toggles)' })

-- Find and center
vim.keymap.set('n', '<C-n>', 'nzzzv', opts)
vim.keymap.set('n', '<C-p>', 'Nzzzv', opts)

-- Move line up/do
vim.keymap.set('n', '<C-K>', ':m -2 <CR>', opts)
vim.keymap.set('n', '<C-J>', ':m +1 <CR>', opts)

vim.keymap.set('n', '<Esc>', ':noh <CR>', { noremap = true, desc = 'Clear search highlights.' })

-- Resize with arrows
vim.keymap.set('n', '<Up>', ':resize -2<CR>', opts)
vim.keymap.set('n', '<Down>', ':resize +2<CR>', opts)
vim.keymap.set('n', '<Left>', ':vertical resize -2<CR>', opts)
vim.keymap.set('n', '<Right>', ':vertical resize +2<CR>', opts)

-- Buffers
vim.keymap.set('n', '<Tab>', ':bnext<CR>', opts)
vim.keymap.set('n', '<S-Tab>', ':bprevious<CR>', opts)
vim.keymap.set('n', '<leader>xbx', ':bdelete!<CR>', opts) -- close buffer
vim.keymap.set('n', '<leader>b', '<cmd> enew <CR>', opts) -- new buffer

-- Open quickfix list
vim.keymap.set('n', '<leader>oq', ':copen<CR>', { silent = false, desc = '[O]pen [Q]uickfix List'}) 

-- Window management
vim.keymap.set('n', '<leader>v', '<C-w>v', opts) -- split window vertically
vim.keymap.set('n', '<leader>h', '<C-w>s', opts) -- split window horizontally
vim.keymap.set('n', '<leader>se', '<C-w>=', opts) -- make split windows equal width & height
vim.keymap.set('n', '<leader>xs', ':close<CR>', opts) -- close current split window

-- Navigate between splits
-- vim.keymap.set('n', '<C-k>', ':wincmd k<CR>', opts)
-- vim.keymap.set('n', '<C-j>', ':wincmd j<CR>', opts)
-- vim.keymap.set('n', '<C-h>', ':wincmd h<CR>', opts)
vim.keymap.set('n', '<C-;>', ':wincmd w <CR>');
-- vim.keymap.set('n', '<C-l>', ':win:cmd l<CR>', opts)

-- Tabs
vim.keymap.set('n', '<leader>to', ':tabnew<CR>', opts) -- open new tab
vim.keymap.set('n', '<leader>tx', ':tabclose<CR>', opts) -- close current tab
vim.keymap.set('n', '<leader>tn', ':tabn<CR>', opts) --  go to next tab
vim.keymap.set('n', '<leader>tp', ':tabp<CR>', opts) --  go to previous tab

-- Toggle line wrapping
vim.keymap.set('n', '<leader>lw', '<cmd>set wrap!<CR>', opts)

-- Stay in indent mode
vim.keymap.set('v', '<', '<gv', opts)
vim.keymap.set('v', '>', '>gv', opts)


-- Diagnostic keymaps
vim.keymap.set('n', '[d',
  function()
    vim.diagnostic.goto_prev({ severity = { min = vim.diagnostic.severity.ERROR }, wrap = true })  
  end,
  { desc = 'Go to previous diagnostic error' }
)

vim.keymap.set('n', ']d',
  function()
    vim.diagnostic.goto_next({ severity = { min = vim.diagnostic.severity.ERROR }, wrap = true })  
  end,
  { desc = 'Go to previous diagnostic error' }
)

vim.keymap.set('n', '<leader>d', vim.diagnostic.open_float, { desc = 'Open floating diagnostic message' })
vim.keymap.set('n', '<leader>D', vim.diagnostic.setloclist, { desc = 'Open diagnostics list' })

vim.keymap.set('n', 'K', function() vim.lsp.buf.hover({
  border = 'double',
  max_width = 100,
  max_height = 30,
}) end, { silent = false, desc = 'Open hover menu' })

local is_opaque = true
vim.keymap.set({ 'i', 'n' }, '<C-A-o>',
  function()
    local changed = 0
    for _, winid in pairs(vim.api.nvim_tabpage_list_wins(0)) do
      if vim.api.nvim_win_get_config(winid).zindex then
        if is_opaque then
          vim.api.nvim_set_option_value('winblend', 100, { win = winid })
          is_opaque = false
        else
          vim.api.nvim_set_option_value('winblend', 0, { win = winid })
          is_opaque = true
      end
        changed = changed + 1
      end
    end
    print(changed .. ' windows affected.')
  end,
  { noremap = true, silent = false, desc = 'Toggle opacity of floating windows' }
)
