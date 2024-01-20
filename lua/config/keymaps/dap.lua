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

return function(hydra)
  hydra({
    name = "Dap",
    hint = [[
                  Dap
----------------------
 _t_: Toggle Breakpoint
 _c_:          Continue
 _i_:         Step Into
 _o_:         Step Over
 _u_:          Step Out
 _s_:         Toggle UI
 _r_:     Run with Args
----------------------
 _<Esc>_ | _q_:      exit
    ]],
    config = {
      color = 'teal',
      invoke_on_body = true,
      timeout = true,
      hint = {
        type = "window",
        position = "bottom-right",
        border = "rounded",
      },
    },
    mode = { 'n', 'x' },
    body = '<leader>d',
    heads = {
      { "t", require("dap").toggle_breakpoint, { desc = "Toggle breakpoint" } },
      { "c", require("dap").continue,          { desc = "Start/Continue" } },
      { "i", require("dap").step_into,         { desc = "Step Into" } },
      { "o", require("dap").step_over,         { desc = "Step Over" } },
      { "u", require("dap").step_out,          { desc = "Step Out" } },
      { "s", function()
        require("dapui").toggle()
      end, { desc = "Toggle Debugger UI" } },
      { "r",     function() require("dap").continue({ before = get_args }) end, { desc = "Run with Args" } },
      { 'q',     nil,                                                           { desc = 'exit' } },
      { '<Esc>', nil,                                                           { desc = 'exit' } },
    }
  })
end
