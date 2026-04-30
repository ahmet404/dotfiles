return {
	"stevearc/conform.nvim",
	event = { "BufReadPre", "BufNewFile" },
	config = function()
		local conform = require("conform")

		conform.setup({
			formatters_by_ft = {
				javascript = { "prettier" },
				typescript = { "prettier" },
				javascriptreact = { "prettier" },
				typescriptreact = { "prettier" },
				svelte = { "prettier" },
				css = { "prettier" },
				html = { "prettier" },
				json = { "prettier" },
				yaml = { "prettier" },
				markdown = { "prettier" },
				graphql = { "prettier" },
				liquid = { "prettier" },
				lua = { "stylua" },
				python = { "isort", "black" },
				-- c = { "clang_format" },
				cpp = { "clang_format" },
			},
			format_on_save = {
				lsp_fallback = false,
				async = false,
				timeout_ms = 3000,
			},
		})

		vim.keymap.set({ "n", "v" }, "F", function()
			conform.format({
				lsp_fallback = true,
				async = false,
				timeout_ms = 1000,
			})
		end, { desc = "Format file or range (in visual mode)" })
	end,
}
-- return	{
--   "nvimtools/none-ls.nvim",
--   event = { "BufReadPre", "BufNewFile" },
--   config = function()
--     local nulls = require("null-ls")
--     nulls.setup{
--       sources = {
--         -- lua
--         nulls.builtins.formatting.stylua,
--         -- nulls.builtins.diagnostics.selene,
--
--         -- c, cpp
--         nulls.builtins.formatting.clang_format,
--
--         -- python
--         -- nulls.builtins.formatting.black,
--         --
--         -- -- bash,sh,zsh
--         -- nulls.builtins.formatting.shfmt,
--         --
--         -- -- sql
--         -- nulls.builtins.formatting.sqruff,
--         -- nulls.builtins.diagnostics.sqruff,
--         --
--         -- -- css, html, js, json and other stuff (lol)
--         -- nulls.builtins.formatting.prettier,
--         --
--         -- -- golang
--         -- nulls.builtins.formatting.goimports,
--         --
--         -- -- php
--         -- nulls.builtins.formatting.phpcsfixer,
--         --
--         -- -- proto
--         -- nulls.builtins.formatting.buf,
--         -- nulls.builtins.diagnostics.buf,
--       }
--     }
--   end
-- }
