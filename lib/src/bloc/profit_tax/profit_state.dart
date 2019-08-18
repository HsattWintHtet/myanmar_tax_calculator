

import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

@immutable
class ProfitState extends Equatable {

  final int yearOptionIndex;
  final String startYear;
  final String endYear;

  final int pricingByOrg;
  final int inHandPricing;
  final int depreciation;
  final int sellingPrice;
  final int totalAllowrance;
  final int profit;
  final int taxAmount;
  final int marketingCost;
  final int additionalValue;

  ProfitState({
    @required this.yearOptionIndex,
    @required this.startYear,
    @required this.endYear,
    @required this.pricingByOrg,
    @required this.inHandPricing,
    @required this.depreciation,
    @required this.sellingPrice,
    @required this.totalAllowrance,
    @required this.profit,
    @required this.taxAmount,
    @required this.marketingCost,
    @required this.additionalValue,
  }) : super([
    yearOptionIndex,
    startYear,
    endYear,
    pricingByOrg,
    inHandPricing,
    depreciation,
    sellingPrice,
    totalAllowrance,
    profit,
    taxAmount,
    marketingCost,
    additionalValue
  ]);

  factory ProfitState.initial() {
    return ProfitState(
      yearOptionIndex: 0,
      startYear:'၂၀၁၄',
      endYear:'၂၀၁၅',
      pricingByOrg: 0,
      inHandPricing: 0,
      depreciation: 0,
      sellingPrice: 0,
      totalAllowrance: 0,
      profit: 0,
      taxAmount: 0,
      marketingCost: 0,
      additionalValue:0,
    );
  }

  ProfitState copyWith({
    int yearOptionIndex,
    String startYear,
    String endYear,
    int pricingByOrg,
    int inHandPricing,
    int depreciationPricing,
    int sellingPrice,
    int totalAllowrance,
    int profit,
    int taxAmount,
    int marketingCost,
    int additionalValue,
  }) {
    return ProfitState(
      yearOptionIndex: yearOptionIndex ?? this.yearOptionIndex,
      startYear: startYear ?? this.startYear,
      endYear: endYear ?? this.endYear,
      pricingByOrg: pricingByOrg ?? this.pricingByOrg,
      inHandPricing: inHandPricing ?? this.inHandPricing,
      depreciation: depreciationPricing ?? this.depreciation,
      sellingPrice: sellingPrice ?? this.sellingPrice,
      totalAllowrance: totalAllowrance ?? this.totalAllowrance,
      profit: profit ?? this.profit,
      taxAmount: taxAmount ?? this.taxAmount,
      marketingCost: marketingCost ?? this.marketingCost,
      additionalValue: additionalValue ?? this.additionalValue,
    );
  }

  @override
  String toString() {
    return '''ProfitState {
      yearOptionIndex: $yearOptionIndex,
      startYear: $startYear,
      endYear: $endYear,
      pricingByOrg: $pricingByOrg,
      inHandPricing: $inHandPricing,
      depreciationPricing: $depreciation,
      salingPrice: $sellingPrice,
      totalAllowrance: $totalAllowrance,
      profit: $profit,
      taxAmount: $taxAmount,
      marketingCost: $marketingCost,
      additionalValue: $additionalValue
    }''';
  }
}