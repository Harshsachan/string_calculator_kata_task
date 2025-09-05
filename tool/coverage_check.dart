/// Simple LCOV coverage threshold checker.
/// Usage:
///   dart run tool/coverage_check.dart --lcov coverage/lcov.info --min 100
///
/// Exits 0 if coverage >= min, otherwise exits 1.
library string_calculator_kata.tool.coverage_check;

import 'dart:io';

void main(List<String> args) {
  final arg = _Args.fromArgs(args);
  final file = File(arg.lcovPath);

  if (!file.existsSync()) {
    stderr.writeln('LCOV not found at ${arg.lcovPath}');
    exit(2);
  }

  var found = 0; // total lines found
  var hit = 0; // total lines hit

  for (final line in file.readAsLinesSync()) {
    // Prefer LH/LF if present (per-file summary)
    if (line.startsWith('LF:')) {
      found += int.tryParse(line.substring(3).trim()) ?? 0;
      continue;
    }
    if (line.startsWith('LH:')) {
      hit += int.tryParse(line.substring(3).trim()) ?? 0;
      continue;
    }
    // Fallback to DA entries if LF/LH are absent
    if (line.startsWith('DA:')) {
      final parts = line.substring(3).split(',');
      if (parts.length == 2) {
        final hits = int.tryParse(parts[1]) ?? 0;
        found += 1;
        if (hits > 0) hit += 1;
      }
    }
  }

  final percent = found == 0 ? 100.0 : (hit / found * 100);
  final pStr = percent.toStringAsFixed(2);

  stdout.writeln('Coverage: $pStr% ($hit/$found lines)');
  if (percent + 1e-9 < arg.min) {
    stderr.writeln('Coverage below threshold ${arg.min}%');
    exit(1);
  }
}

class _Args {
  _Args({required this.lcovPath, required this.min});

  factory _Args.fromArgs(List<String> args) {
    var lcov = 'coverage/lcov.info';
    var min = 0.0;

    for (var i = 0; i < args.length; i++) {
      final key = args[i];
      if (!key.startsWith('--')) continue;
      final hasValue = i + 1 < args.length && !args[i + 1].startsWith('--');
      final value = hasValue ? args[++i] : 'true';

      if (key == '--lcov') lcov = value;
      if (key == '--min') min = double.tryParse(value) ?? min;
    }
    return _Args(lcovPath: lcov, min: min);
  }

  final String lcovPath;
  final double min;
}
