-- keybind
vim.keymap.set("i", "jj", "<Esc>")

-- basic
vim.opt.autoindent = true
vim.opt.smartindent = true
vim.opt.smarttab = true
vim.opt.expandtab = true

vim.opt.shiftwidth = 4
vim.opt.softtabstop = 4
vim.opt.tabstop = 4

vim.opt.scrolloff = 5
vim.opt.splitright = true

vim.opt.swapfile = false

-- sound
vim.opt.errorbells = false

-- view
vim.opt.number = true
vim.opt.cursorline = true
vim.opt.hlsearch = true
vim.cmd("colorscheme desert")

-- Undo
if vim.fn.has("persistent_undo") == 1 then
  local undo_path = vim.fn.expand("~/.cache/undo/nvim")
  if vim.fn.isdirectory(undo_path) == 1 then
    vim.fn.mkdir(undo_path, "p")
  end
  vim.opt.undodir = undo_path
  vim.opt.undofile = true
end
