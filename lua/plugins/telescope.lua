return {
  'nvim-telescope/telescope.nvim',
  event = 'VimEnter',
  -- branch = '0.1.x',
  branch = 'master',
  dependencies = {
    'nvim-lua/plenary.nvim',
    { -- If encountering errors, see telescope-fzf-native README for installation instructions
      'nvim-telescope/telescope-fzf-native.nvim',

      -- `build` is used to run some command when the plugin is installed/updated.
      -- This is only run then, not every time Neovim starts up.
      build = 'make',

      -- `cond` is a condition used to determine whether this plugin should be
      -- installed and loaded.
      cond = function()
        -- return vim.fn.executable 'make' == 1
        return true
      end,
    },
    { 'nvim-telescope/telescope-ui-select.nvim' },
    -- { 'nvim-telescope/telescope-fzf-writer.nvim' },

    -- Useful for getting pretty icons, but requires a Nerd Font.
    { 'nvim-tree/nvim-web-devicons', enabled = vim.g.have_nerd_font },
  },
  config = function()
    require('telescope').setup {
      --  All the info you're looking for is in `:help telescope.setup()`
      defaults = {
        mappings = {
          i = {
            ['<C-k>'] = require('telescope.actions').move_selection_previous, -- move to prev result
            ['<C-j>'] = require('telescope.actions').move_selection_next, -- move to next result
            ['<C-l>'] = require('telescope.actions').select_default, -- open file
          },
        },
      },
      pickers = {
        find_files = {
          file_ignore_patterns = { 'node_modules', '%.git', '%.venv' },
          hidden = true,
        },
        live_grep = {
          file_ignore_patterns = { 'node_modules', '%.git', '%.venv' },
          debounce = 1000,
          -- temp__scrolling_limit = 50,
          -- additional_args = function(_)
          --   return { '--hidden' }
          -- end,
        },
      },
      extensions = {
        ['ui-select'] = {
          require('telescope.themes').get_dropdown(),
        },
        fzf = {
          fuzzy = true,
          override_generic_sorter = true,
          override_file_sorter = true,
          case_mode = "smart_case",
        },
        -- fzf_writer = {
        --   -- minimum_grep_characters = 4,
        --   -- minimum_files_characters = 4,
        --   use_highlighter = false,
        -- },
      },
    }

    -- Enable Telescope extensions if they are installed
    pcall(require('telescope').load_extension, 'fzf')
    -- pcall(require('telescope').load_extension, 'fzf_writer')
    pcall(require('telescope').load_extension, 'ui-select')

    -- vim.keymap.set('n', '<leader>fzfg', require('telescope').extensions.fzf_writer.grep, { desc = 'use fzf-writer grep' })
    -- vim.keymap.set('n', '<leader>fzff', require('telescope').extensions.fzf_writer.files, { desc = 'use fzf-writer files' })

    -- See `:help telescope.builtin`
    local builtin = require 'telescope.builtin'
    vim.keymap.set('n', '<leader>jl', builtin.jumplist, { desc = '[J]ump [L]ist' })
    vim.keymap.set('n', '<leader>tl', builtin.tags, { desc = '[T]ag [L]ist' })
    vim.keymap.set('n', '<leader>ml', builtin.marks, { desc = '[M]ark [L]ist' })
    vim.keymap.set('n', '<leader>sh', builtin.help_tags, { desc = '[S]earch [H]elp' })
    vim.keymap.set('n', '<leader>sk', builtin.keymaps, { desc = '[S]earch [K]eymaps' })
    vim.keymap.set('n', '<leader>sf', builtin.find_files, { desc = '[S]earch [F]iles' })
    vim.keymap.set('n', '<leader>ss', builtin.builtin, { desc = '[S]earch [S]elect Telescope' })
    vim.keymap.set('n', '<leader>sw', builtin.grep_string, { desc = '[S]earch current [W]ord' })
    -- vim.keymap.set('n', '<leader>sg', builtin.live_grep, { desc = '[S]earch by [G]rep' })
    vim.keymap.set('n', '<leader>sd', builtin.diagnostics, { desc = '[S]earch [D]iagnostics' })
    vim.keymap.set('n', '<leader>sr', builtin.resume, { desc = '[S]earch [R]esume' })
    vim.keymap.set('n', '<leader>s.', builtin.oldfiles, { desc = '[S]earch Recent Files ("." for repeat)' })
    vim.keymap.set('n', '<leader><leader>b', builtin.buffers, { desc = '[ ] Find existing buffers' })

    vim.keymap.set('n', '<leader>sga', builtin.grep_string, { desc = '[S]tatic [G]rep [A]ll' })

    vim.keymap.set('n', '<leader>cs', function()
      builtin.colorscheme {
        enable_preview = true,
        ignore_builtins = false,
      }
    end,  { desc = '[C]olor [S]chemes' })

    vim.keymap.set('n', '<leader>lgdir', function()
      local curr_dir = vim.fn.expand('%:p:h')
      builtin.live_grep {
        cwd = curr_dir,
        prompt_title = 'Live Grep in: "' .. curr_dir .. '"',
      }
    end, { desc = '[L]ive [G]rep in Current [Dir]ectory' })

    -- Slightly advanced example of overriding default behavior and theme
    vim.keymap.set('n', '<leader>fzcb', function()
      -- You can pass additional configuration to Telescope to change the theme, layout, etc.
      builtin.current_buffer_fuzzy_find(require('telescope.themes').get_dropdown {
        winblend = 10,
        previewer = false,
      })
    end, { desc = '[F]u[z]zy Find in [C]urrent [B]uffer' })

    -- It's also possible to pass additional configuration options.
    --  See `:help telescope.builtin.live_grep()` for information about particular keys
    vim.keymap.set('n', '<leader>lgof', function()
      builtin.live_grep {
        grep_open_files = true,
        prompt_title = 'Live Grep in Open Files',
      }
    end, { desc = '[L]ive [G]rep in [O]pen [F]iles' })

    -- CMS: Siglo searches. Required to split these up; the size can crash live grep.
    -- local siglo_base =  'C:\\home\\Siglo\\sdk\\'
    local cwd = vim.fn.getcwd() .. '\\'
    local programs_base = cwd .. 'Programs\\'
    local ssl_dirs = {
      programs_base .. 'Eris\\Sources\\Libraries\\ssl',
      programs_base .. 'Eris\\Sources\\Processes\\ssl',
      programs_base .. 'Eris\\Include\\nn\\ssl',
    }


    vim.keymap.set('n', '<leader>lgssl', function()
      builtin.live_grep {
        search_dirs = ssl_dirs,
        prompt_title = 'Live Grep in: "' .. ssl_dirs[1] .. "', '" .. ssl_dirs[2] .. "', '" .. ssl_dirs[3] .. '"',
        additional_args = { '--hidden' },
      }
    end, { desc = '[L]ive [G]rep in [SSL] dirs' })

    vim.keymap.set('n', '<leader>lgffssl', function()

      builtin.live_grep {
        search_dirs = ssl_dirs,
        prompt_title = 'Live Grep in: "' .. ssl_dirs[1] .. "', '" .. ssl_dirs[2] .. "', '" .. ssl_dirs[3] .. '"',
        additional_args = { '--hidden', '--max-count=1', },
      }
    end, { desc = '[L]ive [G]rep [F]ind [F]iles With in [SSL] dirs' })

    vim.keymap.set('n', '<leader>lgffprog', function()
      builtin.live_grep {
        prompt_title = 'Files Containing Query (one entry per file)',
        search_dirs = { programs_base },
        additional_args = { '--hidden', '--max-count=1' },
      }
    end, { desc = '[L]ive [G]rep [F]ind [F]iles [W]ith in [Prog]rams' })
  end,
}
