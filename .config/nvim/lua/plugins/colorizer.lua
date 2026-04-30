return {
	"catgoose/nvim-colorizer.lua",
	event = "BufRead",
	opts = {
		filetypes = { "*" },
		lazy_load = false, -- Lazily schedule buffer highlighting setup function
		options = {
			parsers = {
				css = true, -- preset: enables names, hex, rgb, hsl, oklch
				tailwind = { enable = true },
			},
			display = {
				mode = "virtualtext",
				virtualtext = { position = "after" },
			},
		},
		-- user_default_options = {
		-- 	names = false, -- "Name" codes like Blue or red.  Added from `vim.api.nvim_get_color_map()`
		-- 	names_opts = { -- options for mutating/filtering names.
		-- 		lowercase = true, -- name:lower(), highlight `blue` and `red`
		-- 		camelcase = true, -- name, highlight `Blue` and `Red`
		-- 		uppercase = false, -- name:upper(), highlight `BLUE` and `RED`
		-- 		strip_digits = false, -- ignore names with digits,
		-- 	},
		-- 	names_custom = false, -- Custom names to be highlighted: table|function|false
		-- 	RGB = true, -- #RGB hex codes
		-- 	RGBA = true, -- #RGBA hex codes
		-- 	RRGGBB = true, -- #RRGGBB hex codes
		-- 	RRGGBBAA = false, -- #RRGGBBAA hex codes
		-- 	AARRGGBB = false, -- 0xAARRGGBB hex codes
		-- 	rgb_fn = false, -- CSS rgb() and rgba() functions
		-- 	hsl_fn = false, -- CSS hsl() and hsla() functions
		-- 	oklch_fn = false, -- CSS oklch() function
		-- 	css = true, -- Enable all CSS *features*:
		-- 	css_fn = false, -- Enable all CSS *functions*: rgb_fn, hsl_fn, oklch_fn
		-- 	tailwind = true, -- Enable tailwind colors
		-- 	tailwind_opts = { -- Options for highlighting tailwind names
		-- 		update_names = true, -- When using tailwind = 'both', update tailwind names from LSP results.  See tailwind section
		-- 	},
		-- 	sass = { enable = true, parsers = { "css" } }, -- Enable sass colors
		-- 	mode = "background", -- Set the display mode
		-- 	always_update = true,
		-- 	hooks = {
		-- 		disable_line_highlight = false,
		-- 	},
		-- },
	},
}
