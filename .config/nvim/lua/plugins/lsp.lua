return {
	"neovim/nvim-lspconfig",
	event = "VeryLazy",
	dependencies = {
		"williamboman/mason.nvim",
		"williamboman/mason-lspconfig.nvim",
		"hrsh7th/cmp-nvim-lsp",
	},
	config = function()
		local capabilities = require("plugins.lib.capabilities")
		local icons = require("plugins.lib.icons")

		vim.lsp.config("*", {
			capabilities = capabilities,
		})

		-- DIAGNOSTICS
		vim.diagnostic.config({
			signs = {
				text = {
					[vim.diagnostic.severity.ERROR] = icons.diagnostics.Error,
					[vim.diagnostic.severity.WARN] = icons.diagnostics.Warning,
					[vim.diagnostic.severity.HINT] = icons.diagnostics.Hint,
					[vim.diagnostic.severity.INFO] = icons.diagnostics.Information,
				},
			},
			update_in_insert = false,
			underline = true,
			virtual_text = { spacing = 4, prefix = "❰" },
			severity_sort = true,
		})

		-- LSP SETUP
		require("mason").setup({
			ui = {
				icons = {
					package_installed = "",
					package_pending = "",
					package_uninstalled = "✗",
				},
			},
		})
		require("mason-lspconfig").setup({
			ensure_installed = { "clangd", "stylua" },
			automatic_enable = true,
		})

		vim.api.nvim_create_autocmd("LspDetach", {
			group = vim.api.nvim_create_augroup("UserLspConfig", {}),
			callback = function(ev)
				local client = vim.lsp.get_client_by_id(ev.data.client_id)
				if not client or not client.attached_buffers then
					return
				end
				for buf_id in pairs(client.attached_buffers) do
					if buf_id ~= ev.buf then
						return
					end
				end
				client:stop()
			end,
			desc = "Auto Detach LSP",
		})

		vim.api.nvim_create_autocmd("LspAttach", {
			group = vim.api.nvim_create_augroup("UserLspConfig", {}),
			callback = function(ev)
				local client = vim.lsp.get_client_by_id(ev.data.client_id)

				if not client then
					return
				end

				-- Hover documentation
				if
					client:supports_method("textDocument/hover") or client:supports_method("textDocument/signatureHelp")
				then
					vim.keymap.set("n", "L", function()
						vim.lsp.buf.hover({
							silent = true,
							border = "single",
							max_width = math.floor(vim.o.columns / 2),
						})
					end, { buffer = ev.buf, noremap = true, desc = "LSP: Show Documentation" })
				end

				-- Formatting
				if client:supports_method("textDocument/formatting") then
					vim.keymap.set("n", "F", function()
						vim.lsp.buf.format({ async = true })
					end, { buffer = ev.buf, noremap = true, desc = "LSP: Formats the current buffer" })
				end

				-- Go to definition
				if client:supports_method("textDocument/definition") then
					vim.keymap.set(
						"n",
						"gd",
						vim.lsp.buf.definition,
						{ buffer = ev.buf, noremap = true, desc = "LSP: Go to definition" }
					)
				end

				-- Inlay hints
				if client:supports_method("textDocument/inlayHint") then
					vim.lsp.inlay_hint.enable(true, { bufnr = ev.buf })

					vim.api.nvim_buf_create_user_command(ev.buf, "InlayHintToggle", function()
						local current_state = vim.lsp.inlay_hint.is_enabled({ bufnr = ev.buf })
						vim.lsp.inlay_hint.enable(not current_state, { bufnr = ev.buf })
					end, { desc = "Toggle inlay hints" })
				end

				vim.api.nvim_buf_create_user_command(ev.buf, "LspStop", function()
					if client:is_stopped() then
						vim.notify(client.name:upper() .. " is already stopped", vim.log.levels.WARN)
					else
						client:stop(true)
						vim.notify(client.name:upper() .. " stopped", vim.log.levels.INFO)
					end
				end, { desc = "Stop LSP client for this buffer" })
			end,
			desc = "User custom event for LspAttach",
		})
	end,
	-- LSP AUTO ENABLE
	-- INSTALL YOUR LSP LANGUAGE WITH MASON

	-- CONFIG YOUR LSP LANGUAGE IN BELLOW
	-- LUA
	vim.lsp.config("lua_ls", {
		settings = {
			Lua = {
				diagnostics = {
					globals = { "vim", "enabled", "fs_stat" },
				},
			},
		},
	}),
}
