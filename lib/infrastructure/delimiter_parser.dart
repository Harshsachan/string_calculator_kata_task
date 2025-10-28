import 'package:string_calculator_kata_task/domain/contracts.dart';
import 'package:string_calculator_kata_task/domain/errors.dart';

final class DelimiterSpecParser implements IDelimiterSpecParser {
  /// Creates a parser for delimiter specifications.
  const DelimiterSpecParser();

  static const _defaultDelimiters = <String>[','];

  @override
  DelimiterSpec parse(String input) {
    if (!input.startsWith('//')) {
      return DelimiterSpec(delimiters: _defaultDelimiters, numbersPart: input);
    }

    final newlineIdx = input.indexOf('\n');
    if (newlineIdx == -1) {
      throw const InvalidHeaderException(
        'Missing newline after custom delimiter header.',
      );
    }

    final raw = input.substring(2, newlineIdx);
    final numbersPart = input.substring(newlineIdx + 1);

    final delimiters = _extractDelimiters(raw);
    if (delimiters.isEmpty || delimiters.any((d) => d.isEmpty)) {
      throw const InvalidHeaderException('Empty delimiter is not allowed.');
    }

    return DelimiterSpec(delimiters: delimiters, numbersPart: numbersPart);
  }

  /// Supports:
  ///   `//;`         -> `[';']`
  ///   `//[***]`     -> `['***']`
  ///   `//[d1][d2]`  -> `['d1', 'd2']`
  List<String> _extractDelimiters(String raw) {
    if (raw.startsWith('[') && raw.endsWith(']')) {
      // Multiple bracketed delimiters: parse all `[ .. ]` segments.
      final result = <String>[];
      var i = 0;
      while (i < raw.length) {
        if (raw.codeUnitAt(i) != '['.codeUnitAt(0)) break;
        final end = raw.indexOf(']', i + 1);
        if (end == -1) {
          throw const InvalidHeaderException('Unclosed delimiter bracket.]');
        }
        result.add(raw.substring(i + 1, end));
        i = end + 1;
      }
      return result;
    }
    // Unbracketed single token.
    return <String>[raw];
  }
}
