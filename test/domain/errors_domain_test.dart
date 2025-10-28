import 'package:string_calculator_kata_task/domain/errors.dart';
import 'package:test/test.dart';

void main() {
  group('InvalidHeaderException', () {
    test('is a FormatException with provided message', () {
      const e = InvalidHeaderException('oops');
      expect(e, isA<FormatException>());
      expect(e.message, 'oops');
    });
  });

  group('InvalidTokenException', () {
    test('is a FormatException with token in message', () {
      final e = InvalidTokenException('abc');
      expect(e, isA<FormatException>());
      expect(e.message, 'Invalid number token "abc"');
    });
  });

  group('NegativeNumbersException', () {
    test('is an ArgumentError with exact kata message (single negative)', () {
      final e = NegativeNumbersException(const [-1]);
      expect(e, isA<ArgumentError>());
      expect(e.message, 'negative numbers not allowed -1');
    });

    test('lists all negatives, comma-separated, no trailing punctuation', () {
      final e = NegativeNumbersException(const [-1, -2, -4]);
      expect(e, isA<ArgumentError>());
      expect(e.message, 'negative numbers not allowed -1,-2,-4');
    });
  });
}
