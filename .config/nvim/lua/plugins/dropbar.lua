return {
  "Bekaboo/dropbar.nvim",
  event = "BufRead",
  opts = {
    bar = {
      enable = function(buf, win)
        buf = vim._resolve_bufnr(buf)
        if not vim.api.nvim_buf_is_valid(buf) or not vim.api.nvim_win_is_valid(win) then
          return false
        end
        -- MATIKAN DROPBAR UNTUK TERMINAL (toggleterm termasuk)
        if vim.bo[buf].buftype == "terminal" or vim.bo[buf].ft == "toggleterm" then
          return false
        end
        -- lanjutan default behaviour bawaan dropbar
        if vim.fn.win_gettype(win) ~= '' or vim.wo[win].winbar ~= '' or vim.bo[buf].ft == 'help' then
          return false
        end
        local stat = vim.uv.fs_stat(vim.api.nvim_buf_get_name(buf))
        if stat and stat.size > 1024 * 1024 then
          return false
        end
        return vim.bo[buf].ft == 'markdown'
          or pcall(vim.treesitter.get_parser, buf)
          or not vim.tbl_isempty(vim.lsp.get_clients({
            bufnr = buf,
            method = 'textDocument/documentSymbol',
          }))
      end
    }
  },
  config = function(_, opts)
    require("dropbar").setup(opts)
    local dropbar_api = require("dropbar.api")
    vim.keymap.set("n", "<Leader>;", dropbar_api.pick, { desc = " Winbar symbols " })
    vim.keymap.set("n", "[;", dropbar_api.goto_context_start, { desc = "Go to start of current context" })
    vim.keymap.set("n", "];", dropbar_api.select_next_context, { desc = "Select next context" })
  end
}
