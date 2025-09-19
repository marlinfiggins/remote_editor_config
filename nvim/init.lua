-- Core config
require("options")
require("keymaps")
require("autocmds")

-- Apply diagnostic signs & config early
require("plugins.diagnostics")()

-- Plugins (lazy.nvim)
require("plugins")
