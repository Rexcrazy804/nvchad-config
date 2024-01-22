---@type MappingsTable
local M = {}

M.general = {
  n = {
    [";"] = { ":", "enter command mode", opts = { nowait = true } },

    ["<leader>rr"] = {
      function()
        require("nvterm.terminal").toggle("float")
        require("nvterm.terminal").send("cargo run\n", "float")
        vim.cmd "startinsert"
      end,
     "Run rust project"
    },

     -- the 2nd argument i.e direction is optional
    ["<leader>fe"] = {":!explorer .<cr>", "Open folder in explorer"},
  },
  v = {
    [">"] = { ">gv", "indent"},
  },
}

-- more keybinds!

return M
