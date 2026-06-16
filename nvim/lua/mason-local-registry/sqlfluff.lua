-- Pin sqlfluff to 4.2.1, the latest version available in the Uber PyPI mirror.
-- The upstream Mason registry targets 4.2.2, which does not exist in the mirror.
return {
  name = "sqlfluff",
  description = "SQLFluff is a dialect-flexible and configurable SQL linter.",
  homepage = "https://github.com/sqlfluff/sqlfluff",
  licenses = { "MIT" },
  languages = { "SQL" },
  categories = { "Linter" },
  source = {
    id = "pkg:pypi/sqlfluff@4.2.1",
  },
  bin = {
    sqlfluff = "pypi:sqlfluff",
  },
}
