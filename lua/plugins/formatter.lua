return {
  -- Autoformat
  {
    "stevearc/conform.nvim",
    enabled = true,
    event = "BufWritePre",
    keys = {
      { "<leader>cf", '<cmd>lua require("conform").format()<cr>', desc = "[f]ormat" },
    },
    config = function()
      require("conform").setup {
        notify_on_error = false,
        format_on_save = {
          timeout_ms = 500,
          lsp_fallback = true,
        },
        formatters_by_ft = {
          lua = { "stylua" },
          css = { "prettierd", "prettier", stop_after_first = true },
          html = { "prettierd", "prettier", stop_after_first = true },
          javascript = { "prettierd", "prettier", stop_after_first = true },
          typescript = { "prettierd", "prettier", stop_after_first = true },
          typescriptreact = { "prettierd", "prettier", stop_after_first = true },
          gdscript = { "gdformat" },
          bash = { "beautysh" },
          sh = { "beautysh" },
          zsh = { "beautysh" },
          c = { "clang-format" },
          cpp = { "clang-format" },
          go = { "gofumpt" },
          r = { "styler" },
        },
        formatters = {
          -- mystylua = {
          --   command = 'stylua',
          --   args = { '--indent-type', 'Spaces', '--indent-width', '2', '-' },
          -- },
        },
      }
      -- Customize the "injected" formatter
      require("conform").formatters.injected = {
        -- Set the options field
        options = {
          -- Set to true to ignore errors
          ignore_errors = false,
          -- Map of treesitter language to file extension
          -- A temporary file name with this extension will be generated during formatting
          -- because some formatters care about the filename.
          lang_to_ext = {
            bash = "sh",
            c_sharp = "cs",
            elixir = "exs",
            javascript = "js",
            julia = "jl",
            latex = "tex",
            markdown = "md",
            python = "py",
            ruby = "rb",
            rust = "rs",
            teal = "tl",
            r = "r",
            typescript = "ts",
          },
          -- Map of treesitter language to formatters to use
          -- (defaults to the value from formatters_by_ft)
          lang_to_formatters = {},
        },
      }
    end,
  },
}
