local function find_project_root(start)
  return vim.fs.root(start or 0, { 'package.json', 'node_modules' })
end
local project_root = find_project_root()
local vls_bin = project_root .. '/node_modules/.bin/vue-language-server'

return {
  cmd = { vls_bin, '--stdio' },
}
