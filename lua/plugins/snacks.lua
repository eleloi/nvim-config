local M = {
  aicompletion_toggle = true,
  markdown_preview_toggle = false,
  tscontext_toggle = false,
}

local indent_config = {
  indent = {
    priority = 1,
    enabled = false,     -- enable indent guides
    char = "│",
    only_scope = true,   -- only show indent guides of the scope
    only_current = true, -- only show indent guides in the current window
    -- hl = "SnacksIndent", ---@type string|string[] hl groups for indent guides
    -- can be a list of hl groups to cycle through
    hl = {
      "SnacksIndent1",
      "SnacksIndent2",
      "SnacksIndent3",
      "SnacksIndent4",
      "SnacksIndent5",
      "SnacksIndent6",
      "SnacksIndent7",
      "SnacksIndent8",
    },
  },
  animate = {
    enabled = vim.fn.has("nvim-0.10") == 1,
    style = "up_down",
    easing = "linear",
    duration = {
      step = 20,   -- ms per step
      total = 300, -- maximum duration
    },
  },
  ---@class snacks.indent.Scope.Config: snacks.scope.Config
  scope = {
    enabled = true, -- enable highlighting the current scope
    priority = 200,
    char = "│",
    underline = false,    -- underline the start of the scope
    only_current = false, -- only show scope in the current window
    hl = "SnacksIndentScope", ---@type string|string[] hl group for scopes
  },
  chunk = {
    -- when enabled, scopes will be rendered as chunks, except for the
    -- top-level scope which will be rendered as a scope.
    enabled = true,
    -- only show chunk scopes in the current window
    only_current = false,
    priority = 200,
    -- hl = "SnacksIndentChunk", ---@type string|string[] hl group for chunk scopes
    hl = {
      "SnacksIndent1",
      "SnacksIndent2",
      "SnacksIndent3",
      "SnacksIndent4",
      "SnacksIndent5",
      "SnacksIndent6",
      "SnacksIndent7",
      "SnacksIndent8",
    },
    char = {
      -- corner_top = "┌",
      -- corner_bottom = "└",
      corner_top = "╭",
      corner_bottom = "╰",
      horizontal = "─",
      vertical = "│",
      arrow = ">",
    },
  },
  -- filter for buffers to enable indent guides
  filter = function(buf)
    return vim.g.snacks_indent ~= false and vim.b[buf].snacks_indent ~= false and vim.bo[buf].buftype == ""
  end,
}

M.setup = function()
  vim.pack.add({
    "https://github.com/folke/snacks.nvim",
  })

  local Snacks = require("snacks")
  Snacks.setup({
    bigfile = {
      enabled = true,
      size = 10 * 1024 * 1024, -- 10 MB
    },
    bufdelete = { enabled = true },
    quickfile = { enabled = true },
    indent = indent_config,
    notifier = { enabled = true },
    scroll = { enabled = true },
    statuscolumn = {
      enabled = true,
      left = { "mark", "sign" }, -- Combined signs (marks and diagnostics)
      right = { "fold", "git" },
      folds = {
        open = false,
        git_hl = true, -- Highlight line number with Git color
      },
    },
    toggle = { enabled = true },
  })

  M.toggle_codeium = Snacks.toggle
      .new({
        id = "codeium",
        name = "Codeium",
        which_key = true,
        notify = false,
        get = function()
          return M.aicompletion_toggle
        end,
        set = function(state)
          if state then
            M.aicompletion_toggle = true
            vim.cmd("Codeium Toggle")
          else
            M.aicompletion_toggle = false
            vim.cmd("Codeium Toggle")
          end
        end,
      })

  M.toggle_completion = Snacks.toggle
      .new({
        id = "completion",
        name = "Autocompletion",
        get = function()
          local config = require("blink.cmp.config")
          return config.completion.trigger.show_on_keyword
        end,
        set = function(state)
          local config = require("blink.cmp.config")
          config.completion.trigger.show_on_keyword = state
        end,
      })

  M.toggle_vertical_bar = Snacks.toggle.option('cursorcolumn')
  M.toggle_diagnostics = Snacks.toggle.diagnostics()
  M.toggle_inlay_hints = Snacks.toggle.inlay_hints()
  M.toggle_markdown = Snacks.toggle
      .new({
        id = "markdown",
        name = "Markdown",
        get = function()
          return M.markdown_preview_toggle
        end,
        set = function(state)
          M.markdown_preview_toggle = state
          vim.cmd("RenderMarkdown toggle")
        end,
      })
  M.toggle_treesitter_context = Snacks.toggle
      .new({
        id = "treesitter_context",
        name = "Treesitter Context",
        get = function()
          return M.tscontext_toggle
        end,
        set = function(state)
          M.tscontext_toggle = state
          vim.cmd("TSContext toggle")
        end,
      })
end

return M
