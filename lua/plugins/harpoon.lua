local keys = {}
local binds = 9

for i = 1, binds do
  table.insert(keys, {
    string.format("<leader>%s", i),
    function()
      local harpoon = require("harpoon")
      harpoon:list():select(i)
    end,
  })
end

table.insert(keys, {
  "<leader>ss",
  function()
    local harpoon = require("harpoon")
    harpoon.ui:toggle_quick_menu(harpoon:list())
  end,
  desc = "Harpoon List",
  mode = "n",
})

table.insert(keys, {
  "<leader>sa",
  function()
    local harpoon = require("harpoon")
    harpoon:list():add()
  end,
  desc = "Harpoon List",
  mode = "n",
})

return {
  "ThePrimeagen/harpoon",
  branch = "harpoon2",
  dependencies = { "nvim-lua/plenary.nvim" },
  keys = keys,
  config = true,
}
