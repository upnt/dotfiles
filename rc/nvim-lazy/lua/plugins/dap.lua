return {
  {
    "jay-babu/mason-nvim-dap.nvim",
    dependencies = "mason.nvim",
    cmd = { "DapInstall", "DapUninstall" },
    opts = {
      automatic_installation = true,
      handlers = {},
      ensure_installed = {
        "python",
      },
      config = function(_, opts)
        local dap = require("dap")
        local dapui = require("dapui")

        dapui.setup(opts)
        dap.listener.after.event_initialized["dapui_config"] = function()
          dapui.open({})
        end
        dap.listener.before.event_terminated["dapui_config"] = function()
          dapui.close({})
        end
        dap.listener.before.event_exited["dapui_config"] = function() end
      end,
    },
  },
}
