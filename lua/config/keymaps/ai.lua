-- create lazygit keymaps

-- neogit
vim.keymap.set("n", "<leader>gg", function()
  require("neogit").open({ kind = "tab" })
end, { desc = "Open Neogit in a new tab" })
