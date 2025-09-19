local M = {}

local use_icons = vim.g.have_nerd_font and true or false
local icons = require("plugins.defaults").icons

function M.config()
	require("nvim-tree").setup({
		sort = { sorter = "case_sensitive" },
		view = { width = 30 },
		filters = { dotfiles = true },
		diagnostics = {
			enable = use_icons,
			show_on_dirs = false,
			show_on_open_dirs = true,
			debounce_delay = 50,
			severity = { min = vim.diagnostic.severity.HINT, max = vim.diagnostic.severity.ERROR },
			icons = {
				hint = icons.diagnostics.BoldHint,
				info = icons.diagnostics.BoldInformation,
				warning = icons.diagnostics.BoldWarning,
				error = icons.diagnostics.BoldError,
			},
		},
		renderer = {
			add_trailing = false,
			group_empty = true,
			highlight_git = "name",
			highlight_opened_files = "none",
			root_folder_label = ":t",
			full_name = false,
			indent_width = 2,
			special_files = { "Cargo.toml", "Makefile", "README.md", "readme.md" },
			symlink_destination = true,
			highlight_diagnostics = "none",
			highlight_modified = "none",
			highlight_bookmarks = "none",
			highlight_clipboard = "name",
			indent_markers = {
				enable = false,
				inline_arrows = true,
				icons = { corner = "└", edge = "│", item = "│", bottom = "─", none = " " },
			},
			icons = {
				webdev_colors = use_icons,
				web_devicons = {
					file = { enable = use_icons, color = use_icons },
					folder = { enable = false, color = use_icons },
				},
				git_placement = "before",
				padding = " ",
				symlink_arrow = " ➛ ",
				modified_placement = "after",
				diagnostics_placement = "signcolumn",
				bookmarks_placement = "signcolumn",
				show = {
					file = use_icons,
					folder = use_icons,
					folder_arrow = use_icons,
					git = use_icons,
					modified = use_icons,
					diagnostics = use_icons,
					bookmarks = use_icons,
				},
			},
		},
	})

	vim.keymap.set("n", "<leader>tt", ":NvimTreeToggle<CR>", { desc = "[T]oggle [T]ree" })
end

return M
