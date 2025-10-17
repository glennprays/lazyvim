-- return {
--
--   { "williamboman/mason.nvim", "williamboman/mason-lspconfig.nvim", "neovim/nvim-lspconfig" },
-- }
return {
  {
    "mason.nvim",
    opts = { ensure_installed = { "hadolint" } },
  },
}
