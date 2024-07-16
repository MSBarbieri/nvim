-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here

local builtin = require("telescope.builtin")
vim.keymap.set("n", "<leader>sa", builtin.find_files)
vim.keymap.set("n", "<leader>so", function()
  builtin.find_files({ hidden = true })
end, { desc = "git files" })
vim.keymap.set("n", "<leader>se", builtin.live_grep, { desc = "live_grep" })
