if vim.b.did_ftplugin_go then
  return
end
vim.b.did_ftplugin_go = 1

vim.cmd("packadd nvim-lspconfig")

vim.lsp.enable("gopls")
vim.lsp.enable("golangci_lint_ls")

vim.api.nvim_create_autocmd("BufWritePre", {
  pattern = "*.go",
  desc = "Organize imports (same functionality as goimports but using lsp)",
  callback = function(args)
    -- 1. Check for gopls
    local clients = vim.lsp.get_clients({ bufnr = args.buf, name = "gopls" })
    if #clients == 0 then
      return
    end
    local client = clients[1]

    local params = vim.lsp.util.make_range_params(0, client.offset_encoding)
    params.context = { only = { "source.organizeImports" } }

    local result = vim.lsp.buf_request_sync(args.buf, "textDocument/codeAction", params, 1000)

    for cid, res in pairs(result or {}) do
      for _, r in pairs(res.result or {}) do
        if r.edit then
          local c = vim.lsp.get_client_by_id(cid)
          local enc = (c and c.offset_encoding) or "utf-16"
          vim.lsp.util.apply_workspace_edit(r.edit, enc)
        end
      end
    end
  end,
})
