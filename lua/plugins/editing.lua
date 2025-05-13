return {

  -- add/delete/change can be done with the keymaps
  -- ys{motion}{char}, ds{char}, and cs{target}{replacement}
  {
    "kylechui/nvim-surround",
    event = "VeryLazy",
    opts = {},
  },

  -- indent based motions
  -- [=, ]=, etc.
  {
    "jeetsukumaran/vim-indentwise",
    event = "VeryLazy",
  },

  { -- commenting with e.g. `gcc` or `gcip`
    -- respects TS, so it works in quarto documents 'numToStr/Comment.nvim',
    "numToStr/Comment.nvim",
    version = nil,
    cond = function()
      return vim.fn.has "nvim-0.10" == 0
    end,
    branch = "master",
    config = true,
  },

  { -- align text vertically
    "godlygeek/tabular",
    enabled = false,
  },

  { -- generate docstrings
    "danymat/neogen",
    cmd = { "Neogen" },
    dependencies = "nvim-treesitter/nvim-treesitter",
    config = true,
  },

  -- open links in browser incl. jira tickets, cargo links, etc.
  {
    "chrishrb/gx.nvim",
    enabled = false,
    keys = { { "gx", "<cmd>Browse<cr>", mode = { "n", "x" } } },
    cmd = { "Browse" },
    init = function()
      vim.g.netrw_nogx = 1 -- disable netrw gx
    end,
    dependencies = { "nvim-lua/plenary.nvim" }, -- Required for Neovim < 0.10.0
    config = true, -- default settings
    submodules = false, -- not needed, submodules are required only for tests
  },

  -- in-file traversal
  {
    "folke/flash.nvim",
    enabled = false,
    event = "VeryLazy",
    opts = {
      modes = {
        search = {
          enabled = false,
        },
      },
    },
    keys = {
      {
        "s",
        mode = { "n", "x", "o" },
        function()
          require("flash").jump()
        end,
      },
      {
        "S",
        mode = { "o", "x" },
        function()
          require("flash").treesitter()
        end,
      },
    },
  },

  -- interactive global search and replace
  {
    "nvim-pack/nvim-spectre",
    cmd = { "Spectre" },
    dependencies = {
      "nvim-lua/plenary.nvim",
    },
  },

  -- manipulate asdf => { asdf }
  {
    "Wansmer/treesj",
    keys = {
      { "<leader>tm", "<cmd>TSJToggle<cr>", desc = "[t]reesj [t]oggle" },
      { "<leader>tj", "<cmd>TSJJoin<cr>", desc = "[t]reesj [j]oin" },
      { "<leader>ts", "<cmd>TSJSplit<cr>", desc = "[t]reesj [s]plit" },
    },
    -- if you install parsers with `nvim-treesitter`
    dependencies = { "nvim-treesitter/nvim-treesitter" },
    opts = { use_default_keymaps = false },
  },

  -- advanced increment / decrement
  -- (supports decimals, booleans, dates, etc.)
  {
    "monaqa/dial.nvim",
    keys = {
      { "<C-a>", "<Plug>(dial-increment)", mode = { "n", "v" } },
      { "<C-x>", "<Plug>(dial-decrement)", mode = { "n", "v" } },
      { "g<C-a>", "g<Plug>(dial-increment)", mode = { "n", "v" } },
      { "g<C-x>", "g<Plug>(dial-decrement)", mode = { "n", "v" } },
    },
  },

  -- in-file traversal
  -- lazy loads itself, attempting to lazy load can cause issues
  {
    "ggandor/leap.nvim",
    lazy = false,
    opts = function()
      vim.keymap.set({ "n", "x", "o" }, "s", "<Plug>(leap-forward)")
      vim.keymap.set({ "n", "x", "o" }, "S", "<Plug>(leap-backward)")
      vim.keymap.set({ "n", "x", "o" }, "gs", "<Plug>(leap-from-window)")
      require("leap").opts.equivalence_classes = { " \t\r\n", "([{", ")]}", "'\"`" }
    end,
  },

  -- file pinning and switching
  {
    "ThePrimeagen/harpoon",
    branch = "harpoon2",
    dependencies = { "nvim-lua/plenary.nvim" },
    keys = {
      -- Keymaps
      {
        "<leader>a",
        function()
          require("harpoon"):list():add()
        end,
        { desc = "[a]dd file to harpoon list" },
      },
      {
        "<leader>fn",
        function()
          require("harpoon").ui:toggle_quick_menu(require("harpoon"):list())
        end,
        { desc = "toggle harpoon menu" },
      },

      {
        "<localleader>a",
        function()
          require("harpoon"):list():select(1)
        end,
        { desc = "select harpoon slot 1" },
      },
      {
        "<localleader>s",
        function()
          require("harpoon"):list():select(2)
        end,
        { desc = "select harpoon slot 2" },
      },
      {
        "<localleader>d",
        function()
          require("harpoon"):list():select(3)
        end,
        { desc = "select harpoon slot 3" },
      },
      {
        "<localleader>f",
        function()
          require("harpoon"):list():select(4)
        end,
        { desc = "select harpoon slot 4" },
      },
    },
    config = function()
      require("harpoon").setup()
    end,
  },
}
