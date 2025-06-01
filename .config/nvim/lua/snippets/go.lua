-- ~/.config/nvim/lua/snippets/go.lua
local ls = require("luasnip")
local s = ls.snippet
local i = ls.insert_node
local t = ls.text_node
local fmt = require("luasnip.extras.fmt").fmt

return {
  -- main function
  s(
    "main",
    fmt(
      [[
func main() {{
    {}
}}
  ]],
      { i(0) }
    )
  ),

  -- error check
  s(
    "ern",
    fmt(
      [[
if err != nil {{
    return {}
}}
  ]],
      { i(0) }
    )
  ),

  -- error check with action
  s(
    "ifern",
    fmt(
      [[
if {}; err != nil {{
    return {}
}}
  ]],
      { i(1), i(0) }
    )
  ),

  -- test function
  s(
    "test",
    fmt(
      [[
func Test{}(t *testing.T) {{
    {}
}}
  ]],
      { i(1), i(0) }
    )
  ),

  -- function with params and returns
  s(
    "func",
    fmt(
      [[
func {}({}) {} {{
    {}
}}
  ]],
      { i(1, "name"), i(2, "params"), i(3, "return"), i(0) }
    )
  ),

  -- fmt.Println shortcut
  s("pf", fmt([[fmt.Println("{}")]], { i(0) })),

  -- defer function call
  s("defer", fmt([[defer {}()]], { i(0, "func") })),
}
