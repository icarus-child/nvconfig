return {
  -- edit the file system as a buffer
  {
    "stevearc/oil.nvim",
    opts = {
      keymaps = {
        --        ['<C-s>'] = false,
        --        ['<C-h>'] = false,
        --        ['<C-l>'] = false,

        ["q"] = "actions.close",
        ["<C-n>"] = "actions.close",
        ["<ESC>"] = "actions.close",
      },
      use_default_keymaps = true,
      view_options = {
        show_hidden = true,
      },
      skip_confirm_for_simple_edits = true,
    },
    dependencies = { "nvim-tree/nvim-web-devicons" },
    keys = {
      { "<C-n>", "<CMD>Oil --preview<CR>", desc = "oil with preview" },
      { "<M-n>", "<CMD>Oil<CR>", desc = "oil without preview" },
    },
    cmd = "Oil",
  },

  { "nvzone/volt", lazy = true },

  {
    "nvzone/minty",
    cmd = { "Shades", "Huefy" },
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
    "kevinhwang91/nvim-bqf",
    event = "FileType qf",
  },

  { "akinsho/toggleterm.nvim", enabled = false, version = "*", config = true },

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
        ---@diagnostic disable-next-line: undefined-field
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
      telescope.load_extension "persisted"
    end,
  },

  -- Highlight todo, notes, etc in comments
  {
    "folke/todo-comments.nvim",
    lazy = false,
    dependencies = { "nvim-lua/plenary.nvim" },
    opts = { signs = false },
  },

  -- statusline
  {
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
    cmd = "Tabby",
    dependencies = {
      "nvim-tree/nvim-web-devicons",
    },
    keys = {
      { "<leader>tw", "<cmd>Tabby pick_window<cr>", desc = "tabby pick [w]indow" },
      { "<leader>tt", "<cmd>Tabby jump_to_tab<cr>", desc = "tabby [j]ump" },
      {
        "<leader>tr",
        function()
          vim.ui.input({ prompt = "Rename tab: " }, function(input)
            if input ~= nil and input ~= "" then
              vim.cmd("Tabby rename_tab " .. input)
            end
          end)
        end,
        desc = "tabby [r]ename tab",
      },
    },
    config = function()
      vim.o.showtabline = 2
      require("tabby.tabline").use_preset "tab_only"

      local theme = {
        fill = "TabLineFill",
        -- Also you can do this: fill = { fg='#f2e9de', bg='#907aa9', style='italic' }
        head = "TabLine",
        current_tab = "TabLineSel",
        tab = "TabLine",
        win = "TabLine",
        tail = "TabLine",
      }
      require("tabby.tabline").set(function(line)
        return {
          {
            { "  ", hl = theme.head },
            line.sep(" ", theme.head, theme.fill),
          },
          line.tabs().foreach(function(tab)
            local hl = tab.is_current() and theme.current_tab or theme.tab
            return {
              line.sep(" ", hl, theme.fill),
              -- (tab.in_jump_mode() and tab.jump_key()) or (tab.is_current() and " " or "󰆣 "),
              (tab.in_jump_mode() and tab.jump_key()) or tab.number(),
              tab.name(),
              line.sep(" ", hl, theme.fill),
              hl = hl,
              margin = " ",
            }
          end),
          line.spacer(),
          table.foreach(vim.lsp.get_clients(), function(_, lsp)
            return {
              line.sep(" ", theme.win, theme.fill),
              lsp.name,
              line.sep(" ", theme.win, theme.fill),
              hl = theme.win,
              margin = " ",
            }
          end),
          -- line.wins_in_tab(line.api.get_current_tab()).foreach(function(win)
          --   return {
          --     line.sep(" ", theme.win, theme.fill),
          --     win.is_current() and "+" or " ",
          --     win.buf_name(),
          --     line.sep(" ", theme.win, theme.fill),
          --     hl = theme.win,
          --     margin = " ",
          --   }
          -- end),
          {
            line.sep(" ", theme.tail, theme.fill),
            { "  ", hl = theme.tail },
          },
          hl = theme.fill,
        }
      end)
    end,
  },

  -- show tree of symbols in the current file
  {
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

  -- or show symbols in the current file as breadcrumbs
  {
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

  -- show diagnostics list
  {
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

  -- highlight markdown headings and code blocks etc.
  {
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

  {
    "rcarriga/nvim-notify",
    lazy = false,
  },

  {
    "folke/noice.nvim",
    event = "VeryLazy",
    opts = {
      lsp = {
        -- override markdown rendering so that **cmp** and other plugins use **Treesitter**
        override = {
          ["vim.lsp.util.convert_input_to_markdown_lines"] = true,
          ["vim.lsp.util.stylize_markdown"] = true,
          ["cmp.entry.get_documentation"] = true, -- requires hrsh7th/nvim-cmp
        },
        progress = {
          enabled = false,
        },
      },
      -- you can enable a preset for easier configuration
      presets = {
        bottom_search = true, -- use a classic bottom cmdline for search
        command_palette = false, -- position the cmdline and popupmenu together
        long_message_to_split = true, -- long messages will be sent to a split
        inc_rename = true, -- enables an input dialog for inc-rename.nvim
        lsp_doc_border = true, -- add a border to hover docs and signature help
      },

      notify = { enabled = true },
      messages = { enabled = true },
      cmdline = { enabled = true },
    },
    dependencies = {
      -- if you lazy-load any plugin below, make sure to add proper `module="..."` entries
      "MunifTanjim/nui.nvim",
      -- OPTIONAL:
      --   `nvim-notify` is only needed, if you want to use the notification view.
      --   If not available, we use `mini` as the fallback
      "rcarriga/nvim-notify",
    },
    keys = {
      {
        "<leader>vn",
        "<cmd>Noice telescope<cr>",
        desc = "[n]otification history",
      },
      {
        "<leader>vd",
        "<cmd>Noice dismiss<cr>",
        desc = "[d]ismiss notifications",
      },
    },
  },

  {
    "hat0uma/csvview.nvim",
    ---@module "csvview"
    ---@type CsvView.Options
    opts = {
      parser = { comments = { "#", "//" } },
      keymaps = {
        -- Text objects for selecting fields
        textobject_field_inner = { "if", mode = { "o", "x" } },
        textobject_field_outer = { "af", mode = { "o", "x" } },
        -- Excel-like navigation:
        -- Use <Tab> and <S-Tab> to move horizontally between fields.
        -- Use <Enter> and <S-Enter> to move vertically between rows and place the cursor at the end of the field.
        -- Note: In terminals, you may need to enable CSI-u mode to use <S-Tab> and <S-Enter>.
        jump_next_field_end = { "<Tab>", mode = { "n", "v" } },
        jump_prev_field_end = { "<S-Tab>", mode = { "n", "v" } },
        jump_next_row = { "<Enter>", mode = { "n", "v" } },
        jump_prev_row = { "<S-Enter>", mode = { "n", "v" } },
      },
    },
    cmd = { "CsvViewEnable", "CsvViewDisable", "CsvViewToggle" },
  },
}
