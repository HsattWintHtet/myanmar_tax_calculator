// Imports the Flutter Driver API
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:myanmar_tax_calculator/src/ui/tax/corporate_tax_page.dart';
import 'package:myanmar_tax_calculator/src/ui/utils/util_package.dart';

final Map<int, String> corporateTypes = {
  0: 'ကုမ္ပဏီ',
  1: 'ပြည်ပနေနိုင်ငံခြားသား',
  2: 'နိုင်ငံပိုင်စီးပွားရေးအဖွဲ့အစည်းများ',
};

final Map<int, String> serviceTaxTypes = {
  0: 'ကုန်သွယ်လုပ်ငန်းခွန် မကျသင့်ပါ။',
  1: 'ပကုန်သွယ်လုပ်ငန်းခွန် ၅% ကျသင့်ပါသည်။',
};

final Map<int, String> yearList = {
  0: '၂၀၁၅-၂၀၁၆',
  1: '၂၀၁၆-၂၀၁၇',
  2: '၂၀၁၇-၂၀၁၈',
  3: '၂၀၁၈-၂၀၁၉',
};


Widget build() {
  return new MaterialApp(
      home: Scaffold(
      body: CorporateTaxCalculationPage()));
}

void main() {
  testWidgets('Corporate Tax 2015-2016', (WidgetTester tester) async {
    await tester.pumpWidget(build());

    await tester.tap(find.byKey(CorporateTaxWidgetKey.YEAR_WIDGET_KEY));
    await tester.pump();
    await tester.pump(const Duration(seconds: 1)); // finish the menu animation

    await tester.tap(find.text('၂၀၁၅-၂၀၁၆').last);
    await tester.pump();
    await tester.pump(const Duration(seconds: 1)); // finish the menu animation


    await tester.tap(find.byKey(CorporateTaxWidgetKey.BIZ_TYPE_WIDGET_KEY));
    await tester.pump();
    await tester.pump(const Duration(seconds: 1)); // finish the menu animation

    await tester.tap(find.text('ကုမ္ပဏီ').last);
    await tester.pump();
    await tester.pump(const Duration(seconds: 1)); // finish the menu animation

    await tester.enterText(find.byKey(CorporateTaxWidgetKey.INCOME_WIDGET_KEY), '1000000');
    await tester.pump();
    await tester.pump(const Duration(seconds: 1)); // finish the menu animation

    await tester.tap(find.text('အခြား'));
    await tester.pump();
    await tester.pump(const Duration(seconds: 1)); // finish the menu animation



//    await tester.enterText(find.byKey(CorporateTaxWidgetKey.PRODUCTION_COST_WIDGET_KEY), '100000');
//    await tester.pump();
//    await tester.pump(const Duration(seconds: 1)); // finish the menu animation

    var taxPercent = find.byKey(CorporateTaxWidgetKey.TAX_PERCENT_INPUT_KEY).evaluate().single.widget as Text; // အခွန်ရာခိုင်နှုန်း
    expect(taxPercent.data, '0');

    var taxable = find.byKey(CorporateTaxWidgetKey.AMOUNT_BIZ_TAX_WIDGET_KEY).evaluate().single.widget as Text; // ၃။ ကျသင့်ကုန်သွယ်လုပ်ငန်းခွန် (ဝင်ငွေ x အခွန်ရာခိုင်နှုန်း)/(၁၀၀+အခွန်ရာခိုင်နှုန်း)
    expect(taxable.data, '0');

    var amtNotIncluded = find.byKey(CorporateTaxWidgetKey.AMT_NOT_INCLUDED_WIDGET_KEY).evaluate().single.widget as Text; // ၄။ ကုန်သွယ်လုပ်ငန်းခွန်မပါရငွေ (၂ - ၃)
    expect(amtNotIncluded.data, '1000000');


    var rawProfit = find.byKey(CorporateTaxWidgetKey.BASIC_PROFIT_WIDGET_KEY).evaluate().single.widget as Text;
    expect(rawProfit.data, '900000');

    await tester.enterText(find.byKey(CorporateTaxWidgetKey.MGNT_COST_WIDGET_KEY), '50000');
    await tester.pump();
    await tester.pump(const Duration(seconds: 1)); // finish the menu animation


    await tester.enterText(find.byKey(CorporateTaxWidgetKey.DEPRECIATION_WIDGET_KEY), '100000');
    await tester.pump();
    await tester.pump(const Duration(seconds: 1)); // finish the menu animation

    var netProfit = find.byKey(CorporateTaxWidgetKey.NET_PROFIT_WIDGET_KEY).evaluate().single.widget as Text;
    expect(netProfit.data, '750000');

    var tax = find.byKey(CorporateTaxWidgetKey.TAX_AMOUNT_WIDGET_KEY).evaluate().single.widget as Text;
    expect(tax.data, '187500');


  });


}

