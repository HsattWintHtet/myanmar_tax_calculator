

import 'package:myanmar_tax_calculator/src/bloc/profit_tax/bloc.dart';

class ProfitService {

  ProfitState calculateAll(ProfitState currentState) {
    currentState = currentState.copyWith(
      sellingPrice: calculateSellingPriceAmount(currentState.inHandPricing, currentState.depreciation)
    ).copyWith(
      totalAllowrance: calculateAllowranceAmount(currentState.sellingPrice, currentState.additionalValue, currentState.marketingCost)
    ).copyWith(
      profit: calculateProfit(currentState.pricingByOrg, currentState.totalAllowrance),
    ).copyWith(
      taxAmount: calculateTax(currentState.profit).round()
    );
    return currentState;
  }

  int calculateSellingPriceAmount(int inHandPricing, int depreciation) {
    return inHandPricing - depreciation;
  }

  int calculateAllowranceAmount(int sellingPrice, int additionalValue, int marketingCost) {
    return sellingPrice + additionalValue + marketingCost;
  }

  int calculateProfit(int pricingByOrg, int allowrance) {
    return pricingByOrg - allowrance;
  }

  double calculateTax(int profit) {
    return profit * 0.1;
  }
}