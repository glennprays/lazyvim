return {
  {
    "nvim-pack/nvim-spectre",
    event = "VeryLazy",
    config = function()
      require("spectre").setup({
        live_update = true,
        mapping = {
          ["toggle_line"] = {
            map = "t",
            cmd = "<cmd>lua require('spectre').toggle_line()<CR>",
            desc = "toggle current item",
          },
          ["replace_cmd"] = {
            map = "<leader>R",
            cmd = "<cmd>lua require('spectre.actions').replace_cmd()<CR>",
            desc = "replace command",
          },
        },
      })
    end,
  },
}
