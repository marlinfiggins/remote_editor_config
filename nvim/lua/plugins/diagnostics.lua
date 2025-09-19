return function()
	local defaults = require("plugins.defaults")
	local cfg = vim.deepcopy(defaults.diagnostic_config)

	-- Define signs from your table
	if cfg.signs and cfg.signs.values then
		for _, sign in ipairs(cfg.signs.values) do
			vim.fn.sign_define(sign.name, { text = sign.text, texthl = sign.name, numhl = "" })
		end
	end

	-- Apply diagnostic settings
	vim.diagnostic.config(cfg)
end
