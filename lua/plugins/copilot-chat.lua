return {
  {
    "CopilotC-Nvim/CopilotChat.nvim",
    dependencies = {
      { "github/copilot.vim" }, -- or zbirenbaum/copilot.lua
      { "nvim-lua/plenary.nvim", branch = "master" }, -- for curl, log and async functions
    },
    build = "make tiktoken", -- Only on MacOS or Linux
    opts = {
      -- See Configuration section for options

      separator = "...",

      window = {
        width = 0.3,
      },
      show_folds = false,
    },

    keys = {
      { "<leader>zc", ":CopilotChat<CR>", mode = "n", desc = "Chat with Copilot" },
      { "<leader>zq", ":CopilotChatClose<CR>", mode = "n", desc = "Close Copilot Chat" },
      { "<leader>zM", ":CopilotChatModels<CR>", mode = "n", desc = "List Copilot Chat Models" },
      { "<leader>ze", ":CopilotChatExplain<CR>", mode = "v", desc = "Explain Code with Copilot Chat" },
      { "<leader>zr", ":CopilotChatReview<CR>", mode = "v", desc = "Review Code with Copilot Chat" },
      { "<leader>zR", ":CopilotChatReset<CR>", mode = "n", desc = "Reset Copilot Chat window" },
      { "<leader>zf", ":CopilotChatFix<CR>", mode = "v", desc = "Fix Code with Copilot Chat" },
      { "<leader>zo", ":CopilotChatOptimize<CR>", mode = "v", desc = "Optimize Code with Copilot Chat" },
      { "<leader>zd", ":CopilotChatDocs<CR>", mode = "v", desc = "Generate Docs with Copilot Chat" },
      { "<leader>zt", ":CopilotChatTest<CR>", mode = "v", desc = "Generate Tests with Copilot Chat" },
      { "<leader>zz", ":CopilotChatToggle<CR>", mode = "n", desc = "Toggle Copilot Chat" },
      { "<leader>zm", ":CopilotChatCommit<CR>", mode = "n", desc = "Generate Commit Message with Copilot Chat" },
      { "<leader>zS", ":CopilotChatStop<CR>", mode = "n", desc = "Stop Running Copilot Chat" },
      {
        "<leader>zs",
        ":CopilotChatCommit<CR>",
        mode = "v",
        desc = "Generate Commit Message for Selection with Copilot Chat",
      },
    },
    -- See Commands section for default commands if you want to lazy load on them
    -- config = function()
    config = function(_, opts)
      require("CopilotChat").setup(opts)
    end,
  },
}
