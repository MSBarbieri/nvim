-- Options are automatically loaded before lazy.nvim startup
-- Default options that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/options.lua
-- Add any additional options here
--

local opts = {
  clipboard = "unnamedplus",
  history = 100,
  textwidth = 100,
  foldcolumn = "1", -- '0' is not bad
  shiftround = true, -- Round indent
  shiftwidth = 2, -- Size of an indent
  shortmess = vim.opt.shortmess:append({ W = true, I = true, c = true, C = true }),

  foldlevel = 99, -- Using ufo provider need a large value, feel free to decrease the value
  foldlevelstart = 99,
  foldenable = true,
  foldmethod = "indent",
  fillchars = [[eob: ,fold: ,foldopen:,foldsep: ,foldclose:]],

  colorcolumn = "80,120",
}

for k, v in pairs(opts) do
  vim.opt[k] = v
end
-- LSP Server to use for Python.
-- Set to "basedpyright" to use basedpyright instead of pyright.
vim.g.lazyvim_python_lsp = "pyright"
vim.g.lazyvim_python_ruff = "ruff_lsp"
