require("nvim-treesitter.configs").setup({
  ensure_installed = {
    "bash",
    "c",
    "html",
    "javascript",
    "json",
    "lua",
    "markdown",
    "python",
    "vim",
  },
  highlight = {
    enable = true,
    additional_vim_regex_highlighting = false,
  },
  rainbow = {
    enable = true,
    disable = { "html" },
    extended_mode = false,
    max_file_lines = nil,
    colors = {
      -- "#68a0b0",
      -- "#946EaD",
      -- "#c7aA6D",
      -- "Gold",
      -- "Orchid",
      -- "DodgerBlue",
      -- "LawnGreen",
      -- "Salmon",
      -- "Cornsilk",
      "#d79921",
      "#cc241d",
      "#98971a",
      "#b16286",
    },
  },
  autotag = {
    enable = true,
    disable = { "css", "sass", "less", "scss" },
  },
  incremental_selection = {
    enable = true,
  },
  indent = {
    enable = true,
    disable = { "python", "css" },
  },
  autopairs = {
    enable = true,
  },
})
