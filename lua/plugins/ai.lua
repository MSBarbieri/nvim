return {
  {
    "CopilotC-Nvim/CopilotChat.nvim",
    branch = "main",
    cmd = "CopilotChat",
    build = "make tiktoken", -- Only on MacOS or Linux
    opts = function()
      local user = vim.env.USER or "User"
      user = user:sub(1, 1):upper() .. user:sub(2)
      return {
        auto_insert_mode = true,
        question_header = "  " .. user .. " ",
        answer_header = "  Copilot ",
        window = {
          width = 0.4,
        },
        agent = "copilot",
        log_level = "error",
      }
    end,
    keys = {
      { "<c-s>", "<CR>", ft = "copilot-chat", desc = "Submit Prompt", remap = true },
      { "<leader>a", "", desc = "+ai", mode = { "n", "v" } },
      {
        "<leader>ae",
        function()
          return require("CopilotChat").toggle()
        end,
        desc = "Toggle (CopilotChat)",
        mode = { "n", "v" },
      },
      {
        "<leader>ax",
        function()
          return require("CopilotChat").reset()
        end,
        desc = "Clear (CopilotChat)",
        mode = { "n", "v" },
      },
      {
        "<leader>aq",
        function()
          vim.ui.input({
            prompt = "Quick Chat: ",
          }, function(input)
            if input ~= "" then
              require("CopilotChat").ask(input)
            end
          end)
        end,
        desc = "Quick Chat (CopilotChat)",
        mode = { "n", "v" },
      },
      {
        "<leader>ap",
        function()
          require("CopilotChat").select_prompt()
        end,
        desc = "Prompt Actions (CopilotChat)",
        mode = { "n", "v" },
      },
      {
        "<leader>aw",
        function()
          -- get cwd and file name
          local cwd = vim.fn.getcwd()
          local file_name = cwd:gsub("/", "_")
          require("CopilotChat").save(file_name)
          vim.notify("Workspace saved: " .. cwd)
        end,
        desc = "Save Workspace (CopilotChat)",
        mode = { "n", "v" },
      },
      {
        "<leader>al",
        function()
          -- get cwd and file name
          local cwd = vim.fn.getcwd()
          local file_name = cwd:gsub("/", "_")
          require("CopilotChat").load(file_name)
          vim.notify("Workspace loaded: " .. cwd)
        end,
        desc = "Load Workspace (CopilotChat)",
        mode = { "n", "v" },
      },
      {
        "<leader>ad",
        function()
          -- ask for confirmation
          vim.ui.input({
            prompt = "Delete workspace? (y/n)",
          }, function(input)
            if input == "y" then
              require("CopilotChat").stop(true)
              local cwd = vim.fn.getcwd()
              cwd = cwd:gsub("/", "_")
              require("CopilotChat").save(cwd)
            end
          end)
        end,
        desc = "Delete workspace conversation (CopilotChat)",
        mode = { "n", "v" },
      },
      {
        "<leader>am",
        function()
          -- ask for confirmation
          require("CopilotChat").select_model()
        end,
        desc = "select Model (CopilotChat)",
        mode = { "n", "v" },
      },
    },
    config = function(_, opts)
      local chat = require("CopilotChat")

      vim.api.nvim_create_autocmd("BufEnter", {
        pattern = "copilot-chat",
        callback = function()
          vim.opt_local.relativenumber = false
          vim.opt_local.number = false
        end,
      })

      chat.setup(opts)
    end,
  },
}
