local M = {}

M.setup = function()
	local ctp_feline = require("catppuccin.groups.integrations.feline")
	ctp_feline.setup({})

	require("feline").setup({
		components = ctp_feline.get(),
	})

	-- local navic_exists, navic = pcall(require, "nvim-navic")
	-- if navic_exists then
	-- 	local winbar_components = {
	-- 		active = {},
	-- 		inactive = {},
	-- 	}
	-- 	table.insert(winbar_components.active, {})
	-- 	table.insert(winbar_components.active[1], {
	-- 		provider = function()
	-- 			return navic.get_location()
	-- 		end,
	-- 		enabled = function()
	-- 			return navic.is_available()
	-- 		end,
	-- 	})
	-- 	require("feline").winbar.setup({
	-- 		components = winbar_components,
	-- 	})
	-- end
end

return M
