local function find_project_root(start)
  return vim.fs.root(start or 0, { 'package.json', 'node_modules' })
end

local project_root = find_project_root()
local vtsls_bin = project_root .. '/node_modules/.bin/vtsls'
local vue_plugin_dir = project_root .. '/node_modules/@vue/typescript-plugin'

return {
  cmd = { vtsls_bin, '--stdio' },
  filetypes = { 'typescript', 'javascript', 'javascriptreact', 'typescriptreact', 'vue' },
  settings = {
    vtsls = {
      tsserver = {
        globalPlugins = {
          {
            name = '@vue/typescript-plugin',
            location = vue_plugin_dir,
            languages = { 'vue' },
            configNamespace = 'typescript',
          },
        },
      },
    },
  },
}
