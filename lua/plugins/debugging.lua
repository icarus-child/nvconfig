return {
  {
    "nvim-neotest/neotest",
    lazy = false,
    dependencies = {
      "nvim-lua/plenary.nvim",
      "alfaix/neotest-gtest",
      "marilari88/neotest-vitest",
      "nvim-treesitter/nvim-treesitter",
    },
    config = function()
      ---@diagnostic disable-next-line: missing-fields
      require("neotest").setup {
        adapters = {
          require("neotest-gtest").setup {},
          require "neotest-vitest",
        },
      }
    end,
    keys = {
      {
        "<leader>dtt",
        function()
          require("neotest").run.run()
        end,
        desc = "[t]est",
      },

      {
        "<leader>dts",
        function()
          require("neotest").run.stop()
        end,
        desc = "[s]top test",
      },

      {
        "<leader>dta",
        function()
          require("neotest").run.attach()
        end,
        desc = "[a]ttach test",
      },

      {
        "<leader>dtf",
        function()
          require("neotest").run.run(vim.fn.expand "%")
        end,
        desc = "test [f]ile",
      },

      {
        "<leader>dte",
        function()
          require("neotest").run.run { suite = true }
          require("neotest").summary.open()
        end,
        desc = "test [e]verything",
      },

      {
        "<leader>dtw",
        function()
          require("neotest").summary.toggle()
        end,
        desc = "test summary [w]indow",
      },

      {
        "<leader>dtd",
        function()
          require("neotest").run.run { strategy = "dap" }
        end,
        desc = "[d]ebug test (dap)",
      },
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

      dap.configurations.lldb = {
        type = "executable",
        command = "rust-lldb",
        name = "lldb",
      }
      dap.configurations.rust = {
        {
          name = "hello-world",
          type = "lldb",
          request = "launch",
          program = "${file}",
          -- program = function()
          --   return vim.fn.getcwd() .. "/target/debug/hello-world"
          -- end,
          cwd = "${workspaceFolder}",
          stopOnEntry = false,
        },
      }

      dap.configurations.codelldb = {
        type = "server",
        port = "${port}",
        executable = {
          command = "codelldb",
          args = { "--port", "${port}" },
        },
      }
      dap.configurations.cpp = {
        {
          name = "hello-world",
          type = "lldb",
          request = "launch",
          program = "${file}",
          -- program = function()
          --   return vim.fn.getcwd() .. "/target/debug/hello-world"
          -- end,
          cwd = "${workspaceFolder}",
          stopOnEntry = false,
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
