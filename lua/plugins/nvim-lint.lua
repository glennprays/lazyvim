return {
  "mfussenegger/nvim-lint",
  optional = true,
  opts = {
    linters_by_ft = {
      python = { "ruff" },
      javascript = { "eslint" },
      typescript = { "eslint" },
      typescriptreact = { "eslint" },
      javascriptreact = { "eslint" },
      shell = { "shellcheck" },
      bash = { "shellcheck" },
      zsh = { "shellcheck" },
      yaml = { "actionlint" },
      dockerfile = { "hadolint" },
      terraform = { "tflint" },
      go = { "golangci-lint" },
    },
  },
}