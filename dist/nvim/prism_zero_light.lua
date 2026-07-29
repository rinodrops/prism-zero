-- Generated file. Do not edit by hand.
-- Regenerate: python3 tools/gen_nvim_theme.py

vim.cmd("highlight clear")
if vim.fn.exists("syntax_on") == 1 then
  vim.cmd("syntax reset")
end

vim.o.background = "light"
vim.g.colors_name = "prism_zero_light"

local c = {
  bg = "#ffffff",
  fg = "#000000",
  editor_fg = "#24292e",
  line = "#fffbdd",
  selection = "#b3d4fc",
  border = "#e1e4e8",
  status_bg = "#fafbfc",
  status_fg = "#24292e",
  muted = "#586069",
  sidebar_fg = "#586069",
  line_number = "#cccccc",
  comment = "#708090",
  punctuation = "#999999",
  property = "#990055",
  string = "#669900",
  operator = "#9a6e3a",
  keyword = "#0077aa",
  func = "#dd4a68",
  variable = "#ee9900",
  ansi_red = "#d93556",
  ansi_yellow = "#ee9900",
  ansi_blue = "#008ac6",
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
  "#000000",
  "#d93556",
  "#669900",
  "#ee9900",
  "#008ac6",
  "#a8005e",
  "#008899",
  "#b8c0c7",
  "#5a6773",
  "#e65b77",
  "#88cc00",
  "#ffb022",
  "#00aef9",
  "#db007b",
  "#00b5cc",
  "#5a6773",
}
for i, color in ipairs(ansi) do
  vim.g["terminal_color_" .. (i - 1)] = color
end
