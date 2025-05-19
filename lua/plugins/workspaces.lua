return {
  {
    "olimorris/persisted.nvim",
    event = "BufReadPre",
    lazy = false,
    keys = {
      {
        "<leader>fs",
        "<cmd>Telescope persisted<cr>",
        desc = "[s]ession",
      },
    },
    config = function()
      require("persisted").setup {
        autoload = true,
        use_git_branch = true,
        on_autoload_no_session = function()
          vim.notify "No existing session to load."
        end,
        save_dir = vim.fn.expand(vim.fn.stdpath "data" .. "/sessions/"),
        telescope = {
          -- Mappings for managing sessions in Telescope
          mappings = {
            copy_session = "<C-c>",
            change_branch = "<C-b>",
            delete_session = "<C-d>",
          },
        },
      }

      -- use the Telescope extension to load a session,
      -- saving the current session before clearing all of the open buffers
      vim.api.nvim_create_autocmd("User", {
        pattern = "PersistedTelescopeLoadPre",
        ---@diagnostic disable-next-line: unused-local
        callback = function(session)
          -- Save the currently loaded session passing in the path to the current session
          require("persisted").save { session = vim.g.persisted_loaded_session }

          -- Delete all of the open buffers
          vim.api.nvim_input "<ESC>:wa!<CR>"
          vim.api.nvim_input "<ESC>:%bd!<CR>"
        end,
      })

      -- ensure that certain filetypes are removed from the session before it's saved
      vim.api.nvim_create_autocmd("User", {
        pattern = "PersistedSavePre",
        callback = function()
          for _, buf in ipairs(vim.api.nvim_list_bufs()) do
            if vim.bo[buf].filetype == "codecompanion" then
              vim.api.nvim_buf_delete(buf, { force = true })
            end
          end
        end,
      })
    end,
  },
}
