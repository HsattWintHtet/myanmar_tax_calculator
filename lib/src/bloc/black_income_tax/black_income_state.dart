

import 'package:equatable/equatable.dart';
import 'package:myanmar_tax_calculator/src/ui/utils/constant_utils.dart';
import 'package:meta/meta.dart';

@immutable
class BlackIncomeState extends Equatable {

  final int yearOptionIndex;
  final String startYear;
  final String endYear;

  final int taxableAmount;
  final int taxAmount;

  final int expense;
  final int whiteMoney;
  final List<RuleItem> selectedRuleItems;

  BlackIncomeState({
    @required this.yearOptionIndex,
    @required this.startYear,
    @required this.endYear,
    @required this.taxableAmount,
    @required this.taxAmount,
    @required this.expense,
    @required this.whiteMoney,
    @required this.selectedRuleItems,
  }) : super([
    yearOptionIndex,
    startYear,
    endYear,
    taxableAmount,
    taxAmount,
    expense,
    whiteMoney,
    selectedRuleItems,
  ]);

  factory BlackIncomeState.initial(List<RuleItem> selectedRuleItems) {
    return BlackIncomeState(
      yearOptionIndex: 0,
      startYear:'၂၀၁၄',
      endYear:'၂၀၁၅',
      taxableAmount: 0,
      taxAmount: 0,
      expense: 0,
      whiteMoney: 0,
      selectedRuleItems: selectedRuleItems,
    );
  }

  BlackIncomeState copyWith({
    int yearOptionIndex,
    String startYear,
    String endYear,
    int taxableAmount,
    int taxAmount,
    int expense,
    int whiteMoney,
    List<RuleItem> selectedRuleItems,
  }) {
    return BlackIncomeState(
      yearOptionIndex: yearOptionIndex ?? this.yearOptionIndex,
      startYear: startYear ?? this.startYear,
      endYear: endYear ?? this.endYear,
      taxableAmount: taxableAmount ?? this.taxableAmount,
      taxAmount: taxAmount ?? this.taxAmount,
      expense: expense ?? this.expense,
      whiteMoney: whiteMoney ?? this.whiteMoney,
      selectedRuleItems: selectedRuleItems ?? this.selectedRuleItems,
    );
  }

  @override
  String toString() {
    return '''BlackIncomeState {
      yearOptionIndex: $yearOptionIndex,
      startYear: $startYear,
      endYear: $endYear,
      taxableAmount: $taxableAmount,
      taxAmount: $taxAmount,
      expense: $expense,
      whiteMoney: $whiteMoney,
      selectedRuleItems: $selectedRuleItems
    }''';
  }
}