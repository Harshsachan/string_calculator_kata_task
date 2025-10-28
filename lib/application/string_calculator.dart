import 'package:string_calculator_kata_task/domain/contracts.dart';
import 'package:string_calculator_kata_task/infrastructure/delimiter_parser.dart';
import 'package:string_calculator_kata_task/infrastructure/number_parser.dart';
import 'package:string_calculator_kata_task/infrastructure/policies.dart';
import 'package:string_calculator_kata_task/infrastructure/tokenizer.dart';

final class StringCalculator implements IStringCalculator {

  const StringCalculator({
    IDelimiterSpecParser? delimiterParser,
    ITokenizer? tokenizer,
    INumberParser? numberParser,
    INegativeNumberPolicy? negativePolicy,
  })  : _delimiterParser = delimiterParser ?? const DelimiterSpecParser(),
        _tokenizer = tokenizer ?? const RegexTokenizer(),
        _numberParser = numberParser ?? const StrictIntParser(),
        _negativePolicy = negativePolicy ?? const NegativeNumberPolicy();

  final IDelimiterSpecParser _delimiterParser;
  final ITokenizer _tokenizer;
  final INumberParser _numberParser;
  final INegativeNumberPolicy _negativePolicy;

  /// Adds numbers found in [input] according to the kata rules.
  @override
  int add(String input) {
    if (input.isEmpty) return 0;

    final spec = _delimiterParser.parse(input);
    final tokens = _tokenizer.tokenize(
      body: spec.numbersPart,
      delimiters: spec.delimiters,
    );

    final numbers = <int>[];
    for (final t in tokens) {
      numbers.add(_numberParser.parse(t));
    }

    _negativePolicy.validate(numbers);

    var sum = 0;
    for (final n in numbers) {
      sum += n;
    }
    return sum;
  }
}
