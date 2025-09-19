-- Bootstrap lazy.nvim
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
	vim.fn.system({
		"git",
		"clone",
		"--filter=blob:none",
		"--branch=stable",
		"https://github.com/folke/lazy.nvim.git",
		lazypath,
	})
end
vim.opt.rtp:prepend(lazypath)

require("lazy").setup({

	-- Detect tabstop/shiftwidth automatically
	"tpope/vim-sleuth",

	-- Comment toggling
	{ "numToStr/Comment.nvim", opts = {} },

	-- Gitsigns (full config in plugins/gitsigns.lua)
	{
		"lewis6991/gitsigns.nvim",
		opts = require("plugins.gitsigns").opts,
		on_attach = require("plugins.gitsigns").on_attach,
	},

	-- which-key (leader key discovery)
	{
		"folke/which-key.nvim",
		event = "VimEnter",
		config = require("plugins.whichkey"),
	},

	-- Telescope (fuzzy finder)
	{
		"nvim-telescope/telescope.nvim",
		branch = "0.1.x",
		dependencies = {
			"nvim-lua/plenary.nvim",
			{
				"nvim-telescope/telescope-fzf-native.nvim",
				build = "make",
				cond = function()
					return vim.fn.executable("make") == 1
				end,
			},
			"nvim-telescope/telescope-ui-select.nvim",
			{ "nvim-tree/nvim-web-devicons", enabled = vim.g.have_nerd_font },
		},
		config = require("plugins.telescope"),
	},

	-- Treesitter
	{
		"nvim-treesitter/nvim-treesitter",
		build = ":TSUpdate",
		config = require("plugins.treesitter"),
	},

	-- LSP + Mason
	{
		"neovim/nvim-lspconfig",
		dependencies = {
			{ "williamboman/mason.nvim", config = true },
			"williamboman/mason-lspconfig.nvim",
			"WhoIsSethDaniel/mason-tool-installer.nvim",
			{ "j-hui/fidget.nvim", opts = {} },
			{ "folke/neodev.nvim", opts = {} },
		},
		config = require("plugins.lsp"),
	},

	-- Completion (cmp + LuaSnip)
	{
		"hrsh7th/nvim-cmp",
		event = "InsertEnter",
		dependencies = {
			{
				"L3MON4D3/LuaSnip",
				build = (function()
					if vim.fn.has("win32") == 1 or vim.fn.executable("make") == 0 then
						return
					end
					return "make install_jsregexp"
				end)(),
			},
			"saadparwaiz1/cmp_luasnip",
			"hrsh7th/cmp-nvim-lsp",
			"hrsh7th/cmp-path",
		},
		config = require("plugins.cmp"),
	},

	-- Formatting
	{
		"stevearc/conform.nvim",
		lazy = false,
		config = require("plugins.formatting"),
	},

	-- Colorscheme
	{
		"folke/tokyonight.nvim",
		priority = 1000,
		config = require("plugins.colorscheme"),
	},

	-- Todo highlighting
	{
		"folke/todo-comments.nvim",
		event = "VimEnter",
		dependencies = { "nvim-lua/plenary.nvim" },
		opts = { signs = false },
	},

	-- Statusline + mini plugins
	{
		"echasnovski/mini.nvim",
		config = function()
			require("mini.statusline").setup({ use_icons = vim.g.have_nerd_font })
			require("mini.ai").setup({ n_lines = 500 })
			require("mini.surround").setup()
		end,
	},

	-- nvim-tree
	{
		"nvim-tree/nvim-tree.lua",
		dependencies = { "nvim-tree/nvim-web-devicons" },
		config = function()
			require("plugins.nvimtree").config()
		end,
	},

	-- LaTeX (vimtex + luasnip snippets)
	{
		"lervag/vimtex",
		lazy = false,
		init = function()
			vim.g.vimtex_view_method = "skim"
			vim.g.vimtex_compiler_progname = "nvr"
		end,
	},
	{ "evesdropper/luasnip-latex-snippets.nvim" },
}, {
	ui = {
		icons = vim.g.have_nerd_font and {} or {
			cmd = "⌘",
			config = "🛠",
			event = "📅",
			ft = "📂",
			init = "⚙",
			keys = "🗝",
			plugin = "🔌",
			runtime = "💻",
			source = "📄",
			start = "🚀",
			task = "📌",
			lazy = "💤 ",
		},
	},
})
