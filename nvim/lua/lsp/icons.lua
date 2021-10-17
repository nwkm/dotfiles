local M = {}

M.map = {
  Text           = ' (Text)',
  Method         = ' (Method)',
  Function       = ' (Function)',
  Ctor           = ' (Constructor)',
  Field          = ' (Field)',
  Variable       = '襁(Variable)',
  Class          = ' (Class)',
  Interface      = ' (Interface)',
  Module         = ' (Module)',
  Property       = ' (Property)',
  Unit           = ' (Unit)',
  Value          = ' (value)',
  Enum           = '練(enum)',
  Keyword        = ' (Keyword)',
  Snippet        = ' (Snippet)',
  Color          = ' (color)',
  File           = ' (file)',
  Reference      = ' (ref)',
  Folder         = ' (folder)',
  EnumMember     = ' (EnumMember)',
  Constant       = ' (Constant)',
  Struct         = ' (struct)',
  Event          = ' (event)',
  Operator       = ' (Operator)',
  TypeParameter  = ' (type param)',
}

for kind, symbol in pairs(M.map) do
  local kinds = vim.lsp.protocol.CompletionItemKind
  local index = kinds[kind]

  if index ~= nil then
      kinds[index] = symbol
  end
end

vim.fn.sign_define("LspDiagnosticsSignError", {
  -- text = "",
  --text = "",
  text = "✘",
  texthl = "LspDiagnosticsSignError",
  linehl = "",
  numhl = "",
})

vim.fn.sign_define("LspDiagnosticsSignWarning", {
  -- text = "",
  text = "",
  texthl = "LspDiagnosticsSignWarning",
  linehl = "",
  numhl = "",
})

vim.fn.sign_define("LspDiagnosticsSignInformation", {
  text = "",
  -- text = "",
  --text = "",
  texthl = "LspDiagnosticsSignInformation",
  linehl = "",
  numhl = "",
})

vim.fn.sign_define("LspDiagnosticsSignHint", {
  -- text = "",
  text = "",
  -- text  = "",
  --text  = "",
  texthl = "LspDiagnosticsSignHint",
  linehl = "",
  numhl = "",
})

return M
