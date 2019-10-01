import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:myanmar_tax_calculator/src/ui/tax/black_income_tax_calculation_page.dart';
import 'package:myanmar_tax_calculator/src/ui/utils/util_package.dart';

Widget build() {
  return new MaterialApp(
      home: Scaffold(
          body: TaxCalculationPage1()));
}

void main() {
  testWidgets('2014-2015 (1000000)', (WidgetTester tester) async {
    await tester.pumpWidget(build());

    await tester.tap(find.byKey(BlackIncomeTaxWidgetKey.YEAR_KEY).at(0)); // 2014-2015
    await tester.pump();
    await tester.pump(const Duration(seconds: 1)); // finish the menu animation

    await tester.enterText(find.byKey(BlackIncomeTaxWidgetKey.COST_KEY), '1000000'); // 1000000
    await tester.pump();
    await tester.pump(const Duration(seconds: 1)); // finish the menu animation

    await tester.enterText(find.byKey(BlackIncomeTaxWidgetKey.INCOME_KEY), '150000'); // 1000000
    await tester.pump();
    await tester.pump(const Duration(seconds: 1)); // finish the menu animation

    var taxable = find.byKey(BlackIncomeTaxWidgetKey.TAXABLE_INCOME_KEY).evaluate().single.widget as Text;
    expect(taxable.data, '850000');

    var tax = find.byKey(BlackIncomeTaxWidgetKey.TAX_KEY).evaluate().single.widget as Text;
    expect(tax.data, '25500');

  });

  testWidgets('2014-2015 (2000000000)', (WidgetTester tester) async {
    await tester.pumpWidget(build());

    await tester.tap(find.byKey(BlackIncomeTaxWidgetKey.YEAR_KEY).at(0)); // 2014-2015
    await tester.pump();
    await tester.pump(const Duration(seconds: 1)); // finish the menu animation

    await tester.enterText(find.byKey(BlackIncomeTaxWidgetKey.COST_KEY), '2000000000'); // 1000000
    await tester.pump();
    await tester.pump(const Duration(seconds: 1)); // finish the menu animation

    await tester.enterText(find.byKey(BlackIncomeTaxWidgetKey.INCOME_KEY), '0'); // 1000000
    await tester.pump();
    await tester.pump(const Duration(seconds: 1)); // finish the menu animation

    var taxable = find.byKey(BlackIncomeTaxWidgetKey.TAXABLE_INCOME_KEY).evaluate().single.widget as Text;
    expect(taxable.data, '2000000000');

    var tax = find.byKey(BlackIncomeTaxWidgetKey.TAX_KEY).evaluate().single.widget as Text;
    expect(tax.data, '323000000');

  });

  testWidgets('2016-2017 (1000000)', (WidgetTester tester) async {
    await tester.pumpWidget(build());

    await tester.tap(find.byKey(BlackIncomeTaxWidgetKey.YEAR_KEY).last);
    await tester.pump();
    await tester.pump(const Duration(seconds: 1)); // finish the menu animation

    await tester.tap(find.text('၂၀၁၆-၂၀၁၇').last);
    await tester.pump();
    await tester.pump(const Duration(seconds: 1)); // finish the menu animation

    await tester.enterText(find.byKey(BlackIncomeTaxWidgetKey.COST_KEY), '1000000'); // 1000000
    await tester.pump();
    await tester.pump(const Duration(seconds: 1)); // finish the menu animation

    await tester.enterText(find.byKey(BlackIncomeTaxWidgetKey.INCOME_KEY), '150000'); // 1000000
    await tester.pump();
    await tester.pump(const Duration(seconds: 1)); // finish the menu animation

    var taxable = find.byKey(BlackIncomeTaxWidgetKey.TAXABLE_INCOME_KEY).evaluate().single.widget as Text;
    expect(taxable.data, '850000');

    var tax = find.byKey(BlackIncomeTaxWidgetKey.TAX_KEY).evaluate().single.widget as Text;
    expect(tax.data, '127500');

  });

  testWidgets('2016-2017 (2000000000)', (WidgetTester tester) async {
    await tester.pumpWidget(build());

    await tester.tap(find.byKey(BlackIncomeTaxWidgetKey.YEAR_KEY).last);
    await tester.pump();
    await tester.pump(const Duration(seconds: 1)); // finish the menu animation

    await tester.tap(find.text('၂၀၁၆-၂၀၁၇').last);
    await tester.pump();
    await tester.pump(const Duration(seconds: 1)); // finish the menu animation

    await tester.enterText(find.byKey(BlackIncomeTaxWidgetKey.COST_KEY), '2000000000'); // 1000000
    await tester.pump();
    await tester.pump(const Duration(seconds: 1)); // finish the menu animation

    await tester.enterText(find.byKey(BlackIncomeTaxWidgetKey.INCOME_KEY), '0'); // 1000000
    await tester.pump();
    await tester.pump(const Duration(seconds: 1)); // finish the menu animation

    var taxable = find.byKey(BlackIncomeTaxWidgetKey.TAXABLE_INCOME_KEY).evaluate().single.widget as Text;
    expect(taxable.data, '2000000000');

    var tax = find.byKey(BlackIncomeTaxWidgetKey.TAX_KEY).evaluate().single.widget as Text;
    expect(tax.data, '588500000');

  });
}