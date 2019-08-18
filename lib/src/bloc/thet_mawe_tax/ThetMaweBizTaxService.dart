

import 'package:ird_myanmar_app/src/bloc/thet_mawe_tax/bloc.dart';
import 'package:ird_myanmar_app/src/services/tax_calculator.dart';
import 'package:ird_myanmar_app/src/ui/utils/constant_utils.dart';

class ThetMaweBizService {

  TaxCalculator _taxCalculator = TaxCalculator();
  int year2017 = 2;
  int year2018 = 3;
  int targetTaxAmount = 4800000;

  int partnerAllowAmtIn2015Year = 500000;
  int partnerAllowAmtInAllYear = 1000000;

  int childrenAllowAmtIn2015Year = 300000;
  int childrenAllowAmtInAllYear = 500000;

  int yr2015 = 0;

  final Map<int, List> yearList = {
    0: [15000000],
    1: [20000000],
    2: [20000000],
    3: [50000000],
  };

  final Map<int, String> _businessTax = {
    0: 'မကျသင့်ပါ။',
    1: '၅% ကျသင့်ပါသည်။'
  };

  List<RuleItem> ruleItems = [
    RuleItem('၂,၀၀၀,၀၀၁ မှ ၅,၀၀၀,၀၀၀ ထိ', '၅%', 2000001, 5000000, 5),
    RuleItem('၅,၀၀၀,၀၀၁ မှ ၁၀,၀၀၀,၀၀၀ ထိ', '၁၀%', 5000001, 10000000, 10),
    RuleItem('၁၀,၀၀၀,၀၀၁ မှ ၂၀,၀၀၀,၀၀၀ ထိ', '၁၅%', 10000001, 20000000, 15),
    RuleItem('၂၀,၀၀၀,၀၀၁ မှ ၃၀,၀၀၀,၀၀၀ ထိ', '၂၀%', 20000001, 30000000, 20),
    RuleItem('၃၀,၀၀၀,၀၀၁ နှင့်အထက်', '၂၅%', 30000001, double.infinity, 25),
  ];

  int otherBizType = 1;

  Future<ThetMaweBizTaxState> calculateAll(ThetMaweBizTaxState state) async {

    String serviceTypeTaxDesc = _businessTax[0];
    double tradingTaxAmount = 0;
    if(state.bizTypeOptionIndex == otherBizType) {
      if(state.income > yearList[state.yearOptionIndex][0]) {
        serviceTypeTaxDesc = _businessTax[1];
        tradingTaxAmount = (state.income * 5) /
            105; // ဝင်ငွေ x အခွန်ရာခိုင်နှုန်း)/(၁၀၀ + အခွန်ရာခိုင်နှုန်း)
      }
    }


    int totalIncome = state.income - state.expense;

    double basicAllowance = 0;
    if (totalIncome > 0) {
      ///အခြေခံသက်သာခွင့် (စုစုပေါင်းဝင်ငွေ၏ ၂၀% ကျပ်သိန်း ၁၀၀ ထိ)
      if(totalIncome > 10000000) {
        basicAllowance = 10000000 * 0.2;
      } else {
        basicAllowance = totalIncome * 0.2;
      }
    }

    int childrenAllowanceRate = childrenAllowAmtInAllYear;
    bool isParentIncluded = true;
    if(state.yearOptionIndex == 0) {
      childrenAllowanceRate = childrenAllowAmtIn2015Year;
      isParentIncluded = false;
    }

    int parentAllowance = 0;
    if (state.isParentAllowanceIncluded && state.noOfParent > 0) {
      parentAllowance = 1000000 * state.noOfParent;
    }

    int childrenAllowance = 0;
    if(state.noOfChildren > 0) {
      childrenAllowance = childrenAllowanceRate *
          state.noOfChildren;
    }

    int partnerAllowanceRate = 0;
    if(state.maritalStatusOptionIndex == 0 ) {
      if(state.yearOptionIndex == 0) {
        partnerAllowanceRate = partnerAllowAmtIn2015Year;
      } else {
        partnerAllowanceRate = partnerAllowAmtInAllYear;
      }
    }

    int totalReduction = basicAllowance.round()
        + parentAllowance
        + partnerAllowanceRate
        + childrenAllowance
        + state.partnerInsurance
        + state.insurance
        + state.partnerInsurance
        + state.ssbAmount
        + state.donationAmount;

    int taxableAmount = totalIncome - totalReduction;

    double taxAmount = 0;
    if(taxableAmount > 0) {
      taxAmount = await _taxCalculator.calculateTax(
          ruleItems, taxableAmount.toDouble());
    }

    return state.copyWith(
        serviceTypeTaxDesc: serviceTypeTaxDesc,
        tradingTaxAmount: tradingTaxAmount.round(),
        totalIncome: totalIncome,
        basicAllowance: basicAllowance.round(),
        isParentAllowanceIncluded: isParentIncluded,
        parentAllowance: parentAllowance,
        childrenAllowance: childrenAllowance,
        partnerAllowance: partnerAllowanceRate,
        totalReductionAmount: totalReduction,
        taxableAmount: taxableAmount,
        taxAmount: taxAmount.round(),
        childrenAllowanceRate: childrenAllowanceRate,
    );
  }
}