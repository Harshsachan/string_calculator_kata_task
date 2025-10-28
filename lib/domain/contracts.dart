library string_calculator_kata.domain.contracts;

// ignore_for_file: one_member_abstracts

/// Contract for the string calculator.
abstract interface class IStringCalculator {
  /// Adds numbers from [input] according to the kata rules.
  int add(String input);
}

/// Parses an optional leading delimiter specification (header).
abstract interface class IDelimiterSpecParser {
  /// Parses [input] and returns a [DelimiterSpec] with delimiters and numbers.
  DelimiterSpec parse(String input);
}

/// Tokenizes a numbers body using a set of delimiters plus newlines.
abstract interface class ITokenizer {
  /// Returns trimmed tokens split from [body] using [delimiters] and `\n`.
  Iterable<String> tokenize({
    required String body,
    required List<String> delimiters,
  });
}

/// Parses a numeric token to an integer or throws.
abstract interface class INumberParser {
  /// Parses [token] into an `int`, throwing if the token is invalid.
  int parse(String token);
}

/// Validates numbers against business rules (e.g., no negatives).
abstract interface class INegativeNumberPolicy {
  /// Validates [numbers]; throws if any rule is violated.
  void validate(Iterable<int> numbers);
}

/// Value object representing the parsed header & remaining numbers part.
final class DelimiterSpec {
  /// Creates a new spec.
  const DelimiterSpec({
    required this.delimiters,
    required this.numbersPart,
  });

  /// Custom delimiters (comma is the default; newline is always allowed
  /// during tokenization).
  final List<String> delimiters;

  /// The remainder of the input containing the numbers.
  final String numbersPart;
}
