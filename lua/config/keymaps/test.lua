return function(map)
  map("n", "<leader>tl", function() require("neotest").run.run_last() end, { desc = "Run last test" })
  map("n", "<leader>tt", function() require("neotest").run.run(vim.fn.expand("%")) end, { desc = "Run File" })
  map("n", "<leader>tT", function() require("neotest").run.run(vim.loop.cwd()) end, { desc = "Run All Test Files" })
  map("n", "<leader>tr", function() require("neotest").run.run() end, { desc = "Run Nearest" })
  map("n", "<leader>ts", function() require("neotest").summary.toggle() end, { desc = "Toggle Summary" })
  map("n", "<leader>to", function() require("neotest").output.open({ enter = true, auto_close = true }) end,
    { desc = "Show Output" })
  map("n", "<leader>tO", function() require("neotest").output_panel.toggle() end, { desc = "Toggle Output Panel" })
  map("n", "<leader>tS", function() require("neotest").run.stop() end, { desc = "Stop" })
end
