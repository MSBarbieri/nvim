return {
  {
    "linux-cultist/venv-selector.nvim",
    opts = {
      settings = {
        options = {
          notify_user_on_venv_activation = false,
        },
      },
    },
  },
  {
    "folke/zen-mode.nvim",
    opts = {},
  },
  {
    "karloskar/poetry-nvim",
    config = function()
      require("poetry-nvim").setup()
    end,
  },
  {
    "rshkarin/mason-nvim-lint",
  },
}
