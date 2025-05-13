return {

  -- add/delete/change can be done with the keymaps
  -- ys{motion}{char}, ds{char}, and cs{target}{replacement}
  {
    "kylechui/nvim-surround",
    event = "VeryLazy",
    opts = {},
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

  { -- format things as tables
    "godlygeek/tabular",
  },

  { -- generate docstrings
    "danymat/neogen",
    cmd = { "Neogen" },
    dependencies = "nvim-treesitter/nvim-treesitter",
    config = true,
  },

  {
    "chrishrb/gx.nvim",
    enabled = false,
    keys = { { "gx", "<cmd>Browse<cr>", mode = { "n", "x" } } },
    cmd = { "Browse" },
    init = function()
      vim.g.netrw_nogx = 1 -- disable netrw gx
    end,
    dependencies = { "nvim-lua/plenary.nvim" },
    submodules = false, -- not needed, submodules are required only for tests
    opts = {
      handler_options = {
        -- you can select between google, bing, duckduckgo, and ecosia
        search_engine = "duckduckgo",
      },
    },
  },

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
          require("harpoon").ui:toggle_quick_menu(harpoon:list())
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
