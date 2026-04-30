local icons = require("plugins.lib.icons")
return {
  "lewis6991/gitsigns.nvim",
  lazy = true,
  enabled = vim.fn.executable("git") == 1,
  ft = "gitcommit",
  event = "BufRead",
  opts = {
    -- signs = {
    --   add = { text = "▎" },
    --   change = { text = "▎" },
    --   delete = { text = "" },
    --   topdelete = { text = "" },
    --   changedelete = { text = "▎" },
    --   untracked = { text = "▎" },
    -- },
    signs = {
      add = { text = icons.git.LineAdded },
      change = { text = icons.git.LineModified },
      delete = { text = icons.git.LineRemoved },
      topdelete = { text = icons.git.FileDeleted },
      changedelete = { text = "▎" },
      untracked = { text = icons.git.FileUntracked },
    },

    signcolumn = true,
    numhl = true,
    linehl = false,
    word_diff = false,
    watch_gitdir = {
      interval = 1000,
      follow_files = true,
    },
    attach_to_untracked = true,
    current_line_blame = false, -- Toggle with `:Gitsigns toggle_current_line_blame`
    current_line_blame_opts = {
      virt_text = true,
      virt_text_pos = "eol", -- 'eol' | 'overlay' | 'right_align'
      delay = 1000,
      ignore_whitespace = false,
    },
    current_line_blame_formatter = "<author>, <author_time:%Y-%m-%d> - <summary>",
    sign_priority = 6,
    status_formatter = nil, -- Use default
    update_debounce = 200,
    max_file_length = 40000,
    preview_config = {
      -- Options passed to nvim_open_win
      border = "rounded",
      style = "minimal",
      relative = "cursor",
      row = 0,
      col = 1,
    },
  }
}
