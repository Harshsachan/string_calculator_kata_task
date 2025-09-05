
import 'package:string_calculator_kata_task/domain/contracts.dart';
import 'package:string_calculator_kata_task/domain/errors.dart';

/// Business rule: negative numbers are not allowed; throw listing all of them.
final class NegativeNumberPolicy implements INegativeNumberPolicy {
  /// Creates the negative-number validation policy.
  const NegativeNumberPolicy();

  @override
  void validate(Iterable<int> numbers) {
    final negatives = numbers.where((n) => n < 0).toList(growable: false);
    if (negatives.isNotEmpty) {
      throw NegativeNumbersException(negatives);
    }
  }
}
