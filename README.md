# String Calculator — Incubyte TDD Kata (Dart)

A SOLID, test-driven implementation of the String Calculator kata in **Dart**, with strict lints, full test coverage, and **GitHub Actions CI**.

## Requirements covered
- `"" -> 0`
- Any count of numbers, comma delimiter
- Newlines as delimiters (e.g. `1\n2,3 -> 6`)
- Custom delimiter header: `//;\n1;2`, `//[***]\n1***2***3`
- Negatives throw: `negative numbers not allowed -1,-2` (lists all)
- Extension: multiple bracketed delimiters `//[d1][d2]`

## Quick start
```bash
dart pub get
dart test
dart run tool/coverage_check.dart --lcov coverage/lcov.info --min 100


## All Test cases via cli 
# Empty -> 0
dart run bin/cli.dart ""
# 0

# Single number
dart run bin/cli.dart "1"
# 1

# Two numbers (comma)
dart run bin/cli.dart "1,5"
# 6

# Any amount
dart run bin/cli.dart "1,2,3,4,5"
# 15

# Newlines allowed (real newline via $'...')
dart run bin/cli.dart $'1\n2,3'
# 6

# Custom delimiter (single char)
dart run bin/cli.dart $'//;\n1;2'
# 3

# Custom delimiter (multi-char)
dart run bin/cli.dart $'//[***]\n1***2***3'
# 6

# Mix newline with custom delimiter
dart run bin/cli.dart $'//;\n1;2\n3'
# 6

# Negative number -> error (stderr, exit code 1)
dart run bin/cli.dart "1,-2,3"
# Invalid argument(s): negative numbers not allowed -2

# Multiple negatives -> all listed (stderr, exit code 1)
dart run bin/cli.dart "-1,-2,3,-4"
# Invalid argument(s): negative numbers not allowed -1,-2,-4
```

---

## Design Notes (SOLID)

- **S**ingle Responsibility: each component (delimiter parser, tokenizer, number parser, policy) does one thing.
- **O**pen/Closed: add/replace rules (e.g., ignore > 1000) without changing the orchestrator.
- **L**iskov Substitution: application depends on interfaces; implementations are swappable.
- **I**nterface Segregation: small, focused interfaces (no kitchen-sink APIs).
- **D**ependency Inversion: the app layer depends on abstractions from `domain/`.

---