return function(map)
  map({ "n", "v" }, "<leader>c,", function()
    require("plugins.lsp.format").format(nil)
  end, { desc = "Format Document" })

  map("n", "<leader>c.", function()
    local config = vim.diagnostic.config()
    config.scope = "line"
    vim.diagnostic.open_float(config)
  end, { desc = "Line Diagnostics" })

  map({ "n", "v" }, "<leader>ca", vim.lsp.buf.code_action, { desc = "Code Action" })
  map({ "n", "v" }, "<leader>cc", vim.lsp.buf.signature_help, { desc = "Signature Help" })
  map({ "n", "v" }, "<leader>ce", vim.diagnostic.setloclist, { desc = "Quickfix" })
  map({ "n", "v" }, "<leader>ch", vim.diagnostic.goto_prev, { desc = "Prev Diagnostics" })
  map({ "n", "v" }, "<leader>cl", vim.diagnostic.goto_next, { desc = "Next Diagnostics" })
  map({ "n", "v" }, "<leader>cu", "<cmd>TodoTelescope<cr>", { desc = "Todo" })
  map({ "n", "v" }, "<leader>ct", "<cmd>Telescope diagnostics<cr>", { desc = "Diagnostics" })

  map("n", "<leader>c/", function()
    local lang = vim.bo.filetype
    vim.api.nvim_command(":CheatWithoutComments " .. lang)
  end, { desc = "cheat.sh" })

  map({ "n", "v" }, "<leader>cd", vim.diagnostic.open_float, { desc = "Line Diagnostics" })
  map({ "n", "v" }, "<leader>c$", "<cmd>LspInfo<cr>", { desc = "Lsp Info" })
  map({ "n", "v" }, "<leader>cA", function()
    vim.lsp.buf.code_action({
      context = {
        only = {
          "source",
        },
        diagnostics = {},
      },
    })
  end, {
    desc = "Source Action",
  })

  map("n", "<leader>z", function()
    require("zen-mode").toggle({
      window = {
        width = 0.85, -- width will be 85% of the editor width
      },
    })
  end, { silent = true, nowait = true, desc = "Zoom Window" })
end
