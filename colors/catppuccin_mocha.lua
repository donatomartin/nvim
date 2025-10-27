
-- ~/.config/nvim/colors/catppuccin_mocha.lua
-- Minimal, plugin-free Catppuccin Mocha
vim.cmd("highlight clear")
if vim.fn.exists("syntax_on") == 1 then vim.cmd("syntax reset") end
vim.g.colors_name = "catppuccin_mocha"

local p = {
  rosewater = "#f5e0dc", flamingo = "#f2cdcd", pink   = "#f5c2e7",
  mauve     = "#cba6f7", red      = "#f38ba8", maroon = "#eba0ac",
  peach     = "#fab387", yellow   = "#f9e2af", green  = "#a6e3a1",
  teal      = "#94e2d5", sky      = "#89dceb", sapphire = "#74c7ec",
  blue      = "#89b4fa", lavender = "#b4befe",
  text = "#cdd6f4", subtext1 = "#bac2de", subtext0 = "#a6adc8",
  overlay2 = "#9399b2", overlay1 = "#7f849c", overlay0 = "#6c7086",
  surface2 = "#585b70", surface1 = "#45475a", surface0 = "#313244",
  base = "#1e1e2e", mantle = "#181825", crust = "#11111b",
}

local function set(group, spec) vim.api.nvim_set_hl(0, group, spec) end

-- UI
set("Normal",       { fg = p.text, bg = p.base })
set("NormalFloat",  { fg = p.text, bg = p.mantle })
set("FloatBorder",  { fg = p.overlay2, bg = p.mantle })
set("CursorLine",   { bg = p.surface0 })
set("CursorLineNr", { fg = p.lavender, bold = true })
set("LineNr",       { fg = p.overlay0 })
set("WinSeparator", { fg = p.surface2 })
set("Pmenu",        { fg = p.text, bg = p.surface0 })
set("PmenuSel",     { fg = p.base, bg = p.lavender })
set("StatusLine",   { fg = p.text, bg = p.surface0 })
set("Visual",       { bg = p.surface1 })
set("Search",       { fg = p.base, bg = p.yellow })
set("IncSearch",    { fg = p.base, bg = p.peach })
set("MatchParen",   { fg = p.mauve, bold = true })
set("SignColumn",   { bg = p.base })
set("ColorColumn",  { bg = p.mantle })
set("NonText",      { fg = p.surface2 })
set("Whitespace",   { fg = p.surface2 })
set("Directory",    { fg = p.blue })
set("Title",        { fg = p.mauve, bold = true })
set("ErrorMsg",     { fg = p.red, bold = true })
set("WarningMsg",   { fg = p.peach })
set("MoreMsg",      { fg = p.green })
set("Todo",         { fg = p.yellow, bold = true })
set("Folded",       { fg = p.subtext0, bg = p.surface0 })
set("FoldColumn",   { fg = p.overlay0, bg = p.base })

-- Syntax (classic + Treesitter-friendly)
set("Comment",      { fg = p.overlay1, italic = true })
set("Constant",     { fg = p.peach })
set("String",       { fg = p.green })
set("Character",    { fg = p.green })
set("Number",       { fg = p.peach })
set("Boolean",      { fg = p.peach })
set("Float",        { fg = p.peach })
set("Identifier",   { fg = p.blue })
set("Function",     { fg = p.blue })
set("Statement",    { fg = p.mauve })
set("Conditional",  { fg = p.mauve })
set("Repeat",       { fg = p.mauve })
set("Label",        { fg = p.sapphire })
set("Operator",     { fg = p.sky })
set("Keyword",      { fg = p.mauve })
set("Exception",    { fg = p.red })
set("PreProc",      { fg = p.yellow })
set("Include",      { fg = p.sapphire })
set("Define",       { fg = p.yellow })
set("Macro",        { fg = p.yellow })
set("Type",         { fg = p.yellow })
set("StorageClass", { fg = p.teal })
set("Structure",    { fg = p.yellow })
set("Typedef",      { fg = p.yellow })
set("Special",      { fg = p.pink })
set("SpecialComment", { fg = p.overlay1, italic = true })
set("Underlined",   { underline = true })
set("Bold",         { bold = true })
set("Italic",       { italic = true })

-- Diagnostics (LSP)
set("DiagnosticError", { fg = p.red })
set("DiagnosticWarn",  { fg = p.peach })
set("DiagnosticInfo",  { fg = p.sapphire })
set("DiagnosticHint",  { fg = p.teal })
set("DiagnosticOk",    { fg = p.green })
set("DiagnosticUnderlineError", { sp = p.red, undercurl = true })
set("DiagnosticUnderlineWarn",  { sp = p.peach, undercurl = true })
set("DiagnosticUnderlineInfo",  { sp = p.sapphire, undercurl = true })
set("DiagnosticUnderlineHint",  { sp = p.teal, undercurl = true })

-- Diff / Git (works with built-in and many plugins)
set("DiffAdd",    { bg = "#1a2a1a" })
set("DiffChange", { bg = "#1a1f2a" })
set("DiffDelete", { bg = "#2a1a1a", fg = p.red })
set("DiffText",   { bg = "#24324a" })

-- LSP semantic tokens (fallbacks)
set("@variable",        { fg = p.text })
set("@property",        { fg = p.teal })
set("@field",           { fg = p.teal })
set("@function",        { fg = p.blue })
set("@method",          { fg = p.blue })
set("@constructor",     { fg = p.sapphire })
set("@parameter",       { fg = p.rosewater, italic = true })
set("@keyword",         { fg = p.mauve })
set("@type",            { fg = p.yellow })
set("@type.builtin",    { fg = p.yellow, italic = true })
set("@string",          { fg = p.green })
set("@number",          { fg = p.peach })
set("@boolean",         { fg = p.peach })
set("@operator",        { fg = p.sky })
set("@comment",         { fg = p.overlay1, italic = true })
