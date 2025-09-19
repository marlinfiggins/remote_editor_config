return function()
	local wk = require("which-key")
	wk.setup()

	-- Top-level group names
	wk.register({
		["<leader>c"] = { name = "[C]ode" },
		["<leader>d"] = { name = "[D]ocument" },
		["<leader>h"] = { name = "Git [H]unk" },
		["<leader>r"] = { name = "[R]ename" },
		["<leader>s"] = { name = "[S]earch" },
		["<leader>t"] = { name = "[T]oggle" },
		["<leader>w"] = { name = "[W]orkspace" },
		["<leader>f"] = { name = "[F]ormat" },
	})

	-- Diagnostics (already mapped in keymaps.lua)
	wk.register({
		["<leader>e"] = "Show diagnostics",
		["<leader>q"] = "Diagnostics list",
	})

	-- Telescope mappings
	wk.register({
		["<leader>sh"] = { "<cmd>Telescope help_tags<CR>", "[S]earch [H]elp" },
		["<leader>sk"] = { "<cmd>Telescope keymaps<CR>", "[S]earch [K]eymaps" },
		["<leader>sf"] = { "<cmd>Telescope find_files<CR>", "[S]earch [F]iles" },
		["<leader>ss"] = { "<cmd>Telescope builtin<CR>", "[S]earch [S]elect" },
		["<leader>sw"] = { "<cmd>Telescope grep_string<CR>", "[S]earch current [W]ord" },
		["<leader>sg"] = { "<cmd>Telescope live_grep<CR>", "[S]earch by [G]rep" },
		["<leader>sd"] = { "<cmd>Telescope diagnostics<CR>", "[S]earch [D]iagnostics" },
		["<leader>sc"] = { "<cmd>Telescope resume<CR>", "[S]earch [C]ontinue" },
		["<leader>sr"] = { "<cmd>Telescope oldfiles<CR>", "[S]earch [R]ecent files" },
		["<leader><leader>"] = { "<cmd>Telescope buffers<CR>", "Find existing buffers" },
		["<leader>sn"] = {
			"<cmd>Telescope find_files cwd=" .. vim.fn.stdpath("config") .. "<CR>",
			"[S]earch [N]eovim files",
		},
	})

	-- Formatting
	wk.register({
		["<leader>f"] = {
			function()
				require("conform").format({ async = true, lsp_fallback = true })
			end,
			"[F]ormat buffer",
		},
	})

	-- Nvim-tree
	wk.register({
		["<leader>tt"] = { "<cmd>NvimTreeToggle<CR>", "[T]oggle [T]ree" },
	})

	-- Visual mode Git hunk actions
	wk.register({
		["<leader>h"] = { name = "Git [H]unk" },
	}, { mode = "v" })
end
