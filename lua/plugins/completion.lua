return {
  {
    "windwp/nvim-autopairs",
    event = "InsertEnter",
    config = function()
      require("nvim-autopairs").setup {}
      require("nvim-autopairs").remove_rule "`"
    end,
  },

  -- new completion plugin
  {
    "saghen/blink.cmp",
    event = "InsertEnter",
    enabled = true,
    version = "*",
    dev = false,
    -- OR build from source, requires nightly: https://rust-lang.github.io/rustup/concepts/channels.html#working-with-nightly-rust
    -- build = 'cargo build --release',
    dependencies = {
      { "rafamadriz/friendly-snippets" },
      { "moyiz/blink-emoji.nvim" },
      { "Kaiser-Yang/blink-cmp-git" },
      {
        "saghen/blink.compat",
        dev = false,
        lazy = true,
        opts = {},
      },
      {
        "jmbuhr/cmp-pandoc-references",
        dev = false,
        ft = { "quarto", "markdown", "rmarkdown" },
      },
      { "R-nvim/cmp-r" },
    },
    ---@module 'blink.cmp'
    ---@type blink.cmp.Config
    opts = {
      keymap = {
        preset = "none",
        ["<Tab>"] = { "select_next", "fallback" },
        ["<S-Tab>"] = { "select_prev", "fallback" },
        ["<C-space>"] = { "show", "fallback" },
        ["<C-q>"] = { "select_and_accept", "fallback" },
        ["<CR>"] = { "select_and_accept", "fallback" },
        ["<C-e>"] = { "cancel", "fallback" },
        ["<C-k>"] = { "show_documentation", "hide_documentation", "fallback" },
        ["<C-n>"] = { "show_signature", "hide_signature", "fallback" },
        ["<C-d>"] = { "scroll_documentation_down", "fallback" },
        ["<C-u>"] = { "scroll_documentation_up", "fallback" },
      },
      cmdline = {
        enabled = true,
      },
      sources = {
        default = {
          "lsp",
          "path",
          "references",
          "git",
          "snippets",
          "buffer",
          -- "emoji",
          "cmp_r",
        },
        -- per_filetype = {
        --   r = { inherit_defaults = true, "cmp_r" },
        -- },
        providers = {
          emoji = {
            module = "blink-emoji",
            name = "Emoji",
            score_offset = -1,
          },
          git = {
            module = "blink-cmp-git",
            name = "Git",
            opts = {},
            enabled = function()
              return vim.tbl_contains({ "octo", "gitcommit", "git" }, vim.bo.filetype)
            end,
          },
          references = {
            module = "cmp-pandoc-references.blink",
            name = "pandoc_references",
            score_offset = 2,
          },
          symbols = { name = "symbols", module = "blink.compat.source" },
          cmp_r = {
            module = "blink.compat.source",
            name = "cmp_r",
          },
        },
      },
      appearance = {
        -- Sets the fallback highlight groups to nvim-cmp's highlight groups
        -- Useful for when your theme doesn't support blink.cmp
        -- Will be removed in a future release
        use_nvim_cmp_as_default = true,
        -- Set to 'mono' for 'Nerd Font Mono' or 'normal' for 'Nerd Font'
        -- Adjusts spacing to ensure icons are aligned
        nerd_font_variant = "mono",
      },
      completion = {
        documentation = {
          auto_show = true,
          auto_show_delay_ms = 100,
          treesitter_highlighting = true,
        },
        menu = {
          auto_show = true,
        },
        ghost_text = {
          enabled = false,
          show_with_menu = false, -- only show when menu is closed
        },
        trigger = {
          show_on_insert_on_trigger_character = true,
          show_on_x_blocked_trigger_characters = {
            "'",
            '"',
            "(",
            "{",
            "[",
          },
        },
      },
      signature = { enabled = true },
    },
  },

  -- gh copilot
  {
    "zbirenbaum/copilot.lua",
    enabled = false,
    event = "InsertEnter",
    config = function()
      require("copilot").setup {
        suggestion = {
          enabled = true,
          auto_trigger = true,
          debounce = 75,
          keymap = {
            accept = "<c-a>",
            accept_word = false,
            accept_line = false,
            next = "<M-]>",
            prev = "<M-[>",
            dismiss = "<C-]>",
          },
        },
        panel = { enabled = false },
      }
    end,
  },

  -- LLMs
  {
    "olimorris/codecompanion.nvim",
    version = "*",
    enabled = false,
    dependencies = {
      "nvim-lua/plenary.nvim",
      "nvim-treesitter/nvim-treesitter",
      "nvim-telescope/telescope.nvim",
    },
    keys = {
      { "<leader>ac", ":CodeCompanionChat Toggle<cr>", desc = "[a]i [c]hat" },
      { "<leader>aa", ":CodeCompanionActions<cr>", desc = "[a]i [a]actions" },
    },
    config = function()
      require("codecompanion").setup {
        display = {
          diff = {
            enabled = true,
          },
        },
        strategies = {
          chat = {
            -- adapter = "ollama",
            adapter = "copilot",
          },
          inline = {
            -- adapter = "ollama",
            adapter = "copilot",
          },
          agent = {
            -- adapter = "ollama",
            adapter = "copilot",
          },
        },
      }
    end,
  },
}
