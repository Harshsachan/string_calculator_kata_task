
import 'package:string_calculator_kata_task/domain/contracts.dart';
import 'package:string_calculator_kata_task/domain/errors.dart';

/// Parses integers with trimming and clear error messages.
final class StrictIntParser implements INumberParser {
  /// Creates a strict integer parser.
  const StrictIntParser();

  @override
  int parse(String token) {
    final value = int.tryParse(token.trim());
    if (value == null) throw InvalidTokenException(token);
    return value;
  }
}
