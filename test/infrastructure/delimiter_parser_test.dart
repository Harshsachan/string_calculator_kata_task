import 'package:string_calculator_kata_task/infrastructure/delimiter_parser.dart';
import 'package:test/test.dart';

void main() {
  const parser = DelimiterSpecParser();

  test('no header -> default comma', () {
    final spec = parser.parse('1,2,3');
    expect(spec.delimiters, [',']);
    expect(spec.numbersPart, '1,2,3');
  });

  test('single-char delimiter', () {
    final spec = parser.parse('//;\n1;2');
    expect(spec.delimiters, [';']);
    expect(spec.numbersPart, '1;2');
  });

  test('multi-char delimiter', () {
    final spec = parser.parse('//[***]\n1***2***3');
    expect(spec.delimiters, ['***']);
    expect(spec.numbersPart, '1***2***3');
  });

  test('multiple delimiters (extension)', () {
    final spec = parser.parse('//[**][%]\n1**2%3');
    expect(spec.delimiters, ['**', '%']);
    expect(spec.numbersPart, '1**2%3');
  });
}
