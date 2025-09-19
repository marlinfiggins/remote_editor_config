return function()
	require("conform").setup({
		notify_on_error = false,
		format_on_save = function(bufnr)
			local disable_filetypes = { c = true, cpp = true, python = true }
			return {
				timeout_ms = 500,
				lsp_fallback = not disable_filetypes[vim.bo[bufnr].filetype],
			}
		end,
		formatters_by_ft = {
			lua = { "stylua" },
			python = { "isort", "ruff_format" },
		},
	})

	vim.keymap.set("n", "<leader>f", function()
		require("conform").format({ async = true, lsp_fallback = true })
	end, { desc = "[F]ormat buffer" })
end
