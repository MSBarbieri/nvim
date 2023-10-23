local function get_args(config)
  local args = type(config.args) == "function" and (config.args() or {}) or config.args or {}
  config = vim.deepcopy(config)
  ---@cast args string[]
  config.args = function()
    local new_args = vim.fn.input("Run with args: ", table.concat(args, " ")) --[[@as string]]
    return vim.split(vim.fn.expand(new_args) --[[@as string]], " ")
  end
  return config
end
return function(map)
  map("n", "<leader>dt", require("dap").toggle_breakpoint, { desc = "Toggle breakpoint" })
  map("n", "<leader>dc", require("dap").continue, { desc = "Start/Continue" })
  map("n", "<leader>di", require("dap").step_into, { desc = "Step Into" })
  map("n", "<leader>do", require("dap").step_over, { desc = "Step Over" })
  map("n", "<leader>du", require("dap").step_out, { desc = "Step Out" })
  map("n", "<leader>ds", function()
    require("dapui").toggle()
  end, { desc = "Toggle Debugger UI" })
  map("n", "<leader>da", function() require("dap").continue({ before = get_args }) end, { desc = "Run with Args" })
  map("n", "<leader>td", function() require("neotest").run.run({ strategy = "dap" }) end, { desc = "Debug Nearest" })
end
