return {
  settings = {
    gopls = {
      -- Dejamos que golangci-lint (golangci_lint_ls) sea la única fuente de
      -- linting, para evitar diagnósticos duplicados por solapamiento con
      -- gopls (staticcheck, unusedparams, shadow).
      analyses = {
        unusedparams = false,
        shadow = false,
      },
      staticcheck = false,
      gofumpt = true,
    },
  },
}
