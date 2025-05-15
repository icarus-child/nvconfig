return {
  {
    "nvim-neotest/neotest",
    dependencies = { "nvim-neotest/neotest-python" },
    config = function()
      ---@diagnostic disable-next-line: missing-fields
      require("neotest").setup {
        adapters = {
          require "neotest-python",
        },
      }
    end,
    keys = {
      { "<leader>dtt", ":lua require'neotest'.run.run({strategy = 'dap'})<cr>", desc = "[t]est" },
      { "<leader>dts", ":lua require'neotest'.run.stop()<cr>", desc = "[s]top test" },
      { "<leader>dta", ":lua require'neotest'.run.attach()<cr>", desc = "[a]ttach test" },
      { "<leader>dtf", ":lua require'neotest'.run.run(vim.fn.expand('%'))<cr>", desc = "test [f]ile" },
      { "<leader>dts", ":lua require'neotest'.summary.toggle()<cr>", desc = "test [s]ummary" },
    },
  },

  -- debug adapter protocol
  {
    "mfussenegger/nvim-dap",
    dependencies = {
      {
        "nvim-neotest/nvim-nio",
        "rcarriga/nvim-dap-ui",
        "mfussenegger/nvim-dap-python",
        "theHamsta/nvim-dap-virtual-text",
      },
    },
    config = function()
      vim.fn.sign_define("DapBreakpoint", { text = "🦆", texthl = "", linehl = "", numhl = "" })
      local dap = require "dap"
      local ui = require "dapui"
      require("dapui").setup()
      require("dap-python").setup()
      require("dap.ext.vscode").load_launchjs "launch.json"

      require("nvim-dap-virtual-text").setup {
        -- Hides tokens, secrets, and other sensitive information
        -- From TJ DeVries' config
        -- Not necessary, but also can't hurt
        display_callback = function(variable)
          local name = string.lower(variable.name)
          local value = string.lower(variable.value)
          if name:match "secret" or name:match "api" or value:match "secret" or value:match "api" then
            return "*****"
          end

          if #variable.value > 15 then
            return " " .. string.sub(variable.value, 1, 15) .. "... "
          end

          return " " .. variable.value
        end,
      }

      dap.adapters.python = function(cb, config)
        if config.request == "attach" then
          ---@diagnostic disable-next-line: undefined-field
          local port = (config.connect or config).port
          ---@diagnostic disable-next-line: undefined-field
          local host = (config.connect or config).host or "127.0.0.1"
          cb {
            type = "server",
            port = assert(port, "`connect.port` is required for a python `attach` configuration"),
            host = host,
            options = {
              source_filetype = "python",
            },
          }
        else
          cb {
            type = "executable",
            command = "path/to/virtualenvs/debugpy/bin/python",
            args = { "-m", "debugpy.adapter" },
            options = {
              source_filetype = "python",
            },
          }
        end
      end
      dap.configurations.python = {
        {
          -- The first three options are required by nvim-dap
          type = "python", -- the type here established the link to the adapter definition: `dap.adapters.python`
          request = "launch",
          name = "Launch file",

          -- Options below are for debugpy, see https://github.com/microsoft/debugpy/wiki/Debug-configuration-settings for supported options

          program = "${file}", -- This configuration will launch the current file if used.
          pythonPath = function()
            -- debugpy supports launching an application with a different interpreter then the one used to launch debugpy itself.
            -- The code below looks for a `venv` or `.venv` folder in the current directly and uses the python within.
            -- You could adapt this - to for example use the `VIRTUAL_ENV` environment variable.
            local cwd = vim.fn.getcwd()
            if vim.fn.executable(cwd .. "/venv/bin/python") == 1 then
              return cwd .. "/venv/bin/python"
            elseif vim.fn.executable(cwd .. "/.venv/bin/python") == 1 then
              return cwd .. "/.venv/bin/python"
            else
              return "/usr/bin/python"
            end
          end,
        },
      }

      dap.adapters.godot = {
        type = "server",
        host = "127.0.0.1",
        port = 6006,
      }
      dap.configurations.gdscript = {
        {
          type = "godot",
          request = "launch",
          name = "Launch scene",
          project = "${workspaceFolder}",
        },
      }

      dap.adapters.bashdb = {
        type = "executable",
        command = vim.fn.stdpath "data" .. "/mason/packages/bash-debug-adapter/bash-debug-adapter",
        name = "bashdb",
      }
      dap.configurations.sh = {
        {
          type = "bashdb",
          request = "launch",
          name = "Launch file",
          showDebugOutput = true,
          pathBashdb = vim.fn.stdpath "data" .. "/mason/packages/bash-debug-adapter/extension/bashdb_dir/bashdb",
          pathBashdbLib = vim.fn.stdpath "data" .. "/mason/packages/bash-debug-adapter/extension/bashdb_dir",
          trace = true,
          file = "${file}",
          program = "${file}",
          cwd = "${workspaceFolder}",
          pathCat = "cat",
          pathBash = "/bin/bash",
          pathMkfifo = "mkfifo",
          pathPkill = "pkill",
          args = {},
          env = {},
          terminalKind = "integrated",
        },
      }

      dap.adapters.go = {
        type = "executable",
        command = "node",
        args = { os.getenv "HOME" .. "/dev/golang/vscode-go/extension/dist/debugAdapter.js" },
      }
      dap.configurations.go = {
        {
          type = "go",
          name = "Debug",
          request = "launch",
          showLog = false,
          program = "${file}",
          dlvToolPath = vim.fn.exepath "dlv", -- Adjust to where delve is installed
        },
      }

      dap.listeners.before.attach.dapui_config = function()
        ui.open()
      end
      dap.listeners.before.launch.dapui_config = function()
        ui.open()
      end
      dap.listeners.before.event_terminated.dapui_config = function()
        ui.close()
      end
      dap.listeners.before.event_exited.dapui_config = function()
        ui.close()
      end
    end,
    keys = {
      { "<leader>db", ":lua require'dap'.toggle_breakpoint()<cr>", desc = "debug [b]reakpoint" },
      { "<leader>dc", ":lua require'dap'.continue()<cr>", desc = "debug [c]ontinue" },
      { "<leader>do", ":lua require'dap'.step_over()<cr>", desc = "debug [o]ver" },
      { "<leader>dO", ":lua require'dap'.step_out()<cr>", desc = "debug [O]ut" },
      { "<leader>di", ":lua require'dap'.step_into()<cr>", desc = "debug [i]nto" },
      { "<leader>dr", ":lua require'dap'.repl_open()<cr>", desc = "debug [r]epl" },
      { "<leader>du", ":lua require'dapui'.toggle()<cr>", desc = "debug [u]i" },
    },
  },
}
