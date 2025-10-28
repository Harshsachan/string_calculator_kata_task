# String Calculator — Incubyte TDD Kata (Dart)


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

## All Test cases via cli 
# Empty -> 0
dart run lib/main.dart ""
# 0

# Single number
dart run lib/main.dart "1"
# 1

# Two numbers (comma)
dart run lib/main.dart "1,5"
# 6

# Any amount
dart run lib/main.dart "1,2,3,4,5"
# 15

# Newlines allowed (real newline via $'...')
dart run lib/main.dart $'1\n2,3'
# 6

# Custom delimiter (single char)
dart run lib/main.dart $'//;\n1;2'
# 3

# Custom delimiter (multi-char)
dart run lib/main.dart $'//[***]\n1***2***3'
# 6

# Mix newline with custom delimiter
dart run lib/main.dart $'//;\n1;2\n3'
# 6

# Negative number -> error (stderr, exit code 1)
dart run lib/main.dart "1,-2,3"
# Invalid argument(s): negative numbers not allowed -2

# Multiple negatives -> all listed (stderr, exit code 1)
dart run lib/main.dart "-1,-2,3,-4"
# Invalid argument(s): negative numbers not allowed -1,-2,-4
```