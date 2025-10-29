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
      prompts = {
        CommitAll = {
          system_prompt = "You are a highly detail-oriented and experienced Senior Staff Engineer. Your task is to generate a pristine commit message.",
          prompt = "Based on the provided git diffs, generate a single commit message following the **Commitizen convention** (type(scope): subject). \n\n**CRITICAL GUIDELINES:**\n1. The commit type must be one of: feat, fix, docs, style, refactor, perf, test, build, ci, chore, revert.\n2. **Title (Subject) must not exceed 50 characters.**\n3. **Body lines must be wrapped up to 72 characters.**\n4. **No introductory text, explanations, or extraneous commentary.**\n5. Format the final output *only* as a single gitcommit code block.\n\n*This message is for a real codebase, treat it with professional rigor.*",
          sticky = "#gitdiff:unstaged #gitdiff:staged",
        },
        ExplainChanged = {
          system_prompt = [[
You are a senior staff engineer focused on clear, practical explanations.
When explaining code:
- Provide concise high-level overview first
- Highlight non-obvious implementation details
- Identify patterns and programming principles
- Address any existing diagnostics or warnings
- Focus on complex parts rather than basic syntax
- Use short paragraphs with clear structure
- Mention performance considerations where relevant
          ]],
          prompt = "Explain the change in the code in detail.",
          sticky = "#gitdiff:unstaged #gitdiff:staged",
        },
        ReviewChanged = {
          prompt = "Review the changed code.",
          system_prompt = [[
You are a senior staff engineer doing code reviewer focused on improving code quality and maintainability.

Format each issue you find precisely as:
line=<line_number>: <issue_description>
OR
line=<start_line>-<end_line>: <issue_description>

Check for:
- Unclear or non-conventional naming
- Comment quality (missing or unnecessary)
- Complex expressions needing simplification
- Deep nesting or complex control flow
- Inconsistent style or formatting
- Code duplication or redundancy
- Potential performance issues
- Error handling gaps
- Security concerns
- Breaking of SOLID principles

Multiple issues on one line should be separated by semicolons.
End with: "**`To clear buffer highlights, please ask a different question.`**"

If no issues found, confirm the code is well-written and explain why.
]],
          sticky = "#gitdiff:unstaged #gitdiff:staged",
          callback = function(response, source)
            local diagnostics = {}
            for line in response.content:gmatch("[^\r\n]+") do
              if line:find("^line=") then
                local start_line = nil
                local end_line = nil
                local message = nil
                local single_match, message_match = line:match("^line=(%d+): (.*)$")
                if not single_match then
                  local start_match, end_match, m_message_match = line:match("^line=(%d+)-(%d+): (.*)$")
                  if start_match and end_match then
                    start_line = tonumber(start_match)
                    end_line = tonumber(end_match)
                    message = m_message_match
                  end
                else
                  start_line = tonumber(single_match)
                  end_line = start_line
                  message = message_match
                end

                if start_line and end_line then
                  table.insert(diagnostics, {
                    lnum = start_line - 1,
                    end_lnum = end_line - 1,
                    col = 0,
                    message = message,
                    severity = vim.diagnostic.severity.WARN,
                    source = "Copilot Review",
                  })
                end
              end
            end
            vim.diagnostic.set(vim.api.nvim_create_namespace("copilot-chat-diagnostics"), source.bufnr, diagnostics)
          end,
        },
      },

      separator = "...",
      model = "claude-sonnet-4.5",

      window = {
        width = 45,
        zindex = 100,
      },
      show_folds = false,
      mappings = {
        -- Remap or disable the 'reset' shortcut (defaults to <C-l>)
        reset = {
          normal = "", -- set to empty to disable
          insert = "",
          -- or alternatively remap: normal = '<C-r>', insert = '<C-r>',
        },
      },
    },

    keys = {
      { "<leader>zc", ":CopilotChatExplainChanged<CR>", mode = "n", desc = "Explain Code Changed with Copilot Chat" },
      { "<leader>zp", ":CopilotChatReviewChanged<CR>", mode = "n", desc = "Review Code Changed with Copilot Chat" },
      {
        "<leader>zm",
        ":CopilotChatCommitAll<CR>",
        mode = "n",
        desc = "Generate Commit Message for unstaged and staged changes with Copilot Chat",
      },
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
