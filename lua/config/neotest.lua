local M = {}
M.defaults = {
  status = { virtual_text = true },
  output = { open_on_run = true },
  quickfix = {
    open = function()
      require("trouble").open({ mode = "quickfix", focus = false })
    end,
  },
}

function M.defaultConfig(opts)
  opts = vim.tbl_deep_extend("force", M.defaults, opts or {})

  local neotest_ns = vim.api.nvim_create_namespace("neotest")
  vim.diagnostic.config({
    virtual_text = {
      format = function(diagnostic)
        -- Replace newline and tab characters with space for more compact diagnostics
        local message = diagnostic.message:gsub("\n", " "):gsub("\t", " "):gsub("%s+", " "):gsub("^%s+", "")
        return message
      end,
    },
  }, neotest_ns)

  opts.adapters = {
    require("neotest-plenary"),
    require("neotest-jest")({
      jestCommand = "npm test --",
      env = (function()
        local envs = { CI = true }
        return envs
      end)(),
      cwd = function(_)
        return vim.fn.getcwd()
      end,
    }),
  }

  return opts
end

return M
