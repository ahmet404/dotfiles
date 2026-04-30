return {
	"mfussenegger/nvim-lint",
	event = { "BufReadPre", "BufNewFile" },
	config = function()
		local lint = require("lint")

		lint.linters_by_ft = {
			python = { "pylint" },
			lua = { "luacheck" },
			c = { "cpplint" },
			cpp = { "cpplint" },
		}

		local function try_linting()
			local linters = lint.linters_by_ft[vim.bo.filetype]

			lint.try_lint(linters)
		end

		vim.keymap.set("n", "<leader>wl", function()
			try_linting()
		end, { desc = "Trigger linting for current file" })
	end,
}
