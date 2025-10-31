return {
  'nvim-lualine/lualine.nvim',
  config = function()
    local mode = {
      'mode',
      fmt = function(str)
        return ' ' .. str
        -- return ' ' .. str:sub(1, 1) -- displays only the first character of the mode
      end,
    }
-- function starts_with(str, start)
--    return str:find("^" .. start) ~= nil
-- end
-- local myString = "Hello World"
-- print(starts_with(myString, "Hello")) -- Output: true
-- print(starts_with(myString, "World")) -- Output: false
    local cms_drive = function()
      local filename = vim.fn.expand('%:p')

      if filename:find("^%a:") then 
        return filename:sub(1, 2)
      elseif filename:lower():find("^/mnt") then
        return filename:sub(1, 7)
      elseif filename:lower():find("^/") then
        return "VHD?"
      end

      print("Can't extract drive from '" .. filename .. "'")
      return "??"
    end

    -- CMS: Of the current buffer file, NOT necessarily the working directory!
    local cms_siglodir = function()
      local filename = vim.fn.expand('%:p')
      if filename == nil then
        print('cms_siglodir(): filename is null!')
        return 'ERR:NILARG'
      end

      local siglos_base = os.getenv('SIGLOS_DIR')
      if siglos_base == nil then
        print('cms_siglodir(): SIGLOS_DIR env var is null!')
        return 'ERR:NILENV'
      end

      -- local filename_l = filename:lower()
      -- local siglos_base_l = siglos_base:lower()
      local filename = filename:gsub('\\', '/')
      local siglos_base = siglos_base:gsub('\\', '/')

      local from, to = filename:lower():find(siglos_base:lower())
      if from == nil or to == nil then
        return '_NO_'
      end
      
      local rel = filename:sub(to + 1)
      if rel:sub(1, 1) == '/' then
        rel = rel:sub(2)
      end

      to, _ = rel:find('/')
      if to == nil or to < 2 then
        print("cms_siglodir(): unexpected relative filepath: '" .. rel .. "'")
        return 'ERR:PARSE'
      end

      return rel:sub(1, to - 1)
    end

    local cms_drive_active = {
      cms_drive,
    }

    local cms_siglodir_active = {
      cms_siglodir,
    }

    local filename_active = {
      'filename',
      file_status = true, -- displays file status (readonly status, modified status)
      path = 2, -- 0 = just filename, 1 = relative path, 2 = absolute path
      -- color = { gui = 'bold', bg = 'NvimDarkBlue', fg = 'NvimLightYellow'}
      color = { gui = 'bold', bg = 'Blue', fg = 'NvimLightYellow' }
    }

    local branch_active = {
      'branch',
      color = { gui = 'bold', bg = 'Orange', fg = 'NvimDarkBlue'}
    }

    local hide_in_width = function()
      return vim.fn.winwidth(0) > 100
    end

    local diagnostics = {
      'diagnostics',
      sources = { 'nvim_diagnostic' },
      sections = { 'error', 'warn' },
      -- symbols = { error = ' ', warn = ' ', info = ' ', hint = ' ' },
      symbols = { error = ' ', warn = ' ', info = ' ', hint = ' ' },
      colored = true,
      -- color = { gui = 'bold', bg = 'NvimDarkRed', fg = 'NvimLightGreen'},
      color = { bg = 'NvimDarkBlue', fg = 'NvimLightYellow'},
      update_in_insert = false,
      always_visible = false,
      cond = hide_in_width,
    }

    local diff = {
      'diff',
      colored = true,
      -- color = { gui = 'bold', bg = 'NvimDarkBlue', fg = 'NvimLightYellow'},
      color = { bg = 'NvimDarkRed', fg = 'NvimLightGreen'},
      symbols = { added = ' ', modified = ' ', removed = ' ' }, -- changes diff symbols
      cond = hide_in_width,
    }

    require('lualine').setup {
      options = {
        icons_enabled = true,
        -- theme = 'nord', -- Set theme based on environment variable
        -- theme = 'tokyonight',
        -- Some useful glyphs:
        -- https://www.nerdfonts.com/cheat-sheet
        --        
        section_separators = { left = '', right = '' },
        component_separators = { left = '', right = '' },
        disabled_filetypes = { 'alpha', 'neo-tree' },
        -- always_divide_middle = true,
        always_divide_middle = false,
      },

      sections = {
        lualine_a = { mode, cms_drive_active, cms_siglodir_active  },
        -- lualine_b = { 'branch', color = { bg = 'Blue', fg = 'Yellow' } },
        lualine_b = { filename_active, diff },
        lualine_c = { branch_active },
        lualine_x = { diagnostics,
          { 
            'encoding',
            cond = hide_in_width,
            color = { gui = 'bold', bg = 'NvimDarkBlue', fg = 'NvimLightYellow'},
          }, 
          { 'filetype', cond = hide_in_width,
            color = { gui = 'bold', bg = 'NvimDarkBlue', fg = 'NvimLightYellow'},
          },
        },
        -- lualine_y = { 'location', color = { bg = 'Blue', fg = 'Yellow'} },
        lualine_z = { 'location', 'progress' },
      },
      inactive_sections = {
        lualine_a = {},
        lualine_b = { { 'filename', path = 2, color = {bg = 'NvimDarkBlue', fg = 'NvimLightGray4' } } },
        lualine_c = { { 'branch', color = { bg = 'NvimDarkBlue', fg = 'NvimDarkGray4' } } },
        lualine_x = { { 'location', padding = 0, color = {bg = 'NvimDarkBlue', fg = 'NvimLightYellow' } } },
        lualine_y = {},
        lualine_z = {},
      },
      tabline = {},
      extensions = { 'fugitive' },
    }
  end,
}
