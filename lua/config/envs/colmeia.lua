local M = {}

function M.setup(opts)
  print("Colmeia environment loaded")
  vim.notify("Colmeia environment loaded", vim.log.levels.INFO, {
    title = "Colmeia",
  })
  M.load_dap(opts)
end

function M.load_dap(_)
  local dap = require('dap')

  table.insert(dap.configurations.typescript, {
    type = 'node2',
    request = 'launch',
    name = 'Colmeia Server',
    program = function()
      local colmeia_path = os.getenv("HOME") .. "/dev/colmeia/"
      local file = colmeia_path .. "dist/server/src/start.js"
      print("file: ", file)
      return file
    end,
    args = function()
      return coroutine.create(function(dap_run_co)
        vim.ui.select({ 'server', 'bot', 'ms-consumer', 'scheduler' }, {
          prompt = 'Select your service:',
        }, function(service)
          coroutine.resume(dap_run_co, { "--service=" .. service })
        end)
      end)
    end,
    sourceMaps = true,
    protocol = 'inspector',
    console = 'integratedTerminal',
    cwd = vim.fn.getcwd(),
  })

  local function get_test_files()
    return coroutine.create(function(dap_run_co)
      local items = vim.fn.globpath(vim.fn.getcwd(), 'dist/**/__tests__/**/*.js', 0, 1)
      local opts = {
        format_item = function(path)
          return vim.fn.fnamemodify(path, ':t')
        end,
      }
      local function cont(choice)
        if choice == nil then
          return nil
        else
          coroutine.resume(dap_run_co, choice)
        end
      end

      vim.ui.select(items, opts, cont)
    end)
  end
  table.insert(dap.configurations.typescript, {
    type = 'node2',
    request = 'launch',
    name = 'Colmeia script',
    program = get_test_files,
    sourceMaps = true,
    protocol = 'inspector',
    console = 'integratedTerminal',
    cwd = vim.fn.getcwd(),
  })

  table.insert(dap.configurations.typescript, {
    type = 'node2',
    request = 'attach',
    name = 'nodemon port:5858',
    sourceMaps = true,
    outfiles = {},
    restart = true,
    port = 5858,
    cwd = vim.fn.getcwd(),
  })
end

return M
