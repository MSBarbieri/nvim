return function(map)
  map("n", "<leader>t$", "<cmd>Lazy<cr>", { desc = "Lazy" })
  map("n", "<leader>tm", "<cmd>Mason<cr>", { desc = "Mason" })
  map("n", "<leader>ta", "<cmd>Telescope find_files<cr>", { desc = "Find Files" })
  map("n", "<space>te", "<cmd>Telescope live_grep<cr>", { desc = "Live Grep" })

  map({ "n", "v" }, "<leader>tt", "<cmd>TodoTelescope<cr>", { desc = "Find Todos" })
  map({ "n", "v" }, "<leader>td", "<cmd>Telescope diagnostics<cr>", { desc = "Find Diagnostics" })
end
