
import 'package:string_calculator_kata_task/domain/contracts.dart';

/// Splits by any custom delimiter OR newline.
///
/// Empty or whitespace-only tokens are ignored.
final class RegexTokenizer implements ITokenizer {
  /// Creates the regex-based tokenizer.
  const RegexTokenizer();

  @override
  Iterable<String> tokenize({
    required String body,
    required List<String> delimiters,
  }) sync* {
    final escaped = delimiters.map(RegExp.escape).join('|');
    final pattern = RegExp('(?:$escaped|\\n)');

    for (final raw in body.split(pattern)) {
      final t = raw.trim();
      if (t.isNotEmpty) yield t;
    }
  }
}
