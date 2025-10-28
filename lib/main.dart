import 'dart:convert';
import 'dart:io';

import 'package:string_calculator_kata_task/application/string_calculator.dart';

void main(List<String> args) async {
  const calc = StringCalculator();

  try {
    final raw = args.isNotEmpty
        ? args.join(' ')
        : await stdin.transform(utf8.decoder).join();

    final normalized = raw.replaceAll(r'\n', '\n');

    final result = calc.add(normalized.trim());
    stdout.writeln(result);
  } catch (e) {
    stderr.writeln(e);
    exitCode = 1;
  }
}