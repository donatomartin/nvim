local ls = require("luasnip")

local s = ls.snippet
local i = ls.insert_node
local f = ls.function_node
local fmt = require("luasnip.extras.fmt").fmt

local function to_pascal_case(str)
  local parts = vim.split(
    str:gsub("([a-z0-9])([A-Z])", "%1 %2"):gsub("[-_]", " "),
    "%s+",
    { trimempty = true }
  )

  for i, part in ipairs(parts) do
    parts[i] = part:sub(1, 1):upper() .. part:sub(2):lower()
  end

  return table.concat(parts)
end

local function get_package_name()
  local dir = vim.fn.expand("%:p:h")

  local pkg = dir:match(".*/src/main/java/(.*)")
      or dir:match(".*/src/test/java/(.*)")

  if not pkg then
    return "package ;"
  end

  return "package " .. pkg:gsub("/", ".") .. ";"
end

return {

  -- Package statement
  s("pkg", {
    f(function()
      return get_package_name()
    end),
  }),

  -- Create test class
  s(
    "tclass",
    fmt(
      [[
      {}

      import org.junit.jupiter.api.Test;

      class {} {{

        {}

      }}
      ]],
      {
        f(function()
          return get_package_name() or ""
        end),
        f(function()
          return vim.fn.expand("%:t:r")
        end),
        i(0),
      }
    )
  ),

  -- Create test function
  s("tfun",
    fmt(
      [[
      @Test
      void test{}() {{
        {}

      }}
      ]],
      {
        i(1, "MethodNameCondition"),
        i(0)
      }
    )
  ),

  -- Mock
  s("when",
    fmt(
      [[
      when(
        {}
      ).thenReturn(
        {}
      )
      {}
      ]],
      {
        i(1, "condition"),
        i(2, "mocked return"),
        i(0)
      }
    )
  ),

}
