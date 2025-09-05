import 'package:string_calculator_kata_task/domain/contracts.dart';
import 'package:test/test.dart';

void main() {
  group('DelimiterSpec', () {
    test('holds provided delimiters and numbersPart', () {
      const spec = DelimiterSpec(
        delimiters: [','],
        numbersPart: '1,2,3',
      );

      expect(spec.delimiters, [',']);
      expect(spec.numbersPart, '1,2,3');
    });

    test('supports const constructor', () {
      const spec = DelimiterSpec(
        delimiters: [','],
        numbersPart: '1,2',
      );

      expect(spec.delimiters, [',']);
      expect(spec.numbersPart, '1,2');
    });

    test('preserves delimiter order (useful for regex building)', () {
      const spec = DelimiterSpec(
        delimiters: ['**', '%', ';'],
        numbersPart: '1**2%3;4',
      );

      expect(spec.delimiters, ['**', '%', ';']);
    });
  });
}
