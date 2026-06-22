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

  -- commenting with e.g. `gcc` or `gcip`
  {
    -- respects TS, so it works in quarto documents 'numToStr/Comment.nvim',
    "numToStr/Comment.nvim",
    enabled = false,
    cond = function()
      return vim.fn.has "nvim-0.10" == 0
    end,
    branch = "master",
    config = true,
  },

  -- align text vertically
  {
    "godlygeek/tabular",
    enabled = false,
  },

  -- generate docstrings
  {
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
      { "<leader>tm", "<cmd>TSJToggle<cr>", desc = "treesj [t]oggle" },
      { "<leader>tj", "<cmd>TSJJoin<cr>", desc = "treesj [j]oin" },
      { "<leader>ts", "<cmd>TSJSplit<cr>", desc = "treesj [s]plit" },
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
      {
        "<C-a>",
        function()
          return require("dial.map").inc_normal()
        end,
        expr = true,
        desc = "Increment",
        mode = { "n", "v" },
      },
      {
        "<C-x>",
        function()
          return require("dial.map").dec_normal()
        end,
        expr = true,
        desc = "Decrement",
        mode = { "n", "v" },
      },
    },
    opts = function()
      local augend = require "dial.augend"

      local logical_alias = augend.constant.new {
        elements = { "&&", "||" },
        word = false,
        cyclic = true,
      }

      local ordinal_numbers = augend.constant.new {
        -- elements through which we cycle. When we increment, we go down
        -- On decrement we go up
        elements = {
          "first",
          "second",
          "third",
          "fourth",
          "fifth",
          "sixth",
          "seventh",
          "eighth",
          "ninth",
          "tenth",
        },
        -- if true, it only matches strings with word boundary. firstDate wouldn't work for example
        word = false,
        -- do we cycle back and forth (tenth to first on increment, first to tenth on decrement).
        -- Otherwise nothing will happen when there are no further values
        cyclic = true,
      }

      local weekdays = augend.constant.new {
        elements = {
          "Monday",
          "Tuesday",
          "Wednesday",
          "Thursday",
          "Friday",
          "Saturday",
          "Sunday",
        },
        word = true,
        cyclic = true,
      }

      local months = augend.constant.new {
        elements = {
          "January",
          "February",
          "March",
          "April",
          "May",
          "June",
          "July",
          "August",
          "September",
          "October",
          "November",
          "December",
        },
        word = true,
        cyclic = true,
      }

      local capitalized_boolean = augend.constant.new {
        elements = {
          "True",
          "False",
        },
        word = true,
        cyclic = true,
      }

      return {
        dials_by_ft = {
          css = "css",
          vue = "vue",
          javascript = "typescript",
          typescript = "typescript",
          typescriptreact = "typescript",
          javascriptreact = "typescript",
          json = "json",
          lua = "lua",
          markdown = "markdown",
          sass = "css",
          scss = "css",
          python = "python",
        },
        groups = {
          default = {
            augend.integer.alias.decimal, -- nonnegative decimal number (0, 1, 2, 3, ...)
            augend.integer.alias.decimal_int, -- nonnegative and negative decimal number
            augend.integer.alias.hex, -- nonnegative hex number  (0x01, 0x1a1f, etc.)
            augend.date.alias["%Y/%m/%d"], -- date (2022/02/19, etc.)
            ordinal_numbers,
            weekdays,
            months,
            capitalized_boolean,
            augend.constant.alias.bool, -- boolean value (true <-> false)
            logical_alias,
          },
          vue = {
            augend.constant.new { elements = { "let", "const" } },
            augend.hexcolor.new { case = "lower" },
            augend.hexcolor.new { case = "upper" },
          },
          typescript = {
            augend.constant.new { elements = { "let", "const" } },
          },
          css = {
            augend.hexcolor.new {
              case = "lower",
            },
            augend.hexcolor.new {
              case = "upper",
            },
          },
          markdown = {
            augend.constant.new {
              elements = { "[ ]", "[x]" },
              word = false,
              cyclic = true,
            },
            augend.misc.alias.markdown_header,
          },
          json = {
            augend.semver.alias.semver, -- versioning (v1.1.2)
          },
          lua = {
            augend.constant.new {
              elements = { "and", "or" },
              word = true, -- if false, "sand" is incremented into "sor", "doctor" into "doctand", etc.
              cyclic = true, -- "or" is incremented into "and".
            },
          },
          python = {
            augend.constant.new {
              elements = { "and", "or" },
            },
          },
        },
      }
    end,
    config = function(_, opts)
      -- copy defaults to each group
      for name, group in pairs(opts.groups) do
        if name ~= "default" then
          vim.list_extend(group, opts.groups.default)
        end
      end
      require("dial.config").augends:register_group(opts.groups)
      vim.g.dials_by_ft = opts.dials_by_ft
    end,
  },

  -- in-file traversal
  -- lazy loads itself, attempting to lazy load can cause issues
  {
    url = "https://codeberg.org/andyg/leap.nvim",
    lazy = false,
    config = function()
      vim.keymap.set({ 'n', 'x', 'o' }, 's', '<Plug>(leap)')
      vim.keymap.set('n',               'S', '<Plug>(leap-from-window)')
        
      -- E.g., `gs{leap}$y` or `ygs{leap}$`, where {leap}, as usual, means
      -- {char1}{char2}{label?}. The linewise version can also take [count],
      -- e.g. `d2gS{leap}` deletes two lines.
      vim.keymap.set({ 'n', 'o' }, 'gs', '<Plug>(leap-remote)')
      vim.keymap.set({ 'n', 'o' }, 'gS', '<Plug>(leap-remote-linewise)')
      -- Useful shortcut for a frequent operation: the same as remote-linewise,
      -- except it auto-triggers even without [count] (`yR{leap}` copies a line).
      vim.keymap.set({ 'o' },      'R',  '<Plug>(leap-remote-line)')
      -- These commands expect another character as input before leaping, and
      -- select the given text object at the destination (`yarp{leap}`).
      vim.keymap.set({ 'x', 'o' }, 'ar', '<Plug>(leap-remote-text-object)')
      vim.keymap.set({ 'x', 'o' }, 'ir', '<Plug>(leap-remote-inner-text-object)')

      -- Set automatic paste after yanking:
      vim.api.nvim_create_autocmd('User', {
        pattern = 'RemoteOperationDone',
        group = vim.api.nvim_create_augroup('LeapRemote', {}),
        callback = function(event)
          if vim.v.operator == 'y' and event.data.register == '"' then
            vim.cmd('normal! p')
          end
        end,
      })

      -- Highly recommended: define a preview filter to reduce visual noise
      -- and the blinking effect after the first keypress.
      -- For example, define word boundaries as the common case, that is, skip
      -- preview for matches starting with whitespace or an alphabetic
      -- mid-word character: foobar[baaz] = quux
      --                     ^    ^^^  ^^ ^ ^  ^
      require('leap').opts.preview = function(ch0, ch1, ch2)
        return not (
          ch1:match('%s')
          or (ch0:match('%a') and ch1:match('%a') and ch2:match('%a'))
        )
      end

      -- Enable the traversal keys to repeat the previous search without
      -- explicitly invoking Leap (`<cr><cr>...` instead of `s<cr><cr>...`):
      do
        local clever = require('leap.user').with_traversal_keys
        vim.keymap.set({ 'n', 'x', 'o' }, '<cr>', function()
          require('leap').leap {
            ['repeat'] = true, opts = clever('<cr>', '<bs>'),
          }
        end)
        vim.keymap.set({ 'n', 'x', 'o' }, '<bs>', function()
          require('leap').leap {
            ['repeat'] = true, opts = clever('<bs>', '<cr>'), backward = true,
          }
        end)
      end
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
        desc = "[a]dd file to harpoon list",
      },
      {
        "<leader>fn",
        function()
          require("harpoon").ui:toggle_quick_menu(require("harpoon"):list())
        end,
        desc = "toggle harpoon menu",
      },

      {
        "<localleader>a",
        function()
          require("harpoon"):list():select(1)
        end,
        desc = "select harpoon slot 1",
      },
      {
        "<localleader>s",
        function()
          require("harpoon"):list():select(2)
        end,
        desc = "select harpoon slot 2",
      },
      {
        "<localleader>d",
        function()
          require("harpoon"):list():select(3)
        end,
        desc = "select harpoon slot 3",
      },
      {
        "<localleader>f",
        function()
          require("harpoon"):list():select(4)
        end,
        desc = "select harpoon slot 4",
      },
    },
    config = function()
      require("harpoon").setup()
    end,
  },
}
