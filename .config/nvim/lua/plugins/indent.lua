return {
  "shellRaining/hlchunk.nvim",
  event = "BufRead",
  opts = {
    chunk = {
      enable = true,
      style = {
        { fg = "#d79921" },
        { fg = "#fb4934" },
      }
    },
    indent = {
      enable = true
    },
    exclude_filetypes = {
      aerial = true,
      dashboard = true,
      alpha = true,
    }
  }
}

