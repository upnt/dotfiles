return {
  {
    "rcarriga/nvim-notify",
    opts = {
      timeout = 4000,
      stages = "static",
      max_height = function()
        return math.floor(vim.o.lines * 0.75)
      end,
      max_width = function()
        return math.floor(vim.o.columns * 0.75)
      end,
      init = function()
        local Util = require("lazyvim.util")
        if not Util.has("noice.nvim") then
          Util.on_very_lazy(function()
            vim.notify = require("notify")
          end)
        end
      end,
    },
  },
  {
    "vim-jp/vimdoc-ja",
  },
}
