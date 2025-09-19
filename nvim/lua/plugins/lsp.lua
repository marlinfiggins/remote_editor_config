return function()
	local lspconfig = require("lspconfig")

	-- Extend client capabilities with nvim-cmp
	local capabilities = vim.lsp.protocol.make_client_capabilities()
	capabilities = vim.tbl_deep_extend("force", capabilities, require("cmp_nvim_lsp").default_capabilities())

	-- On attach: keymaps, highlights, inlay hints
	vim.api.nvim_create_autocmd("LspAttach", {
		group = vim.api.nvim_create_augroup("lsp-attach", { clear = true }),
		callback = function(event)
			local map = function(keys, func, desc)
				vim.keymap.set("n", keys, func, { buffer = event.buf, desc = "LSP: " .. desc })
			end

			map("gd", require("telescope.builtin").lsp_definitions, "Goto Definition")
			map("gr", require("telescope.builtin").lsp_references, "Goto References")
			map("gI", require("telescope.builtin").lsp_implementations, "Goto Implementation")
			map("<leader>D", require("telescope.builtin").lsp_type_definitions, "Type Definition")
			map("<leader>ds", require("telescope.builtin").lsp_document_symbols, "Document Symbols")
			map("<leader>ws", require("telescope.builtin").lsp_dynamic_workspace_symbols, "Workspace Symbols")
			map("<leader>rn", vim.lsp.buf.rename, "Rename")
			map("<leader>ca", vim.lsp.buf.code_action, "Code Action")
			map("K", vim.lsp.buf.hover, "Hover Docs")
			map("gD", vim.lsp.buf.declaration, "Goto Declaration")

			local client = vim.lsp.get_client_by_id(event.data.client_id)
			if client and client.server_capabilities.documentHighlightProvider then
				local group = vim.api.nvim_create_augroup("lsp-highlight", { clear = false })
				vim.api.nvim_create_autocmd({ "CursorHold", "CursorHoldI" }, {
					buffer = event.buf,
					group = group,
					callback = vim.lsp.buf.document_highlight,
				})
				vim.api.nvim_create_autocmd({ "CursorMoved", "CursorMovedI" }, {
					buffer = event.buf,
					group = group,
					callback = vim.lsp.buf.clear_references,
				})
			end

			if client and client.server_capabilities.inlayHintProvider and vim.lsp.inlay_hint then
				map("<leader>th", function()
					vim.lsp.inlay_hint.enable(not vim.lsp.inlay_hint.is_enabled())
				end, "Toggle Inlay Hints")
			end
		end,
	})

	-- Servers list
	local servers = {
		pyright = {},
		lua_ls = {
			settings = {
				Lua = {
					completion = { callSnippet = "Replace" },
					-- diagnostics = { disable = { "missing-fields" } },
				},
			},
		},
	}

	-- Mason setup
	require("mason").setup()
	require("mason-tool-installer").setup({
		ensure_installed = vim.tbl_keys(servers),
	})

	require("mason-lspconfig").setup({
		handlers = {
			function(server_name)
				local server = servers[server_name] or {}
				server.capabilities = vim.tbl_deep_extend("force", {}, capabilities, server.capabilities or {})
				lspconfig[server_name].setup(server)
			end,
		},
	})
end
