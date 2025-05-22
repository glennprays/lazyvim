return {
  {
    "f-person/git-blame.nvim",
    event = "VeryLazy",
    config = function()
      require("gitblame").setup({
        enabled = true,
        message_template = " <date> • <author>",
        date_format = "%r",
        virtual_text_column = 80,
      })
    end,
  },
}
