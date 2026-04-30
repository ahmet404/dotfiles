return {
	{
		"goolord/alpha-nvim",
		event = "VimEnter",
		enabled = true,
		config = function()
			local dashboard_theme = require("alpha.themes.dashboard")
			local logo = require("plugins.lib.dashboard")

			-- Center vertically
			-- local header_lines = #dashboard_theme.section.header.val
			-- local total_lines = vim.o.lines
			-- local pad_top = math.floor((total_lines - header_lines) / 7)

			-- Layout
			dashboard_theme.opts.layout = {
				{ type = "padding", val = 1 },
				dashboard_theme.section.header,
				{ type = "padding", val = 1 },
				dashboard_theme.section.buttons,
				{ type = "padding", val = 0 },
				dashboard_theme.section.footer,
			}

			-- Header Section
			dashboard_theme.section.header.val = logo.badcoder
			dashboard_theme.section.header.opts.hl = "AlphaHeaderGreen"
			vim.api.nvim_set_hl(0, "AlphaHeaderGreen", { fg = "#db9227", bold = true })

			-- Buttons Section
			dashboard_theme.section.buttons.val = {
				dashboard_theme.button("f", " Find file", "<cmd>Telescope find_files <CR>"),
				dashboard_theme.button("t", " Find text", "<cmd>Telescope live_grep <CR>"),
				dashboard_theme.button("r", " Recent files", "<cmd>Telescope oldfiles <CR>"),
				-- dashboard_theme.button(
				--   "<leader> ql",
				--   " Load Last Session",
				--   "<cmd>lua require('persistence').load({ last = true }) <CR>"
				-- ),
				dashboard_theme.button("n", " New file", "<cmd>ene <BAR> startinsert <CR>"),
				dashboard_theme.button("l", "󰒲  Lazy", ":Lazy<CR>"),
				dashboard_theme.button("q", " Close", "<cmd>q <CR>"),
				-- Config nvim (cd to nvim C:\Users\Donato\AppData\Local\nvim) and open init.lua)
				dashboard_theme.button(
					"c",
					" Config",
					"<cmd>edit $MYVIMRC <CR> <cmd>cd " .. vim.fn.stdpath("config") .. " <CR>"
				),
			}
			dashboard_theme.section.buttons.opts.hl = "AlphaButtons"

			-- Lazy Loading
			if vim.o.filetype == "lazy" then
				vim.cmd.close()
				vim.api.nvim_create_autocmd("User", {
					once = true,
					pattern = "AlphaReady",
					callback = function()
						require("lazy").show()
					end,
				})
			end

			-- Set the dashbaord
			require("alpha").setup(dashboard_theme.opts)

			-- Draw Footer After Startup
			vim.api.nvim_create_autocmd("User", {
				once = true,
				pattern = "LazyVimStarted",
				callback = function()
					local stats = require("lazy").stats()
					local ms = (math.floor(stats.startuptime * 100 + 0.5) / 100)
					local version = "   "
						.. " v"
						.. vim.version().major
						.. "."
						.. vim.version().minor
						.. "."
						.. vim.version().patch
					local plugin = "⚡ Neovim loaded "
						.. stats.loaded
						.. "/"
						.. stats.count
						.. " plugins in "
						.. ms
						.. "ms"
					local fortune = require("alpha.fortune")
					local quote = table.concat(fortune(), "\n")
					local footer = "\t" .. version .. "\t" .. plugin .. "\n" .. quote

					-- Footer
					dashboard_theme.section.footer.val = footer
					pcall(vim.cmd.AlphaRedraw)
					dashboard_theme.section.footer.opts.hl = "AlphaFooter"
				end,
			})
		end,
	},
}
