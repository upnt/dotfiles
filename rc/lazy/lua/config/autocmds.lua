-- Autocmds are automatically loaded on the VeryLazy event
-- Default autocmds that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/autocmds.lua
-- Add any additional autocmds here
vim.api.nvim_create_augroup("fcitx", {})
vim.api.nvim_create_autocmd({ "insertleave", "cmdlineleave" }, {
  group = "fcitx",
  callback = function()
    os.execute("fcitx5-remote -c")
  end,
})
vim.api.nvim_create_augroup("filetypes", {})
vim.api.nvim_create_autocmd("BufEnter", {
  group = "filetypes",
  pattern = "*.lua",
  callback = function()
    vim.opt_local.tabstop = 2
  end,
})
