import 'dart:convert';
import 'dart:io';

import 'package:string_calculator_kata_task/application/string_calculator.dart';

/// Simple CLI to run the String Calculator.
///
/// Usage:
/// ```bash
/// dart run bin/cli.dart "//[***]\n1***2***3"
/// # or
/// echo "1\n2,3" | dart run bin/cli.dart
/// ```
void main(List<String> args) async {
  const calc = StringCalculator();

  try {
    // Read from args if provided, otherwise from stdin.
    final raw = args.isNotEmpty
        ? args.join(' ')
        : await stdin.transform(utf8.decoder).join();

    // Convenience for CLI usage: turn literal "\n" into a real newline.
    // This does NOT change library semantics; it's just for shell ergonomics.
    final normalized = raw.replaceAll(r'\n', '\n');

    final result = calc.add(normalized.trim());
    stdout.writeln(result);
  } catch (e) {
    stderr.writeln(e);
    exitCode = 1;
  }
}