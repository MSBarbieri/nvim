return function(map)
  map("n", "<leader>f$", "<cmd>Lazy<cr>", { desc = "Lazy" })
  map("n", "<leader>fm", "<cmd>Mason<cr>", { desc = "Mason" })
  map("n", "<leader>fa", "<cmd>Telescope find_files<cr>", { desc = "Find Files" })
  map("n", "<space>fe", "<cmd>Telescope live_grep<cr>", { desc = "Live Grep" })
  map("n", "<space>e", "<cmd>Neotree toggle<cr>", { desc = "Neotree toggle" })

  map({ "n", "v" }, "<leader>f,", "<cmd>TodoTelescope<cr>", { desc = "Find Todos" })
  map({ "n", "v" }, "<leader>f.", "<cmd>Telescope diagnostics<cr>", { desc = "Find Diagnostics" })
end
