---@diagnostic disable: unused-local
vim.g.mapleader = ' '
vim.g.maplocalleader = ' '
-- [[ Basic Keymaps ]]

require('keymaps')

-- [[ Install `lazy.nvim` plugin manager ]]
--    https://github.com/folke/lazy.nvim
--    `:help lazy.nvim.txt` for more info
local lazypath = vim.fn.stdpath 'data' .. '/lazy/lazy.nvim'
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system {
    'git',
    'clone',
    '--filter=blob:none',
    'https://github.com/folke/lazy.nvim.git',
    '--branch=stable', -- latest stable release
    lazypath,
  }
end
vim.opt.rtp:prepend(lazypath)

-- [[ Configure plugins ]]
-- NOTE: Here is where you install your plugins.
--  You can configure plugins using the `config` key.
--
--  You can also configure plugins after the setup call,
--    as they will be available in your neovim runtime.
-- require('lazy').setup('custom.one_liners')
if vim.g.vscode then
  -- require('vscode_settings')
  require('lazy').setup({
    { 'numToStr/Comment.nvim',     opts = {} },

    -- { 'junegunn/vim-peekaboo', },
    { 'asvetliakov/vim-easymotion' },
  }, {});
else
  require('lazy').setup({
    {
      "m4xshen/hardtime.nvim",
      lazy = false,
      dependencies = { "MunifTanjim/nui.nvim" },
      opts = {},
    },
    { 'loctvl842/monokai-pro.nvim' },
    { import = 'custom' },
    -- NOTE: This is where your plugins related to LSP can be installed.
    --  The configuration is done below. Search for lspconfig to find it below.
    {
      'echasnovski/mini.nvim',
      version = '*',
      config = function()
        -- require('mini.cursorword').setup()
        -- require('mini.indentscope').setup()
        require('mini.bracketed').setup()
        require('mini.ai').setup()
        require('mini.move').setup()
      end
    },
    {
      'windwp/nvim-autopairs',
      event = "InsertEnter",
      config = true
      -- use opts = {} for passing setup options
      -- this is equalent to setup({}) function
    },
    {
      "kylechui/nvim-surround",
      version = "*", -- Use for stability; omit to use `main` branch for the latest features
      event = "VeryLazy",
      config = function()
        require("nvim-surround").setup()
      end
    },
    {
      -- Set lualine as statusline
      'nvim-lualine/lualine.nvim',
      -- See `:help lualine.txt`
      opts = {
        options = {
          icons_enabled = false,
          theme = 'auto',
          component_separators = '|',
          section_separators = '',
        },
      },
    },

    {
      -- Add indentation guides even on blank lines
      'lukas-reineke/indent-blankline.nvim',
      -- Enable `lukas-reineke/indent-blankline.nvim`
      -- See `:help ibl`
      main = 'ibl',
      opts = {},
    },
    {
      'leoluz/nvim-dap-go',
      config = function()
        require('dap-go').setup({
          -- Additional dap configurations can be added.
          -- dap_configurations accepts a list of tables where each entry
          -- represents a dap configuration. For more details do:
          -- :help dap-configuration
          dap_configurations = {
            {
              -- Must be "go" or it will be ignored by the plugin
              type = "go",
              name = "Attach remote",
              mode = "remote",
              request = "attach",
            },
          },
          -- delve configurations
          delve = {
            -- the path to the executable dlv which will be used for debugging.
            -- by default, this is the "dlv" executable on your PATH.
            path = "dlv",
            -- time to wait for delve to initialize the debug session.
            -- default to 20 seconds
            initialize_timeout_sec = 20,
            -- a string that defines the port to start delve debugger.
            -- default to string "${port}" which instructs nvim-dap
            -- to start the process in a random available port.
            -- if you set a port in your debug configuration, its value will be
            -- assigned dynamically.
            port = "${port}",
            -- additional args to pass to dlv
            args = {},
            -- the build flags that are passed to delve.
            -- defaults to empty string, but can be used to provide flags
            -- such as "-tags=unit" to make sure the test suite is
            -- compiled during debugging, for example.
            -- passing build flags using args is ineffective, as those are
            -- ignored by delve in dap mode.
            -- avaliable ui interactive function to prompt for arguments get_arguments
            build_flags = {},
            -- whether the dlv process to be created detached or not. there is
            -- an issue on Windows where this needs to be set to false
            -- otherwise the dlv server creation will fail.
            -- avaliable ui interactive function to prompt for build flags: get_build_flags
            detached = vim.fn.has("win32") == 0,
            -- the current working directory to run dlv from, if other than
            -- the current working directory.
            cwd = nil,
          },
          -- options related to running closest test
          tests = {
            -- enables verbosity when running the test.
            verbose = false,
          },
        })
      end
    },
    { "nvim-neotest/nvim-nio" },

    require 'kickstart.plugins.autoformat',
    require 'kickstart.plugins.debug',

  }, {}
  )

  -- [[ Setting options ]]
  -- See `:help vim.o`
  -- NOTE: You can change these options as you wish!

  require('settings')


  -- [[ Highlight on yank ]]
  -- See `:help vim.highlight.on_yank()`
  local highlight_group = vim.api.nvim_create_augroup('YankHighlight', { clear = true })
  vim.api.nvim_create_autocmd('TextYankPost', {
    callback = function()
      vim.highlight.on_yank()
    end,
    group = highlight_group,
    pattern = '*',
  })

  -- [[ Configure Telescope ]]
  -- See `:help telescope` and `:help telescope.setup()`

  require('telescope_settings')

  -- [[ Configure Treesitter ]]
  -- See `:help nvim-treesitter`
  -- Defer Treesitter setup after first render to improve startup time of 'nvim {filename}'

  require('treesitter_settings')

  -- [[ Configure LSP ]]
  --  This function gets run when an LSP connects to a particular buffer.

  require('lsp_settings')
  vim.g.rustaceanvim = {
    -- Plugin configuration
    tools = {
    },
    -- LSP configuration
    server = {
      on_attach = function(client, bufnr)
        -- you can also put keymaps in here
      end,
      default_settings = {
        -- rust-analyzer language server configuration
        ['rust-analyzer'] = {
        },
      },
    },
    -- DAP configuration
    dap = {
    },
  }

  -- [[ Configure nvim-cmp ]]
  -- See `:help cmp`

  require('cmp_settings')

  -- [[ Custom commands ]]

  vim.cmd [[command! Vterm execute 'vsplit | term']]
  vim.cmd [[command! Sterm execute 'split | term']]
  vim.cmd [[colorscheme gruvbox]]
end
-- The line beneath this is called `modeline`. See `:help modeline`
-- vim: ts=2 sts=2 sw=2 et
