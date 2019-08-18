

import 'package:ird_myanmar_app/src/bloc/black_income_tax/black_income_state.dart';
import 'package:ird_myanmar_app/src/services/tax_calculator.dart';
import 'package:ird_myanmar_app/src/ui/tax/black_income_tax_calculation_page.dart';
import 'package:ird_myanmar_app/src/ui/utils/constant_utils.dart';
import 'package:test_api/test_api.dart';

void main() {

  group("year 2014", ()
  {
    List<RuleItem> yr14items = [
      RuleItem("","",1, 100000000, 3),
      RuleItem("","",100000001, 500000000, 5),
      RuleItem("","",500000001, 1000000000, 10),
      RuleItem("","",1000000001, 1500000000, 20),
      RuleItem("","", 1500000001, double.infinity, 30),
    ];

    test('tax calculation based on 200,000', () {
      final calculator = TaxCalculator();
      calculator.calculateTax(yr14items, 200000).then((value) {
        expect(value, 6000);
      });
    });

    test('tax calculation based on 100,000,000', () {
      final calculator = TaxCalculator();

      calculator.calculateTax(yr14items, 100000000).then((value) {
        expect(value, 3000000);
      });
    });

    test('tax calculation based on 200,000,000', () {
      final calculator = TaxCalculator();

      calculator.calculateTax(yr14items, 200000000).then((value) {
        expect(value, 8000000);
      });
    });

    test('tax calculation based on 16,000,00,000', () {
      final calculator = TaxCalculator();

      calculator.calculateTax(yr14items, 1600000000).then((value) {
        expect(value, 203000000);
      });
    });
  });

  group("year 2017", ()
  {
    List<RuleItem> yr17items = [
      RuleItem("","",1, 30000000, 15),
      RuleItem("","", 30000001, 100000000, 20),
      RuleItem("","",100000001, double.infinity, 30),
    ];


    test('tax calculation based on 200,000', () {
      final calculator = TaxCalculator();
      calculator.calculateTax(yr17items, 200000).then((value) {
        expect(value, 30000);
      });
    });

    test('tax calculation based on 100,000,000', () {
      final calculator = TaxCalculator();

      calculator.calculateTax(yr17items, 100000000).then((value) {
        expect(value, 18500000);
      });
    });

    test('tax calculation based on 200,000,000', () {
      final calculator = TaxCalculator();

      calculator.calculateTax(yr17items, 200000000).then((value) {
        expect(value, 48500000);
      });
    });

    test('tax calculation based on 16,000,00,000', () {
      final calculator = TaxCalculator();

      calculator.calculateTax(yr17items, 1600000000).then((value) {
        expect(value, 468500000);
      });
    });
  });
}