return {
  -- common dependencies
  { "nvim-lua/plenary.nvim" },
  {
    "folke/snacks.nvim",
    dev = false,
    priority = 1000,
    lazy = false,
    ---@type snacks.Config
    opts = {
      styles = {},
      bigfile = { notify = false },
      quickfile = {},
      picker = {},
      indent = {},
      notifier = {},
    },
  },
  {
    "mason-org/mason.nvim",
    Cmd = "Mason",
    build = ":MasonUpdate",
    opts_extended = { "ensure_installed" },
    opts = {
      ensure_installed = {
        -- lsp
        "lua-language-server",
        "bash-language-server",
        "css-lsp",
        "html-lsp",
        "json-lsp",
        "pyright",
        "r-languageserver",
        "texlab",
        "typescript-language-server",
        "yaml-language-server",
        "clangd",
        "css-lsp",
        "html-lsp",
        "gdscript",

        -- formatter
        "stylua",
        "prettier",
        "black",
        "prettierd",
        "gdformat",
        "beautysh",
        "clang-format",
        "gofumpt",
        "styler",
      },
    },
  },
}
