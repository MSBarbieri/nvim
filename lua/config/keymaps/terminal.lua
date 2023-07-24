local Util = require("util")
return function(map)
  if vim.fn.executable("node") == 1 then
    map("n", "<leader>tn", function()
      Util.toggle_term_cmd("node")
    end, { desc = "ToggleTerm node" })
  end
  if vim.fn.executable("gdu") == 1 then
    map("n", "<leader>tu", function()
      Util.toggle_term_cmd("gdu")
    end, { desc = "ToggleTerm gdu" })
  end
  if vim.fn.executable("btm") == 1 then
    map("n", "<leader>tt", function()
      Util.toggle_term_cmd("btm")
    end, { desc = "ToggleTerm btm" })
  end
  local python = vim.fn.executable("python") == 1 and "python" or vim.fn.executable("python3") == 1 and "python3"
  if python then
    map("n", "<leader>tp", function()
      Util.toggle_term_cmd(python)
    end, { desc = "ToggleTerm python" })
  end
  map("n", "<leader>ts", function()
    Util.toggle_term_cmd("tmux-sessionizer")
  end, { desc = "tmux-sessionizer" })
  map("n", "<leader>tf", "<cmd>ToggleTerm direction=float<cr>", { desc = "ToggleTerm float" })
  map("n", "<leader>th", "<cmd>ToggleTerm size=10 direction=horizontal<cr>", { desc = "ToggleTerm horizontal split" })
  map("n", "<leader>tv", "<cmd>ToggleTerm size=80 direction=vertical<cr>", { desc = "ToggleTerm vertical split" })
  map("n", "<F7>", "<cmd>ToggleTerm<cr>", { desc = "Toggle terminal" })
end
