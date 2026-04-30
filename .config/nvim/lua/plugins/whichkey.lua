return {
  "folke/which-key.nvim",
  -- lazy = true,
  keys = { "<leader>", '"', "'", "c", "v" },
  event = "VeryLazy",
  opts = function()
    return {
      plugins = {
        marks = true,
        registers = true,
        spelling = {
          enabled = true,
          suggestions = 20,
        },
        presets = {
          operators = false,
          motions = false,
          text_objects = false,
          windows = false,
          nav = false,
          z = false,
          g = false,
        },
      },
      icons = {
        mappings = false,
      },
      win = {
        row = -1,
        border = "rounded", -- none, single, double, shadow
        padding = { 1, 2 }, -- extra window padding [top/bottom, right/left]
        title = true,
        title_pos = "center",
        zindex = 1000,
        bo = {},
        wo = {},
      },
      layout = {
        height = { min = 4, max = 25 }, -- min and max height of the columns
        width = { min = 20, max = 50 }, -- min and max width of the columns
        spacing = 3, -- spacing between columns
        align = "left", -- align columns left, center or right
      },
      show_help = true, -- show help message on the command line when the popup is visible
      show_keys = true, -- show the currently pressed key and its label as a message in the command line
      -- Disabled by default for Telescope
      disable = {
        buftypes = {},
        filetypes = { "TelescopePrompt" },
      },
      ---@type false | "classic" | "modern" | "helix"
      preset = "modern",
      mappings = {
        -- Lazy
        { "<leader>l", "", desc = " 󱑠 Lazy", mode = "n" },
        { "<leader>li", "<cmd>Lazy install<cr>", desc = "Install", mode = "n" },
        { "<leader>ls", "<cmd>Lazy sync<cr>", desc = "Sync", mode = "n" },
        { "<leader>lS", "<cmd>Lazy clear<cr>", desc = "Status", mode = "n" },
        { "<leader>lc", "<cmd>Lazy clean<cr>", desc = "Clean", mode = "n" },
        { "<leader>lu", "<cmd>Lazy update<cr>", desc = "Update", mode = "n" },
        { "<leader>lp", "<cmd>Lazy profile<cr>", desc = "Profile", mode = "n" },
        { "<leader>ll", "<cmd>Lazy log<cr>", desc = "Log", mode = "n" },
        { "<leader>ld", "<cmd>Lazy debug<cr>", desc = "Debug", mode = "n" },
      },
    }
  end,
  config = function(_, opts)
    local wk = require("which-key")
    wk.setup(opts)
    wk.add(opts.mappings)
  end,
}
