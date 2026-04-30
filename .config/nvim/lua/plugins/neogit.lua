return {
	"NeogitOrg/neogit",
	cmd = "Neogit",
	dependencies = { "sindrets/diffview.nvim" },
	enabled = true,
  opts = {
    disable_signs = false,
    disable_hint = true,
    disable_commit_confirmation = false,
    disable_builtin_notifications = true,
    disable_insert_on_commit = false,
    signs = {
      section = { '', '󰘕' }, -- "󰁙", "󰁊"
      item = { '▸', '▾' },
      hunk = { '󰐕', '󰍴' },
    },
    integrations = { diffview = true },
  }
}
