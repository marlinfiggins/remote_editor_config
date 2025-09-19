return function()
	local telescope = require("telescope")
	local builtin = require("telescope.builtin")

	telescope.setup({
		extensions = {
			["ui-select"] = {
				require("telescope.themes").get_dropdown(),
			},
		},
	})

	-- Enable extensions
	pcall(telescope.load_extension, "fzf")
	pcall(telescope.load_extension, "ui-select")

	-- Keymaps
	vim.keymap.set("n", "<leader>sh", builtin.help_tags, { desc = "[S]earch [H]elp" })
	vim.keymap.set("n", "<leader>sk", builtin.keymaps, { desc = "[S]earch [K]eymaps" })
	vim.keymap.set("n", "<leader>sf", builtin.find_files, { desc = "[S]earch [F]iles" })
	vim.keymap.set("n", "<leader>ss", builtin.builtin, { desc = "[S]earch [S]elect Telescope" })
	vim.keymap.set("n", "<leader>sw", builtin.grep_string, { desc = "[S]earch current [W]ord" })
	vim.keymap.set("n", "<leader>sg", builtin.live_grep, { desc = "[S]earch by [G]rep" })
	vim.keymap.set("n", "<leader>sd", builtin.diagnostics, { desc = "[S]earch [D]iagnostics" })
	vim.keymap.set("n", "<leader>sc", builtin.resume, { desc = "[S]earch [C]ontinue" })
	vim.keymap.set("n", "<leader>sr", builtin.oldfiles, { desc = "[S]earch [R]ecent Files" })
	vim.keymap.set("n", "<leader><leader>", builtin.buffers, { desc = "Find existing buffers" })

	-- Search inside current buffer
	vim.keymap.set("n", "<leader>/", function()
		builtin.current_buffer_fuzzy_find(require("telescope.themes").get_dropdown({
			winblend = 10,
			previewer = false,
		}))
	end, { desc = "[/] Fuzzy search in buffer" })

	-- Search open files
	vim.keymap.set("n", "<leader>s/", function()
		builtin.live_grep({ grep_open_files = true, prompt_title = "Live Grep in Open Files" })
	end, { desc = "[S]earch [/] in open files" })

	-- Search Neovim config
	vim.keymap.set("n", "<leader>sn", function()
		builtin.find_files({ cwd = vim.fn.stdpath("config") })
	end, { desc = "[S]earch [N]eovim config" })

	-- Project-wide searches (git aware)
	vim.keymap.set("n", "<leader>s.f", function()
		local root = string.gsub(vim.fn.system("git rev-parse --show-toplevel"), "\n", "")
		if vim.v.shell_error == 0 then
			builtin.find_files({ cwd = root })
		else
			builtin.find_files()
		end
	end, { desc = "[S]earch project files" })

	vim.keymap.set("n", "<leader>s.g", function()
		local root = string.gsub(vim.fn.system("git rev-parse --show-toplevel"), "\n", "")
		if vim.v.shell_error == 0 then
			builtin.live_grep({ cwd = root })
		else
			builtin.live_grep()
		end
	end, { desc = "[S]earch project grep" })
end
