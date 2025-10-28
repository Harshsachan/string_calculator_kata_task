import 'package:string_calculator_kata_task/infrastructure/number_parser.dart';
import 'package:string_calculator_kata_task/infrastructure/policies.dart';
import 'package:test/test.dart';

void main() {
  const parser = StrictIntParser();
  const policy = NegativeNumberPolicy();

  test('parses valid ints', () {
    expect(parser.parse('42'), 42);
    expect(parser.parse('  7  '), 7);
  });

  test('invalid tokens throw FormatException', () {
    expect(() => parser.parse('x'), throwsA(isA<FormatException>()));
  });

  test('policy throws with all negatives listed', () {
    expect(
      () => policy.validate([1, -2, -3, 4]),
      throwsA(
        isA<ArgumentError>().having(
          (e) => e.message,
          'message',
          'negative numbers not allowed -2,-3',
        ),
      ),
    );
  });

  test('policy passes if no negatives', () {
    expect(() => policy.validate([1, 2, 3]), returnsNormally);
  });
}
