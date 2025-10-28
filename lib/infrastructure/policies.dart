
import 'package:string_calculator_kata_task/domain/contracts.dart';
import 'package:string_calculator_kata_task/domain/errors.dart';

final class NegativeNumberPolicy implements INegativeNumberPolicy {
  const NegativeNumberPolicy();

  @override
  void validate(Iterable<int> numbers) {
    final negatives = numbers.where((n) => n < 0).toList(growable: false);
    if (negatives.isNotEmpty) {
      throw NegativeNumbersException(negatives);
    }
  }
}
