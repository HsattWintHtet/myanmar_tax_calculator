

import 'package:myanmar_tax_calculator/src/bloc/rental_service_tax/bloc.dart';

class RentalService {

  int year20182019 = 3;

  Future<RentalServiceState> calculateAll(RentalServiceState state) async {
    double tradingTaxAmount = 0;
    if(state.serviceTypeOptionIndex == 0) {
      if(state.yearOptionIndex == year20182019) {
        if(state.income > 50000000) {
          tradingTaxAmount = (state.income * 5) / (105);
        }
      } else {
        tradingTaxAmount = (state.income * 5) / (105);
      }
    }


    int totalIncome = state.income - tradingTaxAmount.round() - state.expense;

    double basicAllowance = state.totalIncome * 0.2;

    int parentAllowance = 0;
    int parentAllowanceAmount = 1000000;
    if(state.isParentAllowanceIncluded) {
       parentAllowance = state.noOfParents * parentAllowanceAmount;
    }

    int childrenAllowance = 0;
    if(state.noOfChildren > 0) {
      childrenAllowance = state.noOfChildren * state.childrenAllowanceAmount;
    }

    double total25PercentageAllowance = state.income * 0.25;

    double totalDeduction = basicAllowance + state.partnerAllowance + parentAllowance
                        + childrenAllowance
                        + state.partnerInsurance + state.insurance
                        + state.ssb + state.donation;

    int taxableAmount = totalIncome - totalDeduction.round();

    double taxAmount = taxableAmount * 0.1;

    return state.copyWith(
      totalIncome: totalIncome,
      basicAllowance: basicAllowance.round(),
      parentAllowance: parentAllowance,
      childrenAllowance: childrenAllowance,
      totalDeduction: totalDeduction.round(),
      taxableAmount: taxableAmount,
      taxAmount: taxAmount.round(),
      tradingTaxAmount: tradingTaxAmount.round(),
      income25PercentDeduction: total25PercentageAllowance.round()
    );
  }
}