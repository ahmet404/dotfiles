local icons = require("plugins.ui.icons")
local color = {
  bg0 = "#282828",
  fg0 = "#FBF1C7",
  red = "#CC241D",
  green = "#98971A",
  yellow = "#D79921",
  blue = "#458588",
  purple = "#B16286",
  gray = "#A89984",
  orange = "#D65D0E",
}
local theme = {
  normal = {
    a = { bg = color.yellow, fg = color.bg0, gui = "bold" },
    b = { bg = color.gray, fg = color.bg0 },
    c = { fg = color.fg0 },
    x = { fg = color.fg0 },
    y = { bg = color.gray, fg = color.bg0 },
    z = { bg = color.yellow, fg = color.bg0 },
  },
}

local hide_in_width = function()
  return vim.fn.winwidth(0) > 80
end

local conditions = {
  buffer_not_empty = function()
    return vim.fn.empty(vim.fn.expand("%:t")) ~= 1
  end,
  hide_in_width = function()
    return vim.fn.winwidth(0) > 80
  end,
  check_git_workspace = function()
    local filepath = vim.fn.expand("%:p:h")
    local gitdir = vim.fn.finddir(".git", filepath .. ";")
    return gitdir and #gitdir > 0 and #gitdir < #filepath
  end,
}

-- section mode
local mode = {
  "mode",
  fmt = function(str)
    return " " .. str
  end,
}

-- section name
local name = {
  "filename",
  cond = conditions.buffer_not_empty,
  file_status = true,
  newfile_status = false,
  path = 0,
  shorting_target = 40,
  symbols = {
    modified = icons.ui.Modified,
    readonly = icons.ui.Locked,
    newfile = icons.ui.NewFile,
    unnamed = "[No Name]",
  },
  fmt = function(str)
    local filename = vim.api.nvim_buf_get_name(0)
    local extension = vim.fn.fnamemodify(filename, ":e")
    local icon = require("nvim-web-devicons").get_icon_color(filename, extension)
    if icon == nil then
      return str
    else
      return string.format("%s %s", icon, str)
    end
  end,
}

-- section type
local type = {
  "filetype",
  colored = true,
  icon_only = false,
  icon = nil,
  icons_enabled = true,
  separator = "|",
  fmt = function()
    if string.len(vim.bo.filetype) <= 3 then
      return vim.bo.filetype:upper()
    else
      return vim.bo.filetype
    end
  end,
}

-- section branch
local branch = {
  "branch",
  icons_enabled = true,
  cond = conditions.hide_in_width,
  icon = icons.git.Branch,
}

-- section diff
local diff = {
  "diff",
  colored = true,
  diff_color = {
    added = { fg = "#98971A" },
    modified = { fg = "#d79921" },
    removed = { fg = "#cc241d" },
  },
  symbols = {
    added = icons.git.LineAdded .. " ",
    modified = icons.git.LineModified .. " ",
    removed = icons.git.LineRemoved .. " ",
  },
  cond = hide_in_width,
}

-- section diagnostics
local diagnostics = {
  "diagnostics",
  colored = true,
  update_in_insert = true,
  always_visible = false,
  sources = { "nvim_diagnostic" },
  sections = { "error", "warn", "info", "hint" },
  symbols = {
    error = icons.diagnostics.Error .. " ",
    warn = icons.diagnostics.Warning .. " ",
    info = icons.diagnostics.Information .. " ",
    hint = icons.diagnostics.Hint .. " ",
  },
  diagnostics_color = {
    error = { fg = "#cc241d" },
    warn = { fg = "#d79921" },
    info = { fg = "#458588" },
    hint = { fg = "#98971A" },
  },
}

-- section encoding
local encode = {
  "encoding",
  cond = conditions.hide_in_width,
  fmt = function()
    local encode = vim.bo.fenc ~= "" and vim.bo.fenc or vim.o.enc
    return string.format(" %s", encode:upper())
  end,
}
-- section fileformat
local fileformat = {
  "fileformat",
  cond = conditions.hide_in_width,
  fmt = function()
    local icon = ""
    local os = vim.bo.fileformat:upper()
    if os == "UNIX" then
      icon = " "
    elseif os == "MAC" then
      icon = " "
    else
      icon = " "
    end
    return string.format("%s%s", icon, os)
  end,
}

-- section location
local location = {
  "location",
  fmt = function(str)
    return string.format("%s %s", icons.ui.Linenr, str)
  end,
}

-- section progress
local progress = {
  "progress",
  cond = conditions.hide_in_width,
  fmt = function(str)
    local icon_str = " "
    return string.format("%s %s", icon_str, str)
  end,
}

-- start for lsp
local list_registered_providers_names = function(filetype)
  local s = require("null-ls.sources")
  local available_sources = s.get_available(filetype)
  local registered = {}
  for _, source in ipairs(available_sources) do
    for method in pairs(source.methods) do
      registered[method] = registered[method] or {}
      table.insert(registered[method], source.name)
    end
  end
  return registered
end

local null_ls = require("null-ls")
-- for formatter
local list_registered = function(filetype)
  local method = null_ls.methods.FORMATTING
  local registered_providers = list_registered_providers_names(filetype)
  return registered_providers[method] or {}
end

--- for linter
local alternative_methods = {
  null_ls.methods.DIAGNOSTICS,
  null_ls.methods.DIAGNOSTICS_ON_OPEN,
  null_ls.methods.DIAGNOSTICS_ON_SAVE,
}

local linter_list_registered = function(filetype)
  local registered_providers = list_registered_providers_names(filetype)
  local providers_for_methods = vim.tbl_flatten(vim.tbl_map(function(m)
    return registered_providers[m] or {}
  end, alternative_methods))

  return providers_for_methods
end
-- end for lsp
local lsp_info = {
  function()
    --local msg = "No Active Lsp"
    local msg = "LS Inactive"
    -- local buf_ft = vim.api.nvim_buf_get_option(0, "filetype")
    local buf_ft = vim.bo.filetype
    -- local clients = vim.lsp.get_active_clients()
    -- start register
    local buf_clients = vim.lsp.buf_get_clients()
    local buf_client_names = {}
    if next(buf_clients) == nil then
      -- TODO: clean up this if statement
      if type(msg) == "boolean" or #msg == 0 then
        return "LS Inactive"
      end
      return msg
    end
    -- add client
    for _, client in pairs(buf_clients) do
      if client.name ~= "null-ls" and client.name ~= "copilot" then
        table.insert(buf_client_names, client.name)
      end
    end
    -- add formatter
    local supported_formatters = list_registered(buf_ft)
    vim.list_extend(buf_client_names, supported_formatters)
    -- add linter
    local supported_linters = linter_list_registered(buf_ft)
    vim.list_extend(buf_client_names, supported_linters)
    -- decomple
    local unique_client_names = vim.fn.uniq(buf_client_names)
    msg = table.concat(unique_client_names, "|")
    return msg
  end,

  icon = " ",
}
require("lualine").setup({
  options = {
    icons_enabled = true,
    theme = theme,
    -- component_separators = { left = "", right = "" },
    -- section_separators = { left = "", right = "" },
    component_separators = {},
    section_separators = {},
    disabled_filetypes = {
      "TelescopePrompt",
      "packer",
      "alpha",
      "dashboard",
      "NvimTree",
      "Outline",
      "DressingInput",
      "toggleterm",
      "lazy",
      "mason",
      "neo-tree",
      "help",
      statusline = {},
      winbar = {},
    },
    ignore_focus = {},
    always_divide_middle = true,
    globalstatus = false,
    refresh = {
      statusline = 1000,
      tabline = 1000,
      winbar = 1000,
    },
  },
  sections = {
    lualine_a = { mode },
    lualine_b = { branch },
    lualine_c = { name, diff },
    lualine_x = { diagnostics, lsp_info, type },
    lualine_y = { fileformat, encode },
    lualine_z = { progress, location },
  },
  inactive_sections = {
    lualine_a = { mode },
    lualine_b = { branch },
    lualine_c = { name },
    lualine_x = { type },
    lualine_y = { fileformat },
    lualine_z = { location },
  },
  tabline = {},
  winbar = {},
  inactive_winbar = {},
  extensions = {},
})
