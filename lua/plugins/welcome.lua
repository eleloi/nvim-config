return {
  "goolord/alpha-nvim",
  event = "VimEnter",
  config = function()
    local alpha = require("alpha")
    local dashboard = require("alpha.themes.dashboard")
    local logo = {
      [[ ███████████████████████████ ]],
      [[ ███████▀▀▀░░░░░░░▀▀▀███████ ]],
      [[ ████▀░░░░░░░░░░░░░░░░░▀████ ]],
      [[ ███│░░░░░░░░░░░░░░░░░░░│███ ]],
      [[ ██▌│░░░░░░░░░░░░░░░░░░░│▐██ ]],
      [[ ██░└┐░░░░░░░░░░░░░░░░░┌┘░██ ]],
      [[ ██░░└┐░░░░░░░░░░░░░░░┌┘░░██ ]],
      [[ ██░░┌┘▄▄▄▄▄░░░░░▄▄▄▄▄└┐░░██ ]],
      [[ ██▌░│██████▌░░░▐██████│░▐██ ]],
      [[ ███░│▐███▀▀░░▄░░▀▀███▌│░███ ]],
      [[ ██▀─┘░░░░░░░▐█▌░░░░░░░└─▀██ ]],
      [[ ██▄░░░▄▄▄▓░░▀█▀░░▓▄▄▄░░░▄██ ]],
      [[ ████▄─┘██▌░░░░░░░▐██└─▄████ ]],
      [[ █████░░▐█─┬┬┬┬┬┬┬─█▌░░█████ ]],
      [[ ████▌░░░▀┬┼┼┼┼┼┼┼┬▀░░░▐████ ]],
      [[ █████▄░░░└┴┴┴┴┴┴┴┘░░░▄█████ ]],
      [[ ███████▄░░░░░░░░░░░▄███████ ]],
      [[ ██████████▄▄▄▄▄▄▄██████████ ]],
    }
    dashboard.section.header.val = logo
    dashboard.section.header.opts.hl = "String"
    dashboard.section.buttons.val = {}
    alpha.setup(dashboard.opts)
  end,
}
