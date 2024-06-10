require("neorg").setup {
  load = {
    ["core.defaults"] = {},
    ["core.concealer"] = {
      config = {
        icon_preset = "diamond"
      }
    },
    ["core.highlights"] = {
      config = {
        highlights = {
          headings = {
            {
              prefix = "guifg=#f57a16",
              title = "guifg=#f57a16"
            },
            {
              prefix = "+@label",
              title = "+@label"
            },
            {
              prefix = "+@constant",
              title = "+@constant"
            },
            {
              prefix = "+@string",
              title = "+@string"
            },
            {
              prefix = "+@label",
              title = "+@label"
            },
            {
              prefix = "+@constructor",
              title = "+@constructor"
            },
          },
          links = {
            file = "gui=undercurl"
          },
        },
      }
    },
    ["core.dirman"] = {
      config = {
        workspaces = {
          personal = "~/notes/personal",
          work = "~/notes/work",
        },
        default_workspace = "work",
      },
    },
    ["core.export"] = {}
  },
}

vim.wo.foldlevel = 99
vim.wo.conceallevel = 0
