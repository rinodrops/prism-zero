-- Generated file. Do not edit by hand.
-- Regenerate: python3 tools/gen_nvim_theme.py

vim.cmd("highlight clear")
if vim.fn.exists("syntax_on") == 1 then
  vim.cmd("syntax reset")
end

vim.o.background = "dark"
vim.g.colors_name = "prism_zero_dark"

local c = {
  bg = "#0c0e13",
  fg = "#bfbdb7",
  editor_fg = "#bfbdb7",
  line = "#1a1e28",
  selection = "#2a4a6a",
  border = "#2a2e38",
  status_bg = "#12151c",
  status_fg = "#bfbdb7",
  muted = "#8a9ba8",
  sidebar_fg = "#8a9ba8",
  line_number = "#5a6270",
  comment = "#8a9ba8",
  punctuation = "#8a8a8a",
  property = "#f050b8",
  string = "#b4e83a",
  operator = "#d0b090",
  keyword = "#3ec0ff",
  func = "#ff5c7a",
  variable = "#ffb020",
  ansi_red = "#ff5c7a",
  ansi_yellow = "#ffb020",
  ansi_blue = "#3ec0ff",
}

local function hl(group, opts)
  vim.api.nvim_set_hl(0, group, opts)
end

hl("Normal", { fg = c.fg, bg = c.bg })
hl("NormalNC", { fg = c.fg, bg = c.bg })
hl("NormalFloat", { fg = c.fg, bg = c.bg })
hl("FloatBorder", { fg = c.border, bg = c.bg })
hl("Cursor", { fg = c.bg, bg = c.keyword })
hl("CursorLine", { bg = c.line })
hl("CursorColumn", { bg = c.line })
hl("ColorColumn", { bg = c.line })
hl("Visual", { bg = c.selection })
hl("VisualNOS", { bg = c.selection })
hl("Search", { bg = c.selection })
hl("IncSearch", { fg = c.bg, bg = c.variable })
hl("LineNr", { fg = c.line_number })
hl("CursorLineNr", { fg = c.editor_fg, bold = true })
hl("SignColumn", { fg = c.line_number, bg = c.bg })
hl("FoldColumn", { fg = c.line_number, bg = c.bg })
hl("Folded", { fg = c.muted, bg = c.status_bg })
hl("StatusLine", { fg = c.status_fg, bg = c.status_bg })
hl("StatusLineNC", { fg = c.muted, bg = c.status_bg })
hl("WinSeparator", { fg = c.border })
hl("VertSplit", { fg = c.border })
hl("TabLine", { fg = c.muted, bg = c.status_bg })
hl("TabLineFill", { bg = c.status_bg })
hl("TabLineSel", { fg = c.status_fg, bg = c.bg })
hl("Pmenu", { fg = c.fg, bg = c.status_bg })
hl("PmenuSel", { fg = c.fg, bg = c.selection })
hl("PmenuSbar", { bg = c.status_bg })
hl("PmenuThumb", { bg = c.border })
hl("WildMenu", { fg = c.fg, bg = c.selection })
hl("Directory", { fg = c.keyword })
hl("Title", { fg = c.keyword, bold = true })
hl("ErrorMsg", { fg = c.ansi_red })
hl("WarningMsg", { fg = c.ansi_yellow })
hl("MoreMsg", { fg = c.string })
hl("Question", { fg = c.keyword })
hl("NonText", { fg = c.line_number })
hl("Whitespace", { fg = c.line_number })
hl("SpecialKey", { fg = c.line_number })
hl("MatchParen", { fg = c.keyword, bold = true })
hl("DiffAdd", { fg = c.string })
hl("DiffChange", { fg = c.variable })
hl("DiffDelete", { fg = c.ansi_red })
hl("DiffText", { fg = c.keyword, bold = true })

hl("Comment", { fg = c.comment, italic = true })
hl("Constant", { fg = c.property })
hl("String", { fg = c.string })
hl("Character", { fg = c.string })
hl("Number", { fg = c.variable })
hl("Boolean", { fg = c.variable })
hl("Float", { fg = c.variable })
hl("Identifier", { fg = c.property })
hl("Function", { fg = c.func })
hl("Statement", { fg = c.keyword })
hl("Conditional", { fg = c.keyword })
hl("Repeat", { fg = c.keyword })
hl("Label", { fg = c.keyword })
hl("Operator", { fg = c.operator })
hl("Keyword", { fg = c.keyword })
hl("Exception", { fg = c.ansi_red })
hl("PreProc", { fg = c.keyword })
hl("Include", { fg = c.keyword })
hl("Define", { fg = c.keyword })
hl("Macro", { fg = c.func })
hl("Type", { fg = c.variable })
hl("StorageClass", { fg = c.keyword })
hl("Structure", { fg = c.variable })
hl("Typedef", { fg = c.variable })
hl("Special", { fg = c.func })
hl("SpecialChar", { fg = c.variable })
hl("Tag", { fg = c.string })
hl("Delimiter", { fg = c.punctuation })
hl("SpecialComment", { fg = c.comment })
hl("Todo", { fg = c.variable, bold = true })
hl("Error", { fg = c.ansi_red })
hl("Underlined", { fg = c.keyword, underline = true })

-- Treesitter
hl("@comment", { link = "Comment" })
hl("@punctuation", { link = "Delimiter" })
hl("@punctuation.delimiter", { link = "Delimiter" })
hl("@punctuation.bracket", { link = "Delimiter" })
hl("@string", { link = "String" })
hl("@string.escape", { fg = c.variable })
hl("@character", { link = "Character" })
hl("@number", { link = "Number" })
hl("@boolean", { link = "Boolean" })
hl("@constant", { link = "Constant" })
hl("@constant.builtin", { fg = c.variable })
hl("@variable", { fg = c.fg })
hl("@variable.parameter", { fg = c.property })
hl("@variable.member", { fg = c.property })
hl("@property", { fg = c.property })
hl("@attribute", { fg = c.property })
hl("@keyword", { link = "Keyword" })
hl("@keyword.function", { link = "Keyword" })
hl("@keyword.operator", { link = "Operator" })
hl("@operator", { link = "Operator" })
hl("@function", { link = "Function" })
hl("@function.builtin", { link = "Function" })
hl("@function.method", { link = "Function" })
hl("@type", { link = "Type" })
hl("@type.builtin", { link = "Type" })
hl("@tag", { fg = c.string })
hl("@tag.attribute", { fg = c.property })
hl("@tag.delimiter", { fg = c.punctuation })
hl("@markup.heading", { fg = c.keyword, bold = true })
hl("@markup.strong", { bold = true })
hl("@markup.italic", { italic = true })
hl("@markup.link", { fg = c.keyword, underline = true })
hl("@markup.raw", { fg = c.keyword })

local ansi = {
  "#252a33",
  "#ff5c7a",
  "#b4e83a",
  "#ffb020",
  "#3ec0ff",
  "#f050b8",
  "#20d4ec",
  "#d0cec8",
  "#9aabba",
  "#ff8aa0",
  "#d0f060",
  "#ffd060",
  "#70d4ff",
  "#ff80d0",
  "#60eef8",
  "#ffffff",
}
for i, color in ipairs(ansi) do
  vim.g["terminal_color_" .. (i - 1)] = color
end
