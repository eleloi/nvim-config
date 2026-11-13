local M = {}

-- La clave de MiniMax puede venir de:
--   1. La variable de entorno MINIMAX_API_KEY.
--   2. El secreto que sops-nix deja descifrado en ~/.config/sops-nix/secrets.
local function minimax_api_key()
  local from_env = vim.env.MINIMAX_API_KEY
  if from_env and from_env ~= "" then
    return from_env
  end

  local path = vim.fs.joinpath(
    vim.fn.expand "~",
    ".config",
    "sops-nix",
    "secrets",
    "MINIMAX_API_KEY"
  )
  local ok, lines = pcall(vim.fn.readfile, path)
  if ok and lines and lines[1] and lines[1] ~= "" then
    return (lines[1]:gsub("%s+$", ""))
  end
end

-- Filetypes donde no queremos sugerencias automáticas.
local ignored_fts = {
  help = true,
  gitcommit = true,
  gitrebase = true,
  qf = true,
  oil = true,
  fzf = true,
  fzf_lua = true,
  TelescopePrompt = true,
  minuet = true,
  checkhealth = true,
}

local function sync_auto_trigger(buf)
  local ft = vim.bo[buf].filetype
  vim.b[buf].minuet_virtual_text_auto_trigger = not ignored_fts[ft]
end

M.setup = function()
  vim.pack.add({
    "https://github.com/milanglacier/minuet-ai.nvim"
  })

  require("minuet").setup({
    provider = "openai_compatible",
    -- Una sola sugerencia por request: suficiente para autocompletar y barato.
    n_completions = 1,
    -- M3.1-Flash piensa antes de responder, por eso necesita más margen.
    request_timeout = 15,
    throttle = 2000,
    debounce = 300,
    context_window = 16000,
    -- El provider de blink solo se dispara manualmente (ver lua/plugins/completion.lua).
    blink = {
      enable_auto_complete = false,
    },
    -- No sugerimos en buffers que no son código (terminal, qf, oil, ...).
    enable_predicates = {
      function()
        return vim.bo.buftype == ""
      end,
    },
    provider_options = {
      openai_compatible = {
        -- Minuet acepta el nombre de una variable de entorno o una función que
        -- devuelva la clave, así que no hace falta exportarla globalmente.
        api_key = minimax_api_key,
        end_point = "https://api.minimax.io/v1/chat/completions",
        model = "MiniMax-M3.1-Flash",
        name = "MiniMax",
        stream = true,
        optional = {
          max_tokens = 1024,
          temperature = 0.2,
          -- M3.1-Flash exige "thinking", pero sin acotarlo el razonamiento se
          -- come todo el presupuesto y la respuesta llega vacía.
          reasoning_effort = "low",
        },
      },
    },
    -- Frontend de texto virtual: es el equivalente a las sugerencias inline
    -- de neocodeium (mismo estilo de teclas para aceptar/descartar).
    virtualtext = {
      auto_trigger_ft = { "*" },
      -- Mostrar la sugerencia aunque el menú de blink.cmp esté abierto.
      show_on_completion_menu = true,
      auto_trigger_ignore_ft = vim.tbl_keys(ignored_fts),
      keymap = {
        accept = "<M-;>", -- aceptar la sugerencia completa
        accept_line = "<M-l>", -- aceptar una línea
        dismiss = "<M-c>", -- descartar la sugerencia
        next = "<M-n>", -- siguiente sugerencia
        prev = "<M-p>", -- sugerencia anterior
      },
    },
  })

  -- Neovim abre el fichero indicado en la línea de comandos antes de que
  -- termine el init, así que el evento FileType ya ha pasado cuando minuet
  -- registra su autocmd. Lo sincronizamos a mano para no perder el disparo
  -- automático en el primer buffer.
  vim.api.nvim_create_autocmd("FileType", {
    pattern = "*",
    callback = function(args)
      sync_auto_trigger(args.buf)
    end,
    desc = "minuet: sincroniza el disparo automático de texto virtual",
  })
  sync_auto_trigger(vim.api.nvim_get_current_buf())
end

return M
