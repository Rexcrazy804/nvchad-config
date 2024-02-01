local overrides = require("custom.configs.overrides")

---@type NvPluginSpec[]
local plugins = {

  -- Override plugin definition options

  {
    "neovim/nvim-lspconfig",
    dependencies = {
      -- format & linting
      {
        "nvimtools/none-ls.nvim",
        config = function()
          require "custom.configs.null-ls"
        end,
      },
    },
    config = function()
      require "plugins.configs.lspconfig"
      require "custom.configs.lspconfig"
    end, -- Override to setup mason-lspconfig
  },
  {
    "NvChad/nvterm",
    opts = {
      terminals = {
        shell = "nu.exe",
        type_opts = {
          float = {
            relative = 'editor',
            row = 0.18,
            col = 0.125,
            width = 0.75,
            height = 0.55,
            border = "single",
          },
          horizontal = { location = "rightbelow", split_ratio = .3, },
          vertical = { location = "rightbelow", split_ratio = .5 },
        },
      }
    },
    config = function(_, opts)
      require "base46.term"
      require("nvterm").setup(opts)
    end,
  },
  {
    'nvim-focus/focus.nvim',
    version = '*',
    event = "BufAdd",
    config = function()
      require("focus").setup()
    end,
  },
  -- override plugin configs
  {
    "williamboman/mason.nvim",
    opts = overrides.mason,
  },

  {
    "nvim-treesitter/nvim-treesitter",
    opts = {
      prefer_git = false,
    },
  },

  {
    "nvim-tree/nvim-tree.lua",
    opts = overrides.nvimtree,
  },

  -- Install a plugin
  {
    "max397574/better-escape.nvim",
    enabled = false,
    event = "InsertEnter",
    config = function()
      require("better_escape").setup()
    end,
  },
  {
    "kawre/leetcode.nvim",
    dependencies = {
        "nvim-telescope/telescope.nvim",
        "nvim-lua/plenary.nvim", -- required by telescope
        "MunifTanjim/nui.nvim",

        -- optional
        "simrat39/rust-tools.nvim",
        "nvim-treesitter/nvim-treesitter",
        "rcarriga/nvim-notify",
        "nvim-tree/nvim-web-devicons",
    },
    lazy = "leetcode.nvim" ~= vim.fn.argv()[1],
    opts = function()
      return require "custom.configs.leetcode"
    end
  },
  {
    "piersolenski/wtf.nvim",
    dependencies = {
      "MunifTanjim/nui.nvim",
    },
    keys = {
      {
        mode = { "n" },
        "gW",
        function()
          require("wtf").search()
        end,
        desc = "Search diagnostic with Google",
      },
	  },
  },
  {
    "rcarriga/nvim-notify",
    config = function ()
      require("notify").setup {
        stages = 'fade',
        background_colour = 'FloatShadow',
        timeout = 3000,
        render = "compact"
      }
      vim.notify = require('notify')
    end
  },
  {
    "nvim-telescope/telescope.nvim",
    dependencies = {
      "rcarriga/nvim-notify",
    }
  },
}

return plugins
