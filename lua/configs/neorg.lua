require("neorg").setup {
  load = {
    ["core.defaults"] = {},
    ["core.concealer"] = {
      config = {
        icon_preset = "diamond"
      }
    },
    ["core.highlights"] = {},
    ["core.dirman"] = {
      config = {
        workspaces = {
          personal = "~/notes/personal",
          work = "~/notes/work",
        },
        default_workspace = "personal",
      },
    },
  },
}

vim.wo.foldlevel = 99
vim.wo.conceallevel = 3
