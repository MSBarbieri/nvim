-- bootstrap lazy.nvim, LazyVim and your plugins
require("config.lazy")
require("config.dap").setup()

require("conform").setup({
  formatters_by_ft = {
    sh = { "shfmt" },
  },
  formatters = {
    shfmt = {
      prepend_args = { "-i", "4", "-ci" },
    },
  },
})
require("mason-nvim-lint").setup({
  ensure_installed = { "shellcheck" },
})
