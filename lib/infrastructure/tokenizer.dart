
import 'package:string_calculator_kata_task/domain/contracts.dart';

final class RegexTokenizer implements ITokenizer {
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
