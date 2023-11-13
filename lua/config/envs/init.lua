local M = {}
local colmeia = require('config.envs.colmeia')
function M.load_env(env)
  local current_path = vim.fn.getcwd()
  if env.is_colmeia_path(current_path) then
    env.setup(opts)
  end
end

function M.setup()
  M.default_node_dap()
  M.load_env(colmeia)
end

function M.default_node_dap()
  local dap = require('dap')
  if not dap.adapters["pwa-node"] then
    dap.adapters["pwa-node"] = {
      type = "server",
      host = "localhost",
      port = "${port}",
      executable = {
        command = "node",
        -- 💀 Make sure to update this path to point to your installation
        args = {
          require("mason-registry").get_package("js-debug-adapter"):get_install_path()
          .. "/js-debug/src/dapDebugServer.js",
          "${port}",
        },
      },
    }
  end
  for _, language in ipairs({ "typescript", "javascript", "typescriptreact", "javascriptreact" }) do
    if dap.configurations[language] then
      table.insert(dap.configurations[language], {
        type = "pwa-node",
        request = "launch",
        name = "Launch file",
        program = "${file}",
        cwd = "${workspaceFolder}",
      })

      table.insert(dap.configurations[language], {
        type = "pwa-node",
        request = "attach",
        name = "Attach",
        processId = require("dap.utils").pick_process,
        cwd = "${workspaceFolder}",
      })
    end
  end
end

return M
