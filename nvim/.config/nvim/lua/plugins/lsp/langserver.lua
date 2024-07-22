local lspconfig = require("lspconfig")
local c = require("plugins.lsp.custom")

-- lua-language-server
lspconfig.lua_ls.setup({
  settings = {
    Lua = {
      runtime = { version = "LuaJIT", path = vim.split(package.path, ";") },
      telemetry = {
        enable = false,
      },
      diagnostics = {
        enable = true,
        globals = { "vim", "awesome", "use", "client", "root", "s", "screen", "result", "str", "fs_stat" },
      },
      workspace = {
        library = vim.api.nvim_get_runtime_file("lua", true),
        preloadFileSize = 1000,
      },
    },
  },
})

-- Marksman for markdown language
lspconfig.marksman.setup({})

-- Clangd for C, CPP language
lspconfig.clangd.setup({})

-- lspconfig.tsserver.setup(c.default({
--     root_dir = c.custom_cwd,
--     settings = {
--         tsserver = {
--             useBatchedBufferSync = true,
--         },
--         javascript = {
--             autoClosingTags = true,
--             suggest = {
--                 autoImports = true,
--             },
--             updateImportsOnFileMove = {
--                 enable = true,
--             },
--             suggestionActions = {
--                 enabled = true,
--             },
--         },
--     },
-- }))

-- lspconfig.pyright.setup(c.default({
--     settings = {
--         python = {
--             analysis = {
--                 useLibraryCodeForTypes = false,
--                 autoImportCompletions = true,
--                 autoSearchPaths = true,
--                 diagnosticMode = "openFilesOnly",
--                 typeCheckingMode = "basic",
--             },
--         },
--     },
-- }))

-- lspconfig.jedi_language_server.setup(c.default({
--     settings = {
--         jedi = {
--             enable = true,
--             startupMessage = true,
--             markupKindPreferred = "markdown",
--             jediSettings = {
--                 autoImportconfigs = {},
--                 completion = { disableSnippets = false },
--                 diagnostics = { enable = true, didOpen = true, didSave = true, didChange = true },
--             },
--             workspace = { extraPaths = {} },
--         },
--     },
-- }))

-- lspconfig.sqls.setup({
--     cmd = { "sqls", "-config", vim.loop.os_homedir() .. "/.config/sqls/config.yml" },
--     on_init = c.custom_on_init,
--     capabilities = c.custom_capabilities(),
--     on_attach = function(client, bufnr)
--         require("sqls").on_attach(client, bufnr)
--     end,
-- })

-- lspconfig.gopls.setup(c.default({
--     cmd = { "gopls", "serve" },
--     root_dir = c.custom_cwd,
--     settings = {
--         gopls = {
--             analyses = {
--                 unusedparams = true,
--             },
--             staticcheck = true,
--             usePlaceholders = false,
--         },
--     },
-- }))

lspconfig.cssls.setup(c.default({
  cmd = { "css-languageserver", "--stdio" },
  root_dir = c.custom_cwd,
}))

lspconfig.yamlls.setup(c.default({
  settings = {
    yaml = {
      format = {
        enable = true,
        singleQuote = true,
        bracketSpacing = true,
      },
      editor = {
        tabSize = 2,
      },
      schemas = {
        ["https://json.schemastore.org/github-workflow.json"] = "ci.yml",
        ["https://raw.githubusercontent.com/compose-spec/compose-spec/master/schema/compose-spec.json"] = "compose.yml",
      },
    },
  },
}))

lspconfig.emmet_ls.setup(c.default({
  filetypes = {
    "html",
    -- "typescriptreact",
    -- "javascriptreact",
    -- "css",
    -- "sass",
    -- "scss",
    -- "less",
    "gohtmltmpl",
  },
}))

lspconfig.clangd.setup(c.default())

local servers = { "dockerls", "bashls", "vimls", "cssls" }
for _, lsp in ipairs(servers) do
  lspconfig[lsp].setup(c.default())
end
