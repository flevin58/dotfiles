return {
  cmd = { "clangd" },
  root_markers = { ".git", ".clangd", "compile_commands.json" },
  filetypes = { "c", "cpp", "h", "hpp" },
  capabilities = {
    documentFormattingProvider = true,
    documentFormattingRangeProvider = true,
    offsetEncoding = "utf-8",
  },
}
