
import 'package:ird_myanmar_app/src/bloc/black_income_tax/black_income_state.dart';
import 'package:ird_myanmar_app/src/services/tax_calculator.dart';

class BlackIncomeService {

  TaxCalculator _taxCalculator = TaxCalculator();

  Future<BlackIncomeState> calculateAll(BlackIncomeState currentState) async {
    int taxableAmount = calculateTaxableAmount(currentState.expense, currentState.whiteMoney);
    double tax = await _taxCalculator.calculateTax(currentState.selectedRuleItems, taxableAmount.toDouble());

    return currentState.copyWith(
      taxAmount: tax.round(),
      taxableAmount: taxableAmount
    );
  }

  ///အသားတင်အမြတ် (BasicProfit - managementCost - depreciation)
  int calculateTaxableAmount(int expense, int whiteMoney) {
    return expense - whiteMoney;
  }
}