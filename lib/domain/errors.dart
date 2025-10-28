library string_calculator_kata.domain.errors;

/// Thrown for bad or missing header newline, empty delimiter, etc.
final class InvalidHeaderException extends FormatException {
  /// Creates an [InvalidHeaderException] with [message].
  const InvalidHeaderException(super.message);
}

/// Thrown when a non-numeric token appears in the numbers body.
final class InvalidTokenException extends FormatException {
  /// Creates an [InvalidTokenException] for the offending [token].
  InvalidTokenException(String token) : super('Invalid number token "$token"');
}

/// Thrown when one or more negative numbers are present.
///
/// The message must match the kata exactly, e.g.:
/// `negative numbers not allowed -1,-2`
final class NegativeNumbersException extends ArgumentError {
  /// Creates a [NegativeNumbersException] listing all [negatives].
  NegativeNumbersException(List<int> negatives)
      : super('negative numbers not allowed ${negatives.join(",")}');
}
