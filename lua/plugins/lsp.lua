return {
  {
    "neovim/nvim-lspconfig",
    -- event = "User FilePost",
    lazy = false,
    dependencies = {
      -- nice loading notifications
      -- PERF: but can slow down startup
      {
        "j-hui/fidget.nvim",
        enabled = false,
        opts = {},
      },
    },
    config = function()
      local lspconfig = require "lspconfig"
      local util = require "lspconfig.util"

      vim.api.nvim_create_autocmd("LspAttach", {
        group = vim.api.nvim_create_augroup("kickstart-lsp-attach", { clear = true }),
        callback = function(event)
          local function map(keys, func, desc)
            vim.keymap.set("n", keys, func, { buffer = event.buf, desc = "LSP: " .. desc })
          end

          local client = vim.lsp.get_client_by_id(event.data.client_id)
          assert(client, "LSP client not found")

          ---@diagnostic disable-next-line: inject-field
          client.server_capabilities.document_formatting = true

          map("gd", vim.lsp.buf.definition, "[g]o to [d]efinition")
          map("gD", vim.lsp.buf.type_definition, "[g]o to type [D]efinition")
          map("gr", vim.lsp.buf.references, "[g]o to [r]eferences")
          map("<leader>lq", vim.diagnostic.setqflist, "diagnostic [q]uickfix")
          map("<leader>lc", vim.lsp.buf.code_action, "[c]ode action")
        end,
      })

      local lsp_flags = {
        allow_incremental_sync = true,
        debounce_text_changes = 150,
      }

      -- local capabilities = vim.lsp.protocol.make_client_capabilities()
      -- capabilities = vim.tbl_deep_extend('force', capabilities, require('cmp_nvim_lsp').default_capabilities())
      -- capabilities.textDocument.completion.completionItem.snippetSupport = true
      local capabilities = require("blink.cmp").get_lsp_capabilities({}, true)

      -- also needs:
      -- $home/.config/marksman/config.toml :
      -- [core]
      -- markdown.file_extensions = ["md", "markdown", "qmd"]
      -- lspconfig.marksman.setup {
      --   capabilities = capabilities,
      --   filetypes = { 'markdown', 'quarto' },
      --   root_dir = util.root_pattern('.git', '.marksman.toml', '_quarto.yml'),
      -- }

      lspconfig.r_language_server.setup {
        capabilities = capabilities,
        flags = lsp_flags,
        filetypes = { "r", "rmd", "rmarkdown" }, -- not directly using it for quarto (as that is handled by otter and often contains more languanges than just R)
        settings = {
          r = {
            lsp = {
              rich_documentation = true,
            },
          },
        },
      }

      lspconfig.cssls.setup {
        capabilities = capabilities,
        flags = lsp_flags,
      }

      -- lspconfig.html.setup {
      --   capabilities = capabilities,
      --   flags = lsp_flags,
      -- }

      lspconfig.yamlls.setup {
        capabilities = capabilities,
        flags = lsp_flags,
        settings = {
          yaml = {
            schemaStore = {
              enable = true,
              url = "",
            },
          },
        },
      }

      lspconfig.jsonls.setup {
        capabilities = capabilities,
        flags = lsp_flags,
      }

      lspconfig.texlab.setup {
        capabilities = capabilities,
        flags = lsp_flags,
      }

      lspconfig.ts_ls.setup {
        capabilities = capabilities,
        flags = lsp_flags,
        filetypes = { "js", "javascript", "typescript", "ojs" },
      }

      lspconfig.lua_ls.setup {
        capabilities = capabilities,
        flags = lsp_flags,
        settings = {
          Lua = {
            runtime = {
              -- Tell the language server which version of Lua you're using (most likely LuaJIT in the case of Neovim)
              version = "LuaJIT",
            },
            diagnostics = {
              -- Get the language server to recognize the `vim` global
              globals = { "vim" },
            },
            workspace = {
              -- Make the server aware of Neovim runtime files
              library = vim.api.nvim_get_runtime_file("", true),
            },
            -- Do not send telemetry data containing a randomized but unique identifier
            telemetry = {
              enable = true,
            },
          },
        },
      }

      lspconfig.vimls.setup {
        capabilities = capabilities,
        flags = lsp_flags,
      }

      lspconfig.bashls.setup {
        capabilities = capabilities,
        flags = lsp_flags,
        filetypes = { "sh", "bash" },
      }

      -- Add additional languages here.
      -- See `:h lspconfig-all` for the configuration.
      -- Like e.g. Haskell:
      -- lspconfig.hls.setup {
      --   capabilities = capabilities,
      --   flags = lsp_flags,
      --   filetypes = { 'haskell', 'lhaskell', 'cabal' },
      -- }

      lspconfig.clangd.setup {
        capabilities = capabilities,
        flags = lsp_flags,
      }

      lspconfig.gopls.setup {
        capabilities = capabilities,
        settings = {
          gopls = {
            completeUnimported = true,
            gofumpt = true,
          },
        },
      }

      lspconfig.gdscript.setup {
        capabilities = capabilities,
        flags = lsp_flags,
      }

      -- See https://github.com/neovim/neovim/issues/23291
      -- disable lsp watcher.
      -- Too lags on linux for python projects
      -- because pyright and nvim both create too many watchers otherwise
      if capabilities.workspace == nil then
        capabilities.workspace = {}
        capabilities.workspace.didChangeWatchedFiles = {}
      end
      capabilities.workspace.didChangeWatchedFiles.dynamicRegistration = false

      lspconfig.pyright.setup {
        capabilities = capabilities,
        flags = lsp_flags,
        settings = {
          python = {
            analysis = {
              autoSearchPaths = true,
              useLibraryCodeForTypes = true,
              diagnosticMode = "workspace",
            },
          },
        },
        root_dir = function(fname)
          return util.root_pattern(".git", "setup.py", "setup.cfg", "pyproject.toml", "requirements.txt")(fname)
        end,
      }
    end,
  },
}
