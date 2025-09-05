import 'package:string_calculator_kata_task/infrastructure/tokenizer.dart';
import 'package:test/test.dart';

void main() {
  const tokenizer = RegexTokenizer();

  test('splits by delimiters and newline; trims & ignores empties', () {
    final tokens = tokenizer.tokenize(
      body: ' 1 , 2\n3,,4 ',
      delimiters: [','],
    );
    expect(tokens.toList(), ['1', '2', '3', '4']);
  });

  test('multi-char delimiters work', () {
    final tokens = tokenizer.tokenize(
      body: '1***2***3',
      delimiters: ['***'],
    );
    expect(tokens.toList(), ['1', '2', '3']);
  });

  test('multiple delimiters work', () {
    final tokens = tokenizer.tokenize(
      body: '1**2%3\n4',
      delimiters: ['**', '%'],
    );
    expect(tokens.toList(), ['1', '2', '3', '4']);
  });
}
