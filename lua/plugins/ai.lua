vim.pack.add({
    "https://github.com/Exafunction/windsurf.nvim",
    "https://github.com/nvim-lua/plenary.nvim", -- dependency
})

require("codeium").setup({
    -- Optionally disable cmp source if using virtual text only
    enable_cmp_source = false,
    quiet = true,
    -- Disable chat: we don't use the :Codeium Chat web UI. This stops the
    -- binary from spawning a local web server and a browser client process,
    -- which are a notable source of child-process churn.
    enable_chat = false,
    -- Disable local semantic search: the codeium.nvim client never invokes
    -- it (only Windsurf IDE / Cascade do). Removes a non-trivial chunk of
    -- the binary's runtime surface.
    enable_local_search = false,
    virtual_text = {
        enabled = true,
        -- These are the defaults
        -- Set to true if you never want completions to be shown automatically.
        manual = false,
        idle_delay = 300,
        map_keys = true,
        -- The key to press when hitting the accept keybinding but no completion is showing.
        -- Defaults to \t normally or <c-n> when a popup is showing.
        accept_fallback = nil,
        -- Key bindings for managing completions in virtual text mode.
        key_bindings = {
            -- Accept the current completion.
            accept = "<M-l>",
            -- Accept the next word.
            accept_word = "<M-;>",
            -- Accept the next line.
            accept_line = false,
            -- Clear the virtual text.
            clear = false,
            -- Cycle to the next completion.
            next = "<M-j>",
            -- Cycle to the previous completion.
            prev = "<M-k>",
        },
    },
})

-- ────────────────────────────────────────────────────────────────────────────
-- Patch: silence plenary.curl "Empty reply from server" Lua errors from
-- Codeium's language server child process.
--
-- Root cause: codeium.io.post (lua/codeium/io.lua) calls plenary.curl.post
-- without setting `on_error`. When curl exits non-zero (e.g. exit 52 when
-- the child gRPC process dies mid-request), plenary.curl falls through to
-- `error(message)`, raising an uncaught Lua error BEFORE codeium's own
-- `quiet = true` guard in api.lua:401 can silence it.
--
-- Workaround: inject an on_error handler that funnels curl-level failures
-- back into codeium's normal err-callback path, so the quiet guard works.
-- Tracked upstream; remove this block once Exafunction ships the fix.
-- ────────────────────────────────────────────────────────────────────────────
vim.schedule(function()
  local codeium_io = require("codeium.io")
  if codeium_io._patched_empty_reply then
    return
  end

  local orig_post = codeium_io.post
  codeium_io.post = function(url, params)
    params = params or {}
    -- Capture the user callback BEFORE M.post replaces params.callback
    -- with its own wrapper (which would crash on `out.exit` if we passed
    -- `out = nil` to it).
    local user_callback = params.callback
    params.on_error = params.on_error or function(err)
      if user_callback then
        -- Defer to the main loop: plenary.curl invokes on_error in a libuv
        -- (fast event) context, where codeium's user_callback can call
        -- vim.fn.json_encode via CancelRequest -> io.post, which raises
        -- E5560. vim.schedule() moves the call back to the main loop.
        vim.schedule(function()
          user_callback(nil, {
            code = err.exit or -1,
            err = err.message or "curl failed",
            status = 503, -- treat as transient so api.lua:401 quiet guard triggers
            response = { body = err.message or "" },
            out = err.message or "",
          })
        end)
      end
    end
    return orig_post(url, params)
  end
  codeium_io._patched_empty_reply = true
end)

-- ────────────────────────────────────────────────────────────────────────────
-- Patch: silence the "heartbeat failed" warning spam.
--
-- With the on_error patch above, the heartbeat callback in api.lua:342 now
-- actually runs (it didn't before — the curl error short-circuited), and it
-- legitimately calls `notify.warn("heartbeat failed", err)` every ~5s while
-- the language server child is flaky. These are info-level status messages
-- that show as `<W> heartbeat failed` in the message area.
--
-- The health state (self.last_heartbeat_error) is still tracked internally,
-- so `:Codeium` health checks keep working. We just drop the user-visible
-- notification.
-- ────────────────────────────────────────────────────────────────────────────
vim.schedule(function()
  local codeium_notify = require("codeium.notify")
  if codeium_notify._patched_heartbeat then
    return
  end

  local orig_warn = codeium_notify.warn
  codeium_notify.warn = function(message, ...)
    if message == "heartbeat failed" then
      return
    end
    return orig_warn(message, ...)
  end
  codeium_notify._patched_heartbeat = true
end)
