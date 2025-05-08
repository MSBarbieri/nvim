-- Autocmds are automatically loaded on the VeryLazy event
-- Default autocmds that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/autocmds.lua
-- Add any additional autocmds here

vim.api.nvim_create_autocmd({ "BufWinLeave" }, {
  pattern = "copilot-chat",
  callback = function(event)
    local cwd = vim.fn.getcwd()
    cwd = cwd:gsub("/", "_")
    require("CopilotChat").save(cwd)
  end,
})

vim.api.nvim_create_autocmd("BufWinEnter", {
  pattern = "copilot-chat",
  callback = function()
    local cwd = vim.fn.getcwd()
    cwd = cwd:gsub("/", "_")
    require("CopilotChat").load(cwd)
  end,
})
