return {
  {
    "R-nvim/R.nvim",
    lazy = false,
    enabled = false,
  },

  {
    "arminveres/md-pdf.nvim",
    branch = "main",
    lazy = true,
    ft = { "markdown" },
    config = {
      vim.api.nvim_create_autocmd("FileType", {
        pattern = "markdown",
        callback = function()
          vim.keymap.set("n", "<leader>,", function()
            require("md-pdf").convert_md_to_pdf()
          end)
        end,
      }),
    },
    ---@diagnostic disable-next-line: undefined-doc-name
    ---@type md-pdf.config
    opts = {},
  },

  {
    "lervag/vimtex",
    lazy = false, -- we don't want to lazy load VimTeX
    -- tag = "v2.15", -- uncomment to pin to a specific release
    init = function()
      -- VimTeX configuration goes here, e.g.
      vim.g.vimtex_view_method = "zathura"
      vim.g.vimtex_syntax_enabled = true
    end,
  },
}
