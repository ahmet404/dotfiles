local cmp = require("cmp")
local luasnip = require("luasnip")
local icons = require("plugins.ui.icons")
local compare = require("cmp.config.compare")
local source_names = {
  luasnip = "[Snippet]",
  buffer = "[Buffer]",
  nvim_lsp = "[LSP]",
  path = "[Path]",
}
local duplicates = {
  buffer = 1,
  path = 1,
  nvim_lsp = 0,
  luasnip = 1,
}
local has_words_before = function()
  local line, col = unpack(vim.api.nvim_win_get_cursor(0))
  return col ~= 0 and vim.api.nvim_buf_get_lines(0, line - 1, line, true)[1]:sub(col, col):match("%s") == nil
end

cmp.setup({
  completion = {
    completeopt = "menu,menuone,noinsert",
  },
  sorting = {
    priority_weight = 2,
    comperators = {
      compare.score,
      compare.recently_used,
      compare.offset,
      compare.exact,
      compare.kind,
      compare.sort_text,
      compare.length,
      compare.order,
    },
  },
  snippet = {
    expand = function(args)
      require("luasnip").lsp_expand(args.body)
    end,
  },

  mapping = cmp.mapping.preset.insert({
    ["<C-b>"] = cmp.mapping.scroll_docs(-4),
    ["<C-f>"] = cmp.mapping.scroll_docs(4),
    ["<C-Space>"] = cmp.mapping.complete(),
    ["<C-e>"] = cmp.mapping({
      i = cmp.mapping.abort(),
      s = cmp.mapping.close(),
    }),
    ["<CR>"] = cmp.mapping({
      i = cmp.mapping.confirm({ behavior = cmp.ConfirmBehavior.Replace, select = false }),
      s = function(fallback)
        if cmp.visible() then
          cmp.confirm({ behavior = cmp.ConfirmBehavior.Replace, select = true })
        else
          fallback()
        end
      end,
    }),
    ["<Tab>"] = cmp.mapping(function(fallback)
      if cmp.visible() then
        cmp.select_next_item()
      elseif luasnip.expand_or_jumpable() then
        luasnip.expand_or_jump()
      elseif has_words_before() then
        cmp.complete()
      else
        fallback()
      end
    end, {
      "i",
      "s",
    }),
    ["<S-Tab>"] = cmp.mapping(function(fallback)
      if cmp.visible() then
        cmp.select_prev_item()
      elseif luasnip.jumpable(-1) then
        luasnip.jump(-1)
      else
        fallback()
      end
    end, {
      "i",
      "s",
    }),
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
    fields = { "abbr", "kind", "menu" },
    format = function(entry, item)
      local max_width = 80
      local duplicates_default = 0
      if max_width ~= 0 and #item.abbr > max_width then
        item.abbr = string.sub(item.abbr, 1, max_width - 1) .. icons.ui.Ellipsis
      end
      item.kind = icons.kind[item.kind]
      item.menu = source_names[entry.source.name]
      item.dup = duplicates[entry.source.name] or duplicates_default
      return item
    end,
  },

  window = {
    documentation = {
      winhighlight = "NormalFloat:NormalFloat,FloatBorder:TelescopeBorder",
    },
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
