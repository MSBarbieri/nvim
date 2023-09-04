local function diagnostic_goto(next, severity)
  local go = next and vim.diagnostic.goto_next or vim.diagnostic.goto_prev
  severity = severity and vim.diagnostic.severity[severity] or nil
  return function()
    go({ severity = severity })
  end
end

local keys = {
  { "gd", vim.lsp.buf.definition,              desc = "Goto Definition", has = "definition", },
  { "gr", "<cmd>Telescope lsp_references<cr>", desc = "References" },
  { "gD", vim.lsp.buf.declaration,             desc = "Goto Declaration" },
  {
    "gI",
    function()
      require("telescope.builtin").lsp_implementations({ reuse_win = true })
    end,
    desc = "Goto Implementation",
  },
  {
    "gy",
    function()
      require("telescope.builtin").lsp_type_definitions({ reuse_win = true })
    end,
    desc = "Goto T[y]pe Definition",
  },
  { "K",     vim.lsp.buf.hover,               desc = "Hover" },
  { "gK",    vim.lsp.buf.signature_help,      desc = "Signature Help", has = "signatureHelp" },
  { "<c-k>", vim.lsp.buf.signature_help,      mode = "i",              desc = "Signature Help", has = "signatureHelp" },
  { "]d",    diagnostic_goto(true),           desc = "Next Diagnostic" },
  { "[d",    diagnostic_goto(false),          desc = "Prev Diagnostic" },
  { "]e",    diagnostic_goto(true, "ERROR"),  desc = "Next Error" },
  { "[e",    diagnostic_goto(false, "ERROR"), desc = "Prev Error" },
  { "]w",    diagnostic_goto(true, "WARN"),   desc = "Next Warning" },
  { "[w",    diagnostic_goto(false, "WARN"),  desc = "Prev Warning" },
}
if require("util").has("inc-rename.nvim") then
  keys[#keys + 1] = {
    "<leader>cr",
    function()
      local inc_rename = require("inc_rename")
      return ":" .. inc_rename.config.cmd_name .. " " .. vim.fn.expand("<cword>")
    end,
    expr = true,
    desc = "Rename",
    has = "rename",
  }
else
  keys[#keys + 1] = { "<leader>cr", vim.lsp.buf.rename, desc = "Rename", has = "rename" }
end

return keys
