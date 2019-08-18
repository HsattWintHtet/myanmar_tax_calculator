
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

@immutable
abstract class ProfitEvent extends Equatable {
  ProfitEvent([List props = const []]) : super(props);
}

class YearOptionChangeEvent extends ProfitEvent{
  final yearOptionIndex;

  YearOptionChangeEvent(this.yearOptionIndex);
}

class PricingByOrgChangeEvent extends ProfitEvent{
  final pricingByOrg;

  PricingByOrgChangeEvent(this.pricingByOrg);
}

class InHandPricingChangeEvent extends ProfitEvent{
  final inHandPricing;

  InHandPricingChangeEvent(this.inHandPricing);
}

class DepreciationChangeEvent extends ProfitEvent{
  final depreciationPricing;

  DepreciationChangeEvent(this.depreciationPricing);
}

class MarketingCostChangeEvent extends ProfitEvent{
  final marketingCost;

  MarketingCostChangeEvent(this.marketingCost);
}

class AdditionalValueChangeEvent extends ProfitEvent{
  final additionalValue;

  AdditionalValueChangeEvent(this.additionalValue);
}


class ClearEvent extends ProfitEvent {
  ClearEvent();
}