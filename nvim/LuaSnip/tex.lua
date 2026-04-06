-- tex.lua
local ls = require("luasnip")
local s = ls.snippet
local t = ls.text_node
local i = ls.insert_node

return {
  -- TOP Box
  s("top", {
    t("\\begin{tcolorbox}[topbox={"), i(1, "Titel"), t("}]"), t({"", ""}),
    i(2, "Inhalt..."), t({"", "\\end{tcolorbox}"}),
  }),

  -- TODO Box
  s("todo", {
    t("\\begin{tcolorbox}[todobox={"), i(1, "Titel"), t("}]"), t({"", ""}),
    i(2, "Inhalt..."), t({"", "\\end{tcolorbox}"}),
  }),

  -- Beschluss Box
  s("beschluss", {
    t("\\begin{tcolorbox}[beschlussbox]"), t({"", ""}),
    i(1, "Inhalt..."), t({"", "\\end{tcolorbox}"}),
  }),
}
