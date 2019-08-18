

import 'package:ird_myanmar_app/src/bloc/corporate/bloc.dart';
import 'package:ird_myanmar_app/src/ui/utils/constant_utils.dart';

class CorporateService {

  /// calculate following process and update the state object.
  /// @_calculateNotIncludedServiceTax
  /// @_calculateBasicProfit
  /// @_calculateNetProfit
  /// @_calculateTaxAmount
  CorporateState calculateAll(CorporateState currentState) {

    currentState = _calculateAmountOfServiceTax(
        currentState,
        TaxConstantUtil.yearInfoMap[currentState.yearOptionIndex].limitTaxAmount);

    int amountNotIncludedInServiceTax = _calculateNotIncludedServiceTax(currentState.income, currentState.amountOfServiceTax);

    int basicProfit = _calculateBasicProfit(amountNotIncludedInServiceTax, currentState.productionCost);
    int netProfit = _calculateNetProfit(basicProfit, currentState.managementCost, currentState.depreciation);
    int taxAmount = _calculateTaxAmount(netProfit, TaxConstantUtil.businessTypeRules[currentState.bizTypeOptionIndex]
        .taxPercentage);


    currentState = currentState.copyWith(
        amountNotIncludedInServiceTax: amountNotIncludedInServiceTax,
        netProfit: netProfit,
        basicProfit: basicProfit,
        taxAmount: taxAmount
    );
    return currentState;
  }

  ///အသားတင်အမြတ် (BasicProfit - managementCost - depreciation)
  int _calculateNetProfit(int basicProfit, int managementCost, int depreciation) {
    return basicProfit - managementCost - depreciation;
  }

  int _calculateTaxAmount(int netProfit, double taxPercentage) {
    return (netProfit * taxPercentage).round();
  }

  ///အကြမ်းအမြတ် (amountNotIncludedInServiceTax - productionCost)
  int _calculateBasicProfit(int amountNotIncludedInServiceTax, int productionCost) {
    return amountNotIncludedInServiceTax - productionCost;
  }

  ///ကုန်သွယ်လုပ်ငန်းခွန်မပါရငွေ (income - tradeTax)
  int _calculateNotIncludedServiceTax(int income, int amountOfBizTax) {
    return income - amountOfBizTax;
  }

  ///ကျသင့်ကုန်သွယ်လုပ်ငန်းခွန် (ဝင်ငွေ x အခွန်ရာခိုင်နှုန်း)/(၁၀၀+အခွန်ရာခိုင်နှုန်း)
  CorporateState _calculateAmountOfServiceTax(CorporateState currentState, double limitTaxAmount) {
    String taxableDescription = 'ကုန်သွယ်လုပ်ငန်းခွန် မကျသင့်ပါ။';
    int amountOfServiceTax =  ((currentState.income * 5)/(105)).round();
    int taxPercentageOfServiceTax = 0;
    if(currentState.serviceTypeOptionIndex == 1 &&
      currentState.income > limitTaxAmount) {
        taxableDescription = 'ကုန်သွယ်လုပ်ငန်းခွန် ၅% ကျသင့်ပါသည်။';

        amountOfServiceTax = ((currentState.income * 5)/(105)).round();
        taxPercentageOfServiceTax= 5;

    } else {
        amountOfServiceTax = 0;
        taxPercentageOfServiceTax = 0;
    }

    currentState = currentState.copyWith(
        serviceTypeTaxDesc: taxableDescription,
        amountOfServiceTax: amountOfServiceTax,
        taxPercentageOfServiceTax: taxPercentageOfServiceTax
    );
    return currentState;
  }
}