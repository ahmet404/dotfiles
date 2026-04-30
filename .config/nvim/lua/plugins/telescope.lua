return {
	"nvim-telescope/telescope.nvim",
	event = "VeryLazy",
	tag = "v0.1.9",
	dependencies = {
		"ahmet404/plenary.nvim",
		"nvim-telescope/telescope-ui-select.nvim",
		"natecraddock/telescope-zf-native.nvim",
	},
  opts = {
    defaults = {
      results_title = false,
      entry_prefix = "   ",
      multi_icon = " ❱ ",
      prompt_prefix = "❱❱ ",
      selection_caret = " ❱ ",
      initial_mode = "insert",
      file_ignore_patterns = {
        "^node_modules/",
        "%.class",
      },
      path_display = { "absolute" },
      use_less = false,
      -- custom theme
      sorting_strategy = "descending",
      layout_strategy = "bottom_pane",
      layout_config = {
        height = 0.4,
        prompt_position = "bottom",
      },
      borderchars = {
        prompt = { "━", " ", " ", " ", "━", "━", " ", " " },
        results = { "━", " ", " ", " ", "━", "━", " ", " " },
        preview = { "━", " ", " ", "┃", "┳", " ", " ", "┃" },
      },
    },
    pickers = {
      diagnostics = {
        bufnr = 0,
        initial_mode = "normal",
        previewer = false,
        line_width = 0.7,
        no_unlisted = true,
        path_display = {
          "filename_first",
        },
      },
      oldfiles = {
        previewer = true,
        file_ignore_patterns = {
          "/usr/share/nvim/runtime/*",
          vim.fn.stdpath("data"),
          vim.fn.stdpath("cache"),
          vim.fn.stdpath("log"),
        },
      },
      find_files = {
        previewer = true,
      },
      builtin = {
        previewer = false,
      },
      current_buffer_fuzzy_find = {
        previewer = true,
      },
      autocommands = {
        previewer = false,
      },
      lsp_document_symbols = {
        previewer = false,
        symbol_width = 0.7,
      },
      lsp_workspace_symbols = {
        previewer = false,
        symbol_width = 0.7,
      },
      buffers = {
        initial_mode = "insert",
        select_current = true,
        previewer = true,
        sort_lastused = true,
      },
    },
    extensions = {
      ["zf-native"] = {
        generic = {
          match_filename = true,
        },
      },
    },

  },
	config = function(_, opts)
    local telescope = require("telescope")
    telescope.setup(opts)
    telescope.load_extension("zf-native")
    telescope.load_extension("ui-select")
	end
}
