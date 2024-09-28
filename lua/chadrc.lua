-- This file  needs to have same structure as nvconfig.lua
-- https://github.com/NvChad/NvChad/blob/v2.5/lua/nvconfig.lua

---@type ChadrcConfig
local M = {}

M.mason = {
  pkgs = {
    "lua-language-server",
    "stylua",
    "html-lsp",
    "css-lsp",
    "prettier",
    "prettierd",
    "bash-language-server",
    "beautysh",
    "tsserver",
    -- "eslint-lsp",
    "python-lsp-server",
    "gdtoolkit",
    "clang-format",
    "clangd",
  },
}

M.ui = {
  theme = "ayu_light",
  transparency = false,

  changed_themes = {
    ayu_light = {
      base_30 = {
        -- white = "#26292f",
        -- darker_black = "#f3f3f3",
        -- black = "#fafafa", --  nvim bg
        -- black2 = "#efefef",
        -- one_bg = "#ebebeb",
        -- one_bg2 = "#e1e1e1", -- Highlight of context
        -- one_bg3 = "#d7d7d7",
        -- grey = "#cdcdcd",
        grey_fg = "#a9a9a9", -- comments
        -- grey_fg2 = "#acacac", -- Highlight background
        -- light_grey = "#a0a0a0", -- Line numbers
        -- red = "#E65050",
        -- baby_pink = "#ff8282",
        -- pink = "#ffa5a5",
        -- line = "#e1e1e1", -- for lines like vertsplit
        -- green = "#6CBF43",
        -- vibrant_green = "#94e76b",
        -- blue = "#399EE6",
        -- nord_blue = "#2c91d9",
        -- yellow = "#E6BA7E",
        -- sun = "#f3c78b",
        -- purple = "#9F40FF",
        -- dark_purple = "#8627e6",
        -- teal = "#74c5aa",
        -- orange = "#FA8D3E",
        -- cyan = "#95E6CB",
        -- statusline_bg = "#f0f0f0",
        -- lightbg = "#e6e6e6",
        -- pmenu_bg = "#95E6CB",
        -- folder_bg = "#5C6166",
      },
      base_16 = {
        --   base00 = "#fafafa",
        --   base01 = "#f0f0f0",
        --   base02 = "#eeeeee",
        --   base03 = "#dfdfdf",
        --
        --   base04 = "#d2d2d2",
        --   base05 = "#5C6166",
        --   base06 = "#52575c",
        --   base07 = "#484d52",
        --   base08 = "#F07171",
        --   base09 = "#A37ACC",
        --
        --   base0A = "#399EE6",
        --   base0B = "#86B300",
        --   base0C = "#4CBF99",
        --   base0D = "#55B4D4",
        --
        --   base0E = "#FA8D3E",
        --
        --   base0F = "#F2AE49",
      },
    },
  },

  tabufline = {
    enabled = false,
    modules = {
      treeOffset = function()
        return ""
      end,
    },
  },

  statusline = {
    separator_style = "block",

    -- Need to update only on save / load / etc. not all the time
    -- order = { "mode", "file", "git", "%=", "lsp_msg", "%=", "diagnostics", "linter", "lsp", "cwd", "cursor" },
    -- modules = {
    --   linter = function()
    --     local status, lint = pcall(require, "lint")
    --     if not status then
    --       return "  Linter Failed "
    --     end
    --     local linters = lint.get_running()
    --     if #linters == 0 then
    --         return " 󰦕 No Linter "
    --     end
    --     return "󱉶 " .. table.concat(linters, ", ")
    --   end
    -- }
  },
}

return M
