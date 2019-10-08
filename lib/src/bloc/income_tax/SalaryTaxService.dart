

import 'package:myanmar_tax_calculator/src/bloc/income_tax/bloc.dart';
import 'package:myanmar_tax_calculator/src/services/tax_calculator.dart';
import 'package:myanmar_tax_calculator/src/ui/utils/constant_utils.dart';

class SalaryTaxService {

  TaxCalculator _taxCalculator = TaxCalculator();
  int year2016 = 1;
//  int year2018 = 3;
  int targetTaxAmount = 4800000;

  int partnerAllowAmtIn2015Year = 500000;
  int partnerAllowAmtInAllYear = 1000000;

  int childrenAllowAmtIn2015Year = 300000;
  int childrenAllowAmtInAllYear = 500000;

  int yr2015 = 0;

  List<RuleItem> ruleItems = [
    RuleItem('၂,၀၀၀,၀၀၁ မှ ၅,၀၀၀,၀၀၀ ထိ', '၅%', 2000001, 5000000, 5),
    RuleItem('၅,၀၀၀,၀၀၁ မှ ၁၀,၀၀၀,၀၀၀ ထိ', '၁၀%', 5000001, 10000000, 10),
    RuleItem('၁၀,၀၀၀,၀၀၁ မှ ၂၀,၀၀၀,၀၀၀ ထိ', '၁၅%', 10000001, 20000000, 15),
    RuleItem('၂၀,၀၀၀,၀၀၁ မှ ၃၀,၀၀၀,၀၀၀ ထိ', '၂၀%', 20000001, 30000000, 20),
    RuleItem('၃၀,၀၀၀,၀၀၁ နှင့်အထက်', '၂၅%', 30000001, double.infinity, 25),
  ];

  Future<SalaryTaxState> calculateAll(SalaryTaxState state) async {
      int totalMonthlyIncome = 0;
      if (state.income > 0 && state.noOfMonth > 0) {
        totalMonthlyIncome = state.income * state.noOfMonth;
      }

      int totalIncome = totalMonthlyIncome + state.bonus
          + state.pocketMoney
          + state.underTableMoney
          + state.commission
          + state.allowance;

      double reductionAmount = 0;
      if (totalIncome > 0) {
        ///အခြေခံသက်သာခွင့် (စုစုပေါင်းဝင်ငွေ၏ ၂၀% ကျပ်သိန်း ၁၀၀ ထိ)
        if(totalIncome > 10000000) {
          reductionAmount = 10000000 * 0.2;
        } else {
          reductionAmount = totalIncome * 0.2;
        }

      }

      int childrenAllowanceRate = partnerAllowAmtInAllYear;
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

      int totalReduction = reductionAmount.round()
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
      if (state.yearOptionIndex > year2016) {
        if (totalIncome > targetTaxAmount) {
          taxAmount = await _taxCalculator.calculateTax(
              ruleItems, taxableAmount.toDouble());
        }
      } else {
        taxAmount = await _taxCalculator.calculateTax(
            ruleItems, taxableAmount.toDouble());
      }

      return state.copyWith(
          totalMonthlyIncome: totalMonthlyIncome,
          totalIncome: totalIncome,
          basicAllowance: reductionAmount.round(),
          parentAllowance: parentAllowance,
          childrenAllowance: childrenAllowance,
          totalReductionAmount: totalReduction,
          taxableAmount: taxableAmount,
          taxAmount: taxAmount.round(),
          childrenAllowanceRate: childrenAllowanceRate,
          isParentAllowanceIncluded: isParentIncluded
      );
  }
}