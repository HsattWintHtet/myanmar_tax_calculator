import 'package:meta/meta.dart';
import 'package:equatable/equatable.dart';

@immutable
abstract class CorporateEvent extends Equatable {
  CorporateEvent([List props = const []]) : super(props);
}

class YearOptionChangeEvent extends CorporateEvent {
  final int selectOptionIndex;

  YearOptionChangeEvent(this.selectOptionIndex);

}

class IncomeTextChangeEvent extends CorporateEvent {
  final int income;

  IncomeTextChangeEvent(this.income);

}

class ProductionCostTextChangeEvent extends CorporateEvent {
  final int productionCost;

  ProductionCostTextChangeEvent(this.productionCost);

}

class ManagementCostTextChangeEvent extends CorporateEvent {
  final int managementCost;

  ManagementCostTextChangeEvent(this.managementCost);

}

class DepreciationTextChangeEvent extends CorporateEvent {
  final int depreciation;

  DepreciationTextChangeEvent(this.depreciation);

}

class NetProfitTextChangeEvent extends CorporateEvent {
  final int netProfit;

  NetProfitTextChangeEvent(this.netProfit);

}

class ClearEvent extends CorporateEvent {
  ClearEvent();
}


class ServiceTypeOptionChangeEvent extends CorporateEvent {
  final int serviceTypeOptionIndex;

  ServiceTypeOptionChangeEvent(this.serviceTypeOptionIndex);

}

class BizOptionChangeEvent extends CorporateEvent {
  final int bizTypeOptionIndex;

  BizOptionChangeEvent(this.bizTypeOptionIndex);

}

class TextChangeEvent extends CorporateEvent {
  final int income;
  final int profit;
  final int netProfit;

  TextChangeEvent(this.income, this.profit, this.netProfit);

}


