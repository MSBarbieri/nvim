return {
  {
    "williamboman/mason.nvim",
    cmd = {
      "Mason",
      "MasonInstall",
      "MasonUninstall",
      "MasonUninstallAll",
      "MasonLog",
      "MasonUpdate",
      "MasonUpdateAll",
    },
    opts = {
      ui = {
        icons = {
          package_installed = "✓",
          package_uninstalled = "✗",
          package_pending = "⟳",
        },
      },
      ensure_installed = {
        "js-debug-adapter",
        "bash-debug-adapter",
        "bash-language-server",
        "codelldb",
        "debugpy",
        "js-debug-adapter",
        "json-lsp",
        "lua-language-server",
        "nil",
        "node-debug2-adapter",
        "omnisharp",
        "pyright",
        "rnix-lsp",
        "rust-analyzer",
      },
      automatic_installation = true
    },
    build = ":MasonUpdate",
    config = function(_, opts)
      require("mason").setup(opts)
      local mr = require("mason-registry")
      local function ensure_installed()
        for _, tool in ipairs(opts.ensure_installed) do
          local p = mr.get_package(tool)
          if not p:is_installed() then
            p:install()
          end
        end
      end
      if mr.refresh then
        mr.refresh(ensure_installed)
      else
        ensure_installed()
      end
    end,
  },
}
