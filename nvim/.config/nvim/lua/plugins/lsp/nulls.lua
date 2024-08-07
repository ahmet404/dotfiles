local null_ls = require("null-ls")

local formatting = null_ls.builtins.formatting
local code_actions = null_ls.builtins.code_actions
local diagnostics = null_ls.builtins.diagnostics

local sources = {
  null_ls.builtins.code_actions.gitsigns,
  --[[ formatting ]]
  formatting.eslint_d, -- javascript, html, typescript
  -- formatting.autopep8,
  formatting.stylua, -- lua
  formatting.clang_format.with({
    filetypes = {
      "cpp",
      "c",
    },
  }), -- c, c++
  -- formatting.stylelint,
  formatting.prettier,
  -- formatting.phpcbf, -- php
  formatting.black, -- python

  --[[ code actions ]]
  code_actions.eslint_d,

  --[[ diagnostics ]]
  diagnostics.eslint_d,
}

local lsp_formatting = function(bufnr)
  vim.lsp.buf.format({
    filter = function(client)
      -- apply whatever logic you want (in this example, we'll only use null-ls)
      return client.name == "null-ls"
    end,
    bufnr = bufnr,
  })
end

-- if you want to set up formatting on save, you can use this as a callback
local augroup = vim.api.nvim_create_augroup("LspFormatting", {})

local on_attach = function(client, bufnr)
  if client.supports_method("textDocument/formatting") then
    vim.api.nvim_clear_autocmds({ group = augroup, buffer = bufnr })
    vim.api.nvim_create_autocmd("BufWritePre", {
      group = augroup,
      buffer = bufnr,
      callback = function()
        lsp_formatting(bufnr)
      end,
    })
  end
end

null_ls.setup({
  sources = sources,
  on_attach = on_attach,
})

local function format()
  vim.lsp.buf.format({ async = true })
end

-- keymap
vim.keymap.set("n", "<leader>f", format, { desc = "LSP: Formats the current buffer" })
