return {
  {
    "folke/tokyonight.nvim",
    lazy = true,
    opts = {
      style = "night",
      on_colors = function(colors)
        colors.bg = "#0B0C13"
        colors.bg_sidebar = "#0A0B14"
      end,
    },
  },
}
