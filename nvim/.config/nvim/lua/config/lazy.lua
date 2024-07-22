-- Bootstrap lazy.nvim
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.uv.fs_stat(lazypath) then
  local lazyrepo = "https://github.com/folke/lazy.nvim.git"
  local out = vim.fn.system({ "git", "clone", "--filter=blob:none", "--branch=stable", lazyrepo, lazypath })
  if vim.v.shell_error ~= 0 then
    vim.api.nvim_echo({
      { "Failed to clone lazy.nvim:\n", "ErrorMsg" },
      { out, "WarningMsg" },
      { "\nPress any key to exit..." },
    }, true, {})
    vim.fn.getchar()
    os.exit(1)
  end
end
vim.opt.rtp:prepend(lazypath)

local plugins = {
  -- dependencies
  { "nvim-tree/nvim-web-devicons" },
  { "nvim-lua/plenary.nvim" },

  -- colorscheme
  {
    "ellisonleao/gruvbox.nvim",
    lazy = false,
    priority = 1000,
    config = function()
      require("plugins.ui.colorscheme")
    end,
  },

  -- statusline
  {
    "nvim-lualine/lualine.nvim",
    event = "VimEnter",
    config = function()
      require("plugins.ui.lualine")
    end,
  },

  -- filemanager
  {
    "nvim-neo-tree/neo-tree.nvim",
    event = "VeryLazy",
    branch = "v2.x",
    dependencies = {
      { "MunifTanjim/nui.nvim", event = "VeryLazy" },
    },
    config = function()
      require("plugins.ui.filemanager")
    end,
  },

  -- bufferline
  {
    "akinsho/bufferline.nvim",
    event = "BufRead",
    dependencies = { "famiu/bufdelete.nvim" },
    config = function()
      require("plugins.ui.bufferline")
    end,
  },

  -- indentasi
  {
    "lukas-reineke/indent-blankline.nvim",
    main = "ibl",
    opts = {},
    event = "BufRead",
    config = function()
      require("plugins.ui.indent")
    end,
  },

  -- highlighting code
  {
    "nvim-treesitter/nvim-treesitter",
    build = ":TSUpdate",
    event = "BufRead",
    dependencies = {
      "windwp/nvim-ts-autotag",
      "p00f/nvim-ts-rainbow",
    },
    config = function()
      require("plugins.ui.treesitter")
    end,
  },

  -- breadcrumbs
  {
    "utilyre/barbecue.nvim",
    event = "VimEnter",
    name = "barbecue",
    version = "*",
    dependencies = {
      "SmiteshP/nvim-navic",
    },
    config = function()
      require("plugins.ui.breadcrumbs")
    end,
  },

  -- commentarry
  {
    "numToStr/Comment.nvim",
    event = "BufRead",
    config = function()
      require("plugins.editor.comment")
    end,
  },

  -- colorizer
  {
    "NvChad/nvim-colorizer.lua",
    event = "BufRead",
    config = function()
      require("plugins.editor.colorizer")
    end,
  },

  -- telescope
  {
    "nvim-telescope/telescope.nvim",
    tag = "0.1.5",
    -- tag = "0.1.1",
    event = "VeryLazy",
    dependencies = {
      "nvim-lua/plenary.nvim",
      "nvim-telescope/telescope-ui-select.nvim",
      "nvim-telescope/telescope-fzy-native.nvim",
    },
    config = function()
      require("plugins.editor.telescope")
    end,
  },

  -- git
  {
    "lewis6991/gitsigns.nvim",
    event = "BufRead",
    config = function()
      require("plugins.editor.gitsigns")
    end,
  },

  -- terminal
  {
    "akinsho/toggleterm.nvim",
    event = "VeryLazy",
    version = "*",
    config = function()
      require("plugins.editor.terminal")
    end,
  },

  -- completion
  {
    "hrsh7th/nvim-cmp",
    event = "InsertEnter",
    dependencies = {
      "hrsh7th/cmp-nvim-lsp",
      "hrsh7th/cmp-buffer",
      "hrsh7th/cmp-path",
      "saadparwaiz1/cmp_luasnip",
      "L3MON4D3/LuaSnip",
      "rafamadriz/friendly-snippets",
      "honza/vim-snippets",
      {
        "windwp/nvim-autopairs",
        config = function()
          require("plugins.completion.autopairs")
        end,
      },
    },
    config = function()
      require("plugins.completion.nvim-cmp")
    end,
  },

  -- lsp
  {
    "williamboman/mason.nvim",
    lazy = false,
    cmd = { "Mason", "MasonInstall", "MasonUninstall" },
    config = function()
      require("plugins.lsp.mason")
    end,
  },
  {
    "neovim/nvim-lspconfig",
    lazy = false,
    dependencies = {
      "jose-elias-alvarez/null-ls.nvim",
      {
        "folke/trouble.nvim",
        config = function()
          require("plugins.lsp.trouble")
        end,
      },
    },
    config = function()
      require("plugins.lsp")
    end,
  },

  -- code runner
  {
    "CRAG666/code_runner.nvim",
    lazy = false,
    event = "BufRead",
    cmd = { "RunCode", "RunFile", "RunProject", "RunClose" },
    config = function()
      require("plugins.editor.coderunner")
    end,
  },

  -- improve startup time
  {
    "lewis6991/impatient.nvim",
    event = "BufWinEnter",
    config = function()
      require("impatient").enable_profile()
    end,
  },

  -- Markdown Preview
  {
    "iamcco/markdown-preview.nvim",
    cmd = { "MarkdownPreviewToggle", "MarkdownPreview", "MarkdownPreviewStop" },
    ft = { "markdown" },
    build = function()
      vim.fn["mkdp#util#install"]()
    end,
  },

  -- Dashboard
  {
    "goolord/alpha-nvim",
    event = "VimEnter",
    config = function()
      require("plugins.ui.dashboard")
    end,
  },
  -- key mapping
  {
    "folke/which-key.nvim",
    keys = { "<leader>", '"', "'", "c", "v" },
    event = "VeryLazy",
    config = function()
      -- require("plugins.editor.whichkey")
    end,
  },
}

require("lazy").setup(plugins, {
  defaults = {
    lazy = true,
    version = "*",
  },
  ui = {
    border = "single",
    browser = "nil",
    throttle = 40,
  },
  install = {
    colorscheme = { "gruvbox" },
  },
  performance = {
    rtp = {
      disabled_plugins = {
        "gzip",
        "tar",
        "tarPlugin",
        "zip",
        "zipPlugin",
        "getscript",
        "getscriptPlugin",
        "vimball",
        "vimballPlugin",
        "tohtml",
        "netrwPlugin",
        "tutor",
      },
    },
  },
})
