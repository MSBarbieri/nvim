return {
  {
    'nvim-neotest/neotest',
    tag = "v3.4.7",
    dependencies = {
      { "nvim-neotest/neotest-plenary" },
      {

        'haydenmeade/neotest-jest',
        commit = "1a24852",
      }
    },
    opts = {
      status = { virtual_text = true },
      output = { open_on_run = false },
    },
    config = function(_, opts)
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

      if require("util").has("trouble.nvim") then
        opts.consumers = opts.consumers or {}
        -- Refresh and auto close trouble after running tests
        ---@type neotest.Consumer
        opts.consumers.trouble = function(client)
          client.listeners.results = function(adapter_id, results, partial)
            if partial then
              return
            end
            local tree = assert(client:get_position(nil, { adapter = adapter_id }))

            local failed = 0
            for pos_id, result in pairs(results) do
              if result.status == "failed" and tree:get_key(pos_id) then
                failed = failed + 1
              end
            end
            vim.schedule(function()
              local trouble = require("trouble")
              if trouble.is_open() then
                trouble.refresh()
                if failed == 0 then
                  trouble.close()
                end
              end
            end)
            return {}
          end
        end
      end

      opts.adapters = {
        require("neotest-plenary"),
        require('neotest-jest')({
          jestCommand = "npm test --",
          jestConfigFile = "jest.config.ts",
          env = (function()
            local envs = { CI = true }
            local colmeia = require('config.envs.colmeia')
            if colmeia.is_colmeia_path(vim.fn.getcwd()) then
              envs.CORE_ENV_PATH = colmeia.get_colmeia_path() .. "envs/dev"
            end
            return envs
          end)(),
          cwd = function(_)
            return vim.fn.getcwd()
          end,
        }),
      }
      if opts.adapters then
        adapters = {}
        if type(opts.adapters) == "function" then
          opts.adapters = opts.adapters()
        end
        for name, config in pairs(opts.adapters or {}) do
          if type(name) == "number" then
            if type(config) == "string" then
              config = require(config)
            end
            adapters[#adapters + 1] = config
          elseif config ~= false then
            local adapter = require(name)
            if type(config) == "table" and not vim.tbl_isempty(config) then
              local meta = getmetatable(adapter)
              if adapter.setup then
                adapter.setup(config)
              elseif meta and meta.__call then
                adapter(config)
              else
                error("Adapter " .. name .. " does not support setup")
              end
            end
            adapters[#adapters + 1] = adapter
          end
        end
        opts.adapters = adapters
      end

      require("neotest").setup(opts)
    end,
  }
}
