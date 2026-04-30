return {
	"hrsh7th/nvim-cmp",
	event = "VeryLazy",
	dependencies = {
		"hrsh7th/cmp-buffer",
		"hrsh7th/cmp-path",
		"hrsh7th/cmp-cmdline",
		"saadparwaiz1/cmp_luasnip",
		{
			"hrsh7th/cmp-nvim-lsp",
			dependencies = {
				{
					"folke/lazydev.nvim",
					ft = "lua",
					opts = {
						library = {
							{ path = "${3rd}/luv/library", words = { "vim%.uv" } },
						},
					},
				},
				{ "antosha417/nvim-lsp-file-operations", config = true },
			},
		},
		{
			"L3MON4D3/LuaSnip",
			version = "v2.*",
			build = "make install_jsregexp",
			dependencies = {
				"rafamadriz/friendly-snippets",
				-- "honza/vim-snippets",
			},
		},
	},
	config = function()
		local cmp = require("cmp")
		local luasnip = require("luasnip")
		local compare = require("cmp.config.compare")
		local status_ok, icons = pcall(require, "plugins.lib.icons")
		if not status_ok then
			icons = {
				kind = {},
				ui = { Ellipsis = "..." },
			}
		end

		local source_names = {
			luasnip = "[Snip]",
			buffer = "[Buf]",
			nvim_lsp = "[LSP]",
			path = "[Path]",
		}

		local duplicates = {
			buffer = 1,
			path = 1,
			nvim_lsp = 0,
			luasnip = 1,
		}

		-- Helper function untuk Super-Tab
		local check_backspace = function()
			local col = vim.fn.col(".") - 1
			return col == 0 or vim.fn.getline("."):sub(col, col):match("%s")
		end

		cmp.setup({
			completion = {
				completeopt = "menu,menuone,noinsert",
			},
			window = {
				completion = cmp.config.window.bordered(),
				documentation = cmp.config.window.bordered(),
			},
			sorting = {
				priority_weight = 2,
				comparators = {
					compare.offset,
					compare.exact,
					compare.score,
					compare.recently_used,
					compare.kind,
					compare.sort_text,
					compare.length,
					compare.order,
				},
			},
			snippet = {
				expand = function(args)
					luasnip.lsp_expand(args.body)
				end,
			},

			mapping = cmp.mapping.preset.insert({
				["<C-b>"] = cmp.mapping.scroll_docs(-4),
				["<C-f>"] = cmp.mapping.scroll_docs(4),
				["<C-Space>"] = cmp.mapping.complete(),
				["<C-e>"] = cmp.mapping.abort(),
				-- Enter untuk confirm
				["<CR>"] = cmp.mapping(function(fallback)
					if cmp.visible() then
						if luasnip.expandable() then
							luasnip.expand()
						else
							cmp.confirm({
								select = true, -- Auto select item pertama jika tekan enter
							})
						end
					else
						fallback()
					end
				end),
				-- Super Tab (Tab untuk next/jump snippet)
				["<Tab>"] = cmp.mapping(function(fallback)
					if cmp.visible() then
						cmp.select_next_item()
					elseif luasnip.locally_jumpable(1) then
						luasnip.jump(1)
					elseif check_backspace() then
						fallback()
					else
						fallback()
					end
				end, { "i", "s" }),
				-- Shift Tab (Mundur)
				["<S-Tab>"] = cmp.mapping(function(fallback)
					if cmp.visible() then
						cmp.select_prev_item()
					elseif luasnip.locally_jumpable(-1) then
						luasnip.jump(-1)
					else
						fallback()
					end
				end, { "i", "s" }),
			}),

			sources = cmp.config.sources({
				{ name = "nvim_lsp", group_index = 1 },
				{ name = "luasnip", group_index = 1 },
				{ name = "path", group_index = 2 },
				{
					name = "buffer",
					option = {
						get_bufnrs = function()
							local bufs = {}
							for _, win in ipairs(vim.api.nvim_list_wins()) do
								bufs[vim.api.nvim_win_get_buf(win)] = true
							end
							return vim.tbl_keys(bufs)
						end,
					},
					group_index = 2,
				},
			}),
			formatting = {
				fields = { "kind", "abbr", "menu" }, -- Urutan: Icon, Teks, Source
				format = function(entry, item)
					local max_width = 80 -- Batasi lebar agar popup tidak kegedean
					if #item.abbr > max_width then
						item.abbr = string.sub(item.abbr, 1, max_width) .. (icons.ui.Ellipsis or "...")
					end

					item.kind = icons.kind[item.kind]
					item.menu = source_names[entry.source.name]
					item.dup = duplicates[entry.source.name] or 0
					return item
				end,
			},

			experimental = {
				ghost_text = true,
				native_menu = false,
			},
		})

		-- snippets config
		luasnip.setup({
			history = true,
			updateevents = "TextChanged, TextChangedI",
			enable_autosnippets = true,
		})
		local lpath = vim.fn.stdpath("config") .. "/snippets"
		require("luasnip.loaders.from_vscode").lazy_load()
		require("luasnip.loaders.from_vscode").lazy_load({ paths = lpath })
	end,
}
