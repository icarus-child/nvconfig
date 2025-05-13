return {
  { -- edit the file system as a buffer
    "stevearc/oil.nvim",
    opts = {
      keymaps = {
        --        ['<C-s>'] = false,
        --        ['<C-h>'] = false,
        --        ['<C-l>'] = false,

        ["q"] = "actions.close",
        ["<C-n>"] = "actions.close",
        ["<C-m>"] = "actions.close",
      },
      view_options = {
        show_hidden = true,
      },
      skip_confirm_for_simple_edits = false,
    },
    dependencies = { "nvim-tree/nvim-web-devicons" },
    keys = {
      { "<C-n>", "<CMD>Oil --preview<CR>", desc = "oil with preview" },
      { "<C-m>", "<CMD>Oil<CR>", desc = "oil no preview" },
    },
    cmd = "Oil",
  },

  -- show keybinding help window
  {
    "folke/which-key.nvim",
    enabled = true,
    event = "VeryLazy",
    config = function()
      require("which-key").setup {}
      require "config.keymap"
    end,
  },

  -- toggle vim numbers
  {
    "jeffkreeftmeijer/vim-numbertoggle",
    event = "VeryLazy",
  },

  -- nice quickfix list
  {
    "stevearc/quicker.nvim",
    enabled = false,
    event = "FileType qf",
    opts = {
      winfixheight = false,
      wrap = true,
    },
  },
  {
    "kevinhwang91/nvim-bqf",
    event = "FileType qf",
  },

  -- telescope
  -- a nice seletion UI also to find and open files
  {
    "nvim-telescope/telescope.nvim",
    cmd = "Telescope",
    dependencies = {
      { "nvim-telescope/telescope-fzf-native.nvim", build = "make" },
      { "nvim-telescope/telescope-dap.nvim" },
    },
    config = function()
      local telescope = require "telescope"
      local actions = require "telescope.actions"
      local previewers = require "telescope.previewers"
      local new_maker = function(filepath, bufnr, opts)
        opts = opts or {}
        filepath = vim.fn.expand(filepath)
        vim.loop.fs_stat(filepath, function(_, stat)
          if not stat then
            return
          end
          if stat.size > 100000 then
            return
          else
            previewers.buffer_previewer_maker(filepath, bufnr, opts)
          end
        end)
      end

      local telescope_config = require "telescope.config"
      -- Clone the default Telescope configuration
      local vimgrep_arguments = { unpack(telescope_config.values.vimgrep_arguments) }
      -- I don't want to search in the `docs` directory (rendered quarto output).
      table.insert(vimgrep_arguments, "--glob")
      table.insert(vimgrep_arguments, "!docs/*")

      table.insert(vimgrep_arguments, "--glob")
      table.insert(vimgrep_arguments, "!_site/*")

      table.insert(vimgrep_arguments, "--glob")
      table.insert(vimgrep_arguments, "!_reference/*")

      table.insert(vimgrep_arguments, "--glob")
      table.insert(vimgrep_arguments, "!_inv/*")

      table.insert(vimgrep_arguments, "--glob")
      table.insert(vimgrep_arguments, "!*_files/libs/*")

      table.insert(vimgrep_arguments, "--glob")
      table.insert(vimgrep_arguments, "!.obsidian/*")

      table.insert(vimgrep_arguments, "--glob")
      table.insert(vimgrep_arguments, "!.quarto/*")

      table.insert(vimgrep_arguments, "--glob")
      table.insert(vimgrep_arguments, "!_freeze/*")

      telescope.setup {
        defaults = {
          buffer_previewer_maker = new_maker,
          vimgrep_arguments = vimgrep_arguments,
          file_ignore_patterns = {
            "node%_modules",
            "%_cache",
            "%.git/",
            "site%_libs",
            "%.venv/",
            "%_files/libs/",
            "%.obsidian/",
            "%.quarto/",
            "%_freeze/",
          },
          layout_strategy = "flex",
          sorting_strategy = "ascending",
          layout_config = {
            prompt_position = "top",
          },
          mappings = {
            i = {
              ["<C-u>"] = false,
              ["<C-d>"] = false,
              ["<esc>"] = actions.close,
              ["<c-j>"] = actions.move_selection_next,
              ["<c-k>"] = actions.move_selection_previous,
            },
          },
        },
        pickers = {
          find_files = {
            hidden = false,
            find_command = {
              "rg",
              "--files",
              "--hidden",
              -- '--no-ignore',
              "--glob",
              "!.git/*",
              "--glob",
              "!**/.Rpro.user/*",
              "--glob",
              "!_site/*",
              "--glob",
              "!docs/**/*.html",
              "-L",
            },
          },
        },
        extensions = {
          fzf = {
            fuzzy = true, -- false will only do exact matching
            override_generic_sorter = true, -- override the generic sorter
            override_file_sorter = true, -- override the file sorter
            case_mode = "smart_case", -- or "ignore_case" or "respect_case"
          },
        },
      }
      telescope.load_extension "fzf"
      telescope.load_extension "dap"
    end,
  },

  { -- Highlight todo, notes, etc in comments
    "folke/todo-comments.nvim",
    dependencies = { "nvim-lua/plenary.nvim" },
    opts = { signs = false },
  },

  { -- statusline
    -- PERF: I found this to slow down the editor
    "nvim-lualine/lualine.nvim",
    enabled = true,
    config = function()
      local function macro_recording()
        local reg = vim.fn.reg_recording()
        if reg == "" then
          return ""
        end
        return "📷[" .. reg .. "]"
      end

      ---@diagnostic disable-next-line: undefined-field
      require("lualine").setup {
        options = {
          section_separators = "",
          component_separators = "",
          globalstatus = true,
        },
        sections = {
          lualine_a = { "mode", macro_recording },
          lualine_b = { "branch", "diff", "diagnostics" },
          -- lualine_b = {},
          lualine_c = { "searchcount" },
          lualine_x = { "filetype" },
          lualine_y = { "progress" },
          lualine_z = { "location" },
        },
        extensions = { "nvim-tree" },
      }
    end,
  },

  -- tab line visual upgrade and hotkey traversal
  {
    "nanozuki/tabby.nvim",
    lazy = false,
    enabled = true,
    keys = {
      { "<leader>tr", "<cmd>Tabby rename_tab<cr>", desc = "[t]abby [r]ename tab" }, -- TODO: spawn rename window
      { "<leader>tw", "<cmd>Tabby pick_window<cr>", desc = "[t]abby pick [w]indow" },
      { "<leader>tT", "<cmd>Tabby jump_to_tab<cr>", desc = "tabby [j]ump" },
    },
    config = function()
      require("tabby.tabline").use_preset "tab_only"
    end,
  },

  { -- show tree of symbols in the current file
    "hedyhli/outline.nvim",
    cmd = "Outline",
    keys = {
      { "<leader>lo", ":Outline<cr>", desc = "symbols [o]utline" },
    },
    opts = {
      providers = {
        priority = { "markdown", "lsp", "norg" },
        -- Configuration for each provider (3rd party providers are supported)
        lsp = {
          -- Lsp client names to ignore
          blacklist_clients = {},
        },
        markdown = {
          -- List of supported ft's to use the markdown provider
          filetypes = { "markdown", "quarto" },
        },
      },
    },
  },

  { -- or show symbols in the current file as breadcrumbs
    "Bekaboo/dropbar.nvim",
    enabled = false,
    dependencies = {
      "nvim-telescope/telescope-fzf-native.nvim",
    },
    config = function()
      -- turn off global option for windowline
      vim.opt.winbar = nil
      vim.keymap.set("n", "<leader>ls", require("dropbar.api").pick, { desc = "[s]ymbols" })
    end,
  },

  { -- show diagnostics list
    -- PERF: Slows down insert mode if open and there are many diagnostics
    "folke/trouble.nvim",
    enabled = false,
    config = function()
      local trouble = require "trouble"
      trouble.setup {}
      local function next()
        trouble.next { skip_groups = true, jump = true }
      end
      local function previous()
        trouble.previous { skip_groups = true, jump = true }
      end
      vim.keymap.set("n", "]t", next, { desc = "next [t]rouble item" })
      vim.keymap.set("n", "[t", previous, { desc = "previous [t]rouble item" })
    end,
  },

  { -- highlight markdown headings and code blocks etc.
    "MeanderingProgrammer/render-markdown.nvim",
    enabled = true,
    -- ft = {'quarto', 'markdown'},
    ft = { "markdown" },
    -- dependencies = { 'nvim-treesitter/nvim-treesitter' },
    -- dependencies = { 'nvim-treesitter/nvim-treesitter', 'echasnovski/mini.icons' }, -- if you use standalone mini plugins
    dependencies = { "nvim-treesitter/nvim-treesitter", "nvim-tree/nvim-web-devicons" }, -- if you prefer nvim-web-devicons
    ---@module 'render-markdown'
    ---@type render.md.UserConfig
    opts = {
      render_modes = { "n", "c", "t" },
      completions = {
        lsp = { enabled = false },
      },
      heading = {
        enabled = false,
      },
      paragraph = {
        enabled = false,
      },
      code = {
        enabled = true,
        style = "full",
        border = "thin",
        sign = false,
        render_modes = { "i", "v", "V" },
      },
      signs = {
        enabled = false,
      },
    },
  },
}
