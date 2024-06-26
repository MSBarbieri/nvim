local utils = require('util')
local M = {}

M.setup = function()
  local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"

  -- clone lazyvim if not finded
  if not vim.loop.fs_stat(lazypath) then
    vim.fn.system({
      "git",
      "clone",
      "--filter=blob:none",
      "https://github.com/folke/lazy.nvim.git",
      "--branch=stable",
      lazypath,
    })
  end

  vim.opt.rtp:prepend(vim.env.LAZY or lazypath)

  utils.lazy_notify()

  require("lazy").setup({
    spec = {
      { import = "plugins" },
    },
    defaults = {
      lazy = false,
      version = false,
    },
    checker = { enabled = true },
    performance = {
      rtp = {
        disabled_plugins = {
          "gzip",
          "tarPlugin",
          "tohtml",
          "tutor",
          "zipPlugin",
        },
      },
    },
  })
end

return M
