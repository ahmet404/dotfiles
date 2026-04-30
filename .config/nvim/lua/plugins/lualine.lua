local icons = require("plugins.lib.icons")
local color = {
	bg0 = "#282828",
	bg1 = "#3c3836",
	bg2 = "#504945",
	bg3 = "#665c54",
	fg0 = "#fbf1c7",
	fg1 = "#ebdbb2",
	fg3 = "#bdae93",
	red = "#fb4934",
	green = "#b8bb26",
	yellow = "#D79921",
	blue = "#83a598",
	aqua = "#8ec07c",
	gray = "#A89984",
}
local theme = {
	normal = {
		a = { bg = color.yellow, fg = color.bg0, gui = "bold" },
		b = { bg = color.bg1, fg = color.fg1 },
		c = { bg = color.gray, fg = color.bg0 },
		x = { bg = color.gray, fg = color.bg0 },
		y = { bg = color.bg1, fg = color.fg1 },
		z = { bg = color.yellow, fg = color.bg0, gui = "bold" },
	},
	insert = {
		a = { bg = color.blue, fg = color.bg0, gui = "bold" },
		b = { bg = color.bg1, fg = color.fg1 },
		c = { bg = color.fg3, fg = color.bg1 },
		x = { bg = color.fg3, fg = color.bg1 },
		y = { bg = color.bg1, fg = color.fg1 },
		z = { bg = color.blue, fg = color.bg0, gui = "bold" },
	},
	visual = {
		a = { bg = color.green, fg = color.bg0, gui = "bold" },
		b = { bg = color.bg1, fg = color.fg1 },
		c = { bg = color.fg3, fg = color.bg1 },
		x = { bg = color.fg3, fg = color.bg1 },
		y = { bg = color.bg1, fg = color.fg1 },
		z = { bg = color.green, fg = color.bg0, gui = "bold" },
	},
	replace = {
		a = { bg = color.aqua, fg = color.bg0, gui = "bold" },
		b = { bg = color.bg1, fg = color.fg1 },
		c = { bg = color.fg3, fg = color.bg1 },
		x = { bg = color.fg3, fg = color.bg1 },
		y = { bg = color.bg1, fg = color.fg1 },
		z = { bg = color.aqua, fg = color.bg0, gui = "bold" },
	},
	command = {
		a = { bg = color.gray, fg = color.bg0, gui = "bold" },
		b = { bg = color.bg2, fg = color.fg1 },
		c = { bg = color.bg1, fg = color.fg1 },
		x = { bg = color.bg1, fg = color.fg1 },
		y = { bg = color.bg2, fg = color.fg1 },
		z = { bg = color.gray, fg = color.bg0, gui = "bold" },
	},
}

local conditions = {
	buffer_not_empty = function()
		return vim.fn.empty(vim.fn.expand("%:t")) ~= 1
	end,
	hide_in_width = function()
		return vim.fn.winwidth(0) > 120
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
		-- return " " .. str
		return "  " .. str
	end,
}

-- section name
local name = {
	"filename",
	file_status = true,
	newfile_status = true,
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
	-- separator = "|",
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
		added = { bg = color.bg3, fg = color.green, gui = "bold" },
		modified = { bg = color.bg3, fg = color.yellow, gui = "bold" },
		removed = { bg = color.bg3, fg = color.red, gui = "bold" },
	},
	symbols = {
		added = icons.git.LineAdded .. " ",
		modified = icons.git.LineModified .. " ",
		removed = icons.git.LineRemoved .. " ",
	},
	cond = conditions.hide_in_width,
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
local icon = ""
local fileformat = {
	"fileformat",
	cond = conditions.hide_in_width,
	fmt = function()
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

-- section spaces
local spaces = function()
	if vim.fn.winwidth(0) > 120 then
		return icons.ui.Tab .. " " .. vim.bo.shiftwidth
	else
		return ""
	end
end

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
		error = { bg = color.bg1, fg = "#cc241d" },
		warn = { bg = color.bg1, fg = "#d79921" },
		info = { bg = color.bg1, fg = "#458588" },
		hint = { bg = color.bg1, fg = "#98971A" },
	},
}

-- section lsp
local function get_lsp()
	local clients = vim.lsp.get_clients({ bufnr = 0 })
	if #clients == 0 then
		return ""
	end

	local names = {}
	for _, c in ipairs(clients) do
		table.insert(names, c.name)
	end
	return "  " .. table.concat(names, ", ")
end

-- section formatter
local function get_formatter()
	local ok, conform = pcall(require, "conform")
	if not ok then
		return ""
	end

	local formatters = conform.list_formatters(0)
	if not formatters or #formatters == 0 then
		return ""
	end

	local names = {}
	for _, f in ipairs(formatters) do
		table.insert(names, f.name)
	end

	return "  " .. table.concat(names, ", ")
end

-- section linter
local function get_linter()
	local lint = require("lint")
	local ft = vim.bo.filetype
	local linters = lint.linters_by_ft[ft]

	if not linters or #linters == 0 then
		return ""
	end

	return " " .. table.concat(linters, ", ")
end

return {
	"nvim-lualine/lualine.nvim",
	event = "VeryLazy",
	dependencies = { "nvim-tree/nvim-web-devicons" },
	opts = {
		options = {
			icons_enabled = true,
			theme = theme,

			-- component_separators = { left = "", right = "" },
			component_separators = { left = "", right = "" },
			section_separators = { left = " ", right = " " },

			disabled_filetypes = {
				"packer",
				"alpha",
				"dashboard",
				"Outline",
				"DressingInput",
				"lazy",
				"mason",
				"help",
				statusline = {},
				winbar = {},
			},
			ignore_focus = {},
			always_divide_middle = true,
			globalstatus = true,
			refresh = {
				statusline = 1000,
				tabline = 1000,
				winbar = 1000,
			},
		},
		sections = {
			lualine_a = { mode },
			lualine_b = { branch },
			lualine_c = { diff, name },
			lualine_x = { diagnostics, get_lsp, get_formatter, get_linter, type },
			lualine_y = { spaces, fileformat, encode },
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
	},
}
