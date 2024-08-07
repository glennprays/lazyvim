return {
  {
    "nvimdev/dashboard-nvim",
    event = "VimEnter",
    opts = function(_, opts)
      local logo = [[ 
░██████  ░████ ░████  ░████ ░█████ ░█████   ██████
░██████  ░███  ░███    ░███  ░███  ░██████ ██████ 
░███░███ ░███  ░███    ░███  ░███  ░███░█████░███ 
░███░░███░███  ░███    ░███  ░███  ░███░░███ ░███ 
░███ ░░██████  ░░███   ███   ░███  ░███ ░░░  ░███ 
░███  ░░█████   ░░░█████░    ░███  ░███      ░███ 
█████  ░░█████    ░░███      █████ █████     █████
░░░░░    ░░░░░      ░░░      ░░░░░ ░░░░░     ░░░░░ 
      ]]
      logo = "\n\n\n\n\n\n" .. logo .. "\n\n"
      opts.config.header = vim.split(logo, "\n")
    end,
  },
}
