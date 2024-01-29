return {
  "mfussenegger/nvim-dap",
  enabled = vim.fn.has "win32" == 0,
  dependencies = {
    {
      "jay-babu/mason-nvim-dap.nvim",
      dependencies = { "nvim-dap" },
      cmd = { "DapInstall", "DapUninstall" },
      opts = {
        handlers = {
          python = function(source_name)
            local dap = require "dap"
            local read_exec_path = function(exec_name)
              local handle = io.popen("which " .. exec_name)
              local result = handle:read("*a"):gsub("\n", "")
              handle:close()
              return result
            end
            dap.adapters.python = {
              type = "executable",
              command = read_exec_path "python",
              args = {
                "-m",
                "debugpy.adapter",
              },
            }
            dap.configurations.python = {
              {
                type = "python",
                request = "launch",
                name = "Launch file",
                program = "${file}",
              },
            }
          end,
        },
      },
    },
    {
      "rcarriga/nvim-dap-ui",
      opts = { floating = { border = "rounded" } },
      config = require "plugins.configs.nvim-dap-ui",
    },
    {
      "rcarriga/cmp-dap",
      dependencies = { "nvim-cmp" },
      config = require "plugins.configs.cmp-dap",
    },
  },
  event = "User AstroFile",
}
