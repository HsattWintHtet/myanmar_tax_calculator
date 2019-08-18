
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

@immutable
abstract class BlackIncomeEvent extends Equatable {
  BlackIncomeEvent([List props = const []]) : super(props);
}

class YearOptionChangeEvent extends BlackIncomeEvent{
  final yearOptionIndex;

  YearOptionChangeEvent(this.yearOptionIndex);
}

class ExpenseTextChangeEvent extends BlackIncomeEvent {
  final int expense;

  ExpenseTextChangeEvent(this.expense);

}

class ClearEvent extends BlackIncomeEvent {
  ClearEvent();
}

class WhiteMoneyTextChangeEvent extends BlackIncomeEvent {
  final int whiteMoney;

  WhiteMoneyTextChangeEvent(this.whiteMoney);

}