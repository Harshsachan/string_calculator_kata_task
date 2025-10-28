import 'package:string_calculator_kata_task/application/string_calculator.dart';
import 'package:test/test.dart';

void main() {
  const calc = StringCalculator();

  group('StringCalculator.add — happy path', () {
    test('empty -> 0', () => expect(calc.add(''), 0));

    test('single number', () {
      expect(calc.add('1'), 1);
      expect(calc.add('42'), 42);
      expect(calc.add('007'), 7);
    });

    test('two numbers (comma)', () => expect(calc.add('1,5'), 6));

    test('any amount', () => expect(calc.add('1,2,3,4,5'), 15));

    test('newlines as delimiters', () {
      expect(calc.add('1\n2,3'), 6);
      expect(calc.add('10\n20\n30'), 60);
    });

    test('custom single-char delimiter', () {
      expect(calc.add('//;\n1;2'), 3);
      expect(calc.add('//*\n2*3*4'), 9);
    });

    test('custom multi-char delimiter (bracketed)', () {
      expect(calc.add('//[***]\n1***2***3'), 6);
      expect(calc.add('//[--]\n4--5--6'), 15);
    });

    test('mix newline with custom delimiter still works', () {
      expect(calc.add('//;\n1;2\n3'), 6);
    });
  });

  group('StringCalculator.add — error paths', () {
    test('lists all negatives in message', () {
      expect(
        () => calc.add('-1,-2,3,-4'),
        throwsA(
          isA<ArgumentError>().having(
            (e) => e.message,
            'message',
            'negative numbers not allowed -1,-2,-4',
          ),
        ),
      );
    });

    test('invalid token -> FormatException', () {
      expect(() => calc.add('1,q,3'), throwsA(isA<FormatException>()));
    });

    test('invalid header (missing newline)', () {
      expect(() => calc.add('//;1;2'), throwsA(isA<FormatException>()));
    });

    test('empty delimiter not allowed', () {
      expect(() => calc.add('//[]\n1'), throwsA(isA<FormatException>()));
    });
  });
}
