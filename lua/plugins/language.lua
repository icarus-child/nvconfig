return {
  {
    "R-nvim/R.nvim",
    lazy = false,
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
}
