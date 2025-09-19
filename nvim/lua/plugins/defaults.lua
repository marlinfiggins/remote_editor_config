local M = {}

M.icons = {
	diagnostics = {
		BoldError = "",
		Error = "E",
		BoldWarning = "",
		Warning = "W",
		BoldInformation = "",
		Information = "I",
		BoldQuestion = "",
		Question = "?",
		BoldHint = "󰌶",
		Hint = "H",
		Debug = "D",
		Trace = "✎",
	},
}

M.diagnostic_config = {
	signs = {
		active = true,
		values = {
			{ name = "DiagnosticSignError", text = M.icons.diagnostics.Error },
			{ name = "DiagnosticSignWarn", text = M.icons.diagnostics.Warning },
			{ name = "DiagnosticSignHint", text = M.icons.diagnostics.Hint },
			{ name = "DiagnosticSignInfo", text = M.icons.diagnostics.Information },
		},
	},
	virtual_text = true,
	update_in_insert = false,
	underline = true,
	severity_sort = true,
	float = {
		focusable = true,
		style = "minimal",
		border = "rounded",
		source = "always",
		header = "",
		prefix = "",
	},
}

return M
