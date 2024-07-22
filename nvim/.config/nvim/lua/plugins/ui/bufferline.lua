local icons = require("plugins.ui.icons")

require("bufferline").setup({
  options = {
    mode = "buffers",
    color_icons = true,
    numbers = "none", -- | "ordinal" | "buffer_id" | "both" | function({ ordinal, id, lower, raise }): string,
    --close_command = "Bdelete! %d", -- can be a string | function, see "Mouse actions"
    close_command = function(bufnum)
      require("bufdelete").bufdelete(bufnum, true)
    end,
    --right_mouse_command = "Bdelete! %d", -- can be a string | function, see "Mouse actions"
    right_mouse_command = function(bufnum)
      require("bufdelete").bufdelete(bufnum, true)
    end,
    left_mouse_command = "buffer %d", -- can be a string | function, see "Mouse actions"
    middle_mouse_command = nil, -- can be a string | function, see "Mouse actions"
    indicator_icon = nil,
    indicator = { style = "icon", icon = "▎" },
    buffer_close_icon = icons.ui.Close,
    modified_icon = icons.ui.Modified,
    close_icon = icons.ui.BoldClose,
    left_trunc_marker = icons.ui.TriangleShortArrowLeft,
    right_trunc_marker = icons.ui.TriangleShortArrowRight,

    max_name_length = 30,
    max_prefix_length = 30, -- prefix used when a buffer is de-duplicated
    tab_size = 21,
    diagnostics = false, -- | "nvim_lsp" | "coc",
    offsets = {
      {
        filetype = "neo-tree",
        text = "File Explorer",
        highlight = "Directory",
        text_align = "left",
        padding = 1,
      },
    },
    show_buffer_icons = true,
    show_buffer_close_icons = true,
    show_close_icon = true,
    show_tab_indicators = true,
    persist_buffer_sort = true, -- whether or not custom sorted buffers should persist
    separator_style = "thin", -- | "thick" | "thin" | { "any", "any" },
    enforce_regular_tabs = true,
    always_show_bufferline = true,
    -- sort_by = "id" | "extension" | "relative_directory" | "directory" | "tabs" | function(buffer_a, buffer_b)
    --   -- add custom logic
    --   return buffer_a.modified > buffer_b.modified
    -- end
  },

  highlights = {
    fill = {
      fg = "#d5c4a1",
      bg = "#282828",
    },
    background = {
      fg = "#d5c4a1",
      bg = "#282828",
    },
    close_button = {
      fg = "#d5c4a1",
      bg = "#282828",
    },
    close_button_visible = {
      fg = "#d5c4a1",
      bg = "#282828",
    },
    close_button_selected = {
      fg = "#fbf1c7",
      bg = "#282828",
    },
    buffer_visible = {
      fg = "#d5c4a1",
      bg = "#282828",
    },
    buffer_selected = {
      fg = "#fbf1c7",
      bg = "#282828",
      bold = true,
      italic = false,
    },
    separator_selected = {},
    separator_visible = {},
    separator = {
      fg = "#282828",
      bg = "#282828",
    },
    indicator_selected = {
      fg = "#282828",
      bg = "#282828",
    },
    modified = {
      fg = "#d79921",
      bg = "#282828",
    },
    modified_visible = {
      fg = "#d79921",
      bg = "#282828",
    },
    modified_selected = {
      fg = "#d79921",
      bg = "#282828",
    },
    --numbers = {
    --    fg = "<colour-value-here>",
    --    bg = "<colour-value-here>",
    --},
    --numbers_visible = {
    --    fg = "<colour-value-here>",
    --    bg = "<colour-value-here>",
    --},
    --numbers_selected = {
    --    fg = "<colour-value-here>",
    --    bg = "<colour-value-here>",
    --    bold = true,
    --    italic = true,
    --},
    --diagnostic = {
    --    fg = "<colour-value-here>",
    --    bg = "<colour-value-here>",
    --},
    --diagnostic_visible = {
    --    fg = "<colour-value-here>",
    --    bg = "<colour-value-here>",
    --},
    --diagnostic_selected = {
    --    fg = "<colour-value-here>",
    --    bg = "<colour-value-here>",
    --    bold = true,
    --    italic = true,
    --},
    --hint = {
    --    fg = "<colour-value-here>",
    --    sp = "<colour-value-here>",
    --    bg = "<colour-value-here>"
    --},
    --hint_visible = {
    --    fg = "<colour-value-here>",
    --    bg = "<colour-value-here>"
    --},
    --hint_selected = {
    --    fg = "<colour-value-here>",
    --    bg = "<colour-value-here>",
    --    sp = "<colour-value-here>",
    --    bold = true,
    --    italic = true,
    --},
    --hint_diagnostic = {
    --    fg = "<colour-value-here>",
    --    sp = "<colour-value-here>",
    --    bg = "<colour-value-here>"
    --},
    --hint_diagnostic_visible = {
    --    fg = "<colour-value-here>",
    --    bg = "<colour-value-here>"
    --},
    --hint_diagnostic_selected = {
    --    fg = "<colour-value-here>",
    --    bg = "<colour-value-here>",
    --    sp = "<colour-value-here>",
    --    bold = true,
    --    italic = true,
    --},
    --info = {
    --    fg = "<colour-value-here>",
    --    sp = "<colour-value-here>",
    --    bg = "<colour-value-here>"
    --},
    --info_visible = {
    --    fg = "<colour-value-here>",
    --    bg = "<colour-value-here>"
    --},
    --info_selected = {
    --    fg = "<colour-value-here>",
    --    bg = "<colour-value-here>",
    --    sp = "<colour-value-here>",
    --    bold = true,
    --    italic = true,
    --},
    --info_diagnostic = {
    --    fg = "<colour-value-here>",
    --    sp = "<colour-value-here>",
    --    bg = "<colour-value-here>"
    --},
    --info_diagnostic_visible = {
    --    fg = "<colour-value-here>",
    --    bg = "<colour-value-here>"
    --},
    --info_diagnostic_selected = {
    --    fg = "<colour-value-here>",
    --    bg = "<colour-value-here>",
    --    sp = "<colour-value-here>",
    --    bold = true,
    --    italic = true,
    --},
    --warning = {
    --    fg = "<colour-value-here>",
    --    sp = "<colour-value-here>",
    --    bg = "<colour-value-here>"
    --},
    --warning_visible = {
    --    fg = "<colour-value-here>",
    --    bg = "<colour-value-here>"
    --},
    --warning_selected = {
    --    fg = "<colour-value-here>",
    --    bg = "<colour-value-here>",
    --    sp = "<colour-value-here>",
    --    bold = true,
    --    italic = true,
    --},
    --warning_diagnostic = {
    --    fg = "<colour-value-here>",
    --    sp = "<colour-value-here>",
    --    bg = "<colour-value-here>"
    --},
    --warning_diagnostic_visible = {
    --    fg = "<colour-value-here>",
    --    bg = "<colour-value-here>"
    --},
    --warning_diagnostic_selected = {
    --    fg = "<colour-value-here>",
    --    bg = "<colour-value-here>",
    --    sp = warning_diagnostic_fg,
    --    bold = true,
    --    italic = true,
    --},
    --error = {
    --    fg = "<colour-value-here>",
    --    bg = "<colour-value-here>",
    --    sp = "<colour-value-here>"
    --},
    --error_visible = {
    --    fg = "<colour-value-here>",
    --    bg = "<colour-value-here>"
    --},
    --error_selected = {
    --    fg = "<colour-value-here>",
    --    bg = "<colour-value-here>",
    --    sp = "<colour-value-here>",
    --    bold = true,
    --    italic = true,
    --},
    --error_diagnostic = {
    --    fg = "<colour-value-here>",
    --    bg = "<colour-value-here>",
    --    sp = "<colour-value-here>",
    --},
    --error_diagnostic_visible = {
    --    fg = "<colour-value-here>",
    --    bg = "<colour-value-here>"
    --},
    --error_diagnostic_selected = {
    --    fg = "<colour-value-here>",
    --    bg = "<colour-value-here>",
    --    sp = "<colour-value-here>",
    --    bold = true,
    --    italic = true,
    --},
    --duplicate_selected = {
    --    fg = "<colour-value-here>",
    --    bg = "<colour-value-here>",
    --    italic = true,
    --},
    --duplicate_visible = {
    --    fg = "<colour-value-here>",
    --    bg = "<colour-value-here>",
    --    italic = true
    --},
    --duplicate = {
    --    fg = "<colour-value-here>",
    --    bg = "<colour-value-here>",
    --    italic = true
    --},
    --pick_selected = {
    --    fg = "<colour-value-here>",
    --    bg = "<colour-value-here>",
    --    bold = true,
    --    italic = true,
    --},
    --pick_visible = {
    --    fg = "<colour-value-here>",
    --    bg = "<colour-value-here>",
    --    bold = true,
    --    italic = true,
    --},
    --pick = {
    --    fg = "<colour-value-here>",
    --    bg = "<colour-value-here>",
    --    bold = true,
    --    italic = true,
    --},
    --offset_separator = {
    --    fg = win_separator_fg,
    --    bg = separator_background_color,
    --},
  },
})
