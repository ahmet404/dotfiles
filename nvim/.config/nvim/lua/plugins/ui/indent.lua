require("ibl").setup({
  indent = {
    char = "│",
    -- highlight = highlight,
  },
  scope = { enabled = false },
  exclude = {
    filetypes = {
      "Preview",
      "Trouble",
      "__doc__",
      "aerial",
      "checkhealth",
      "help",
      "log",
      "lspinfo",
      "man",
      "markdown",
      "neo-tree",
      "neo-tree-popup",
      "qf",
      "terminal",
      "translator",
      "mason",
      "Outline",
    },
    buftypes = {
      "terminal",
      "man",
      "trouble",
    },
  },
})
