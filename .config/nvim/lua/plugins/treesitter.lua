return {
  "nvim-treesitter/nvim-treesitter",
	build = ":TSUpdate",
	event = "VeryLazy",
	dependencies = {
		"windwp/nvim-ts-autotag"
	},
  opts = {
    ensure_installed = { "bash", "c", "html", "javascript", "json", "lua", "markdown", "python", "vim" },
    sync_install = false,
    auto_install = true,
    highlight = {
      enable = true,
      additional_vim_regex_highlighting = false,
    },
    indent = {
      enable = true,
    },
    incremental_selection = {
      enable = true,
    },
    autopairs = {
      enable = true,
    }
  }
}
