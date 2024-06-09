-- This file  needs to have same structure as nvconfig.lua 
-- https://github.com/NvChad/NvChad/blob/v2.5/lua/nvconfig.lua

---@type ChadrcConfig
local M = {}

M.ui = {
	theme = "ayu_light",

	hl_override = {
		Comment = { italic = true },
		["@comment"] = { italic = true },
	},

  tabufline = {
    enabled = false,
    modules = {
      treeOffset = function()
        return ""
      end
    }
  },

  statusline = {
    separator_style = "block"
  }
}

return M
