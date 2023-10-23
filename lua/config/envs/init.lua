function load_env(name, env)
  local current_path = vim.fn.getcwd()
  local env = os.getenv(env)
  if string.find(current_path, env) then
    require("config.envs." .. name).setup()
  end
end

load_env("colmeia", "COLMEIA_PATH")

local dap = require('dap')
if not dap.adapters["pwa-node"] then
  require("dap").adapters["pwa-node"] = {
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
  if not dap.configurations[language] then
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
