// Imports the Flutter Driver API
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:ird_myanmar_app/src/ui/tax/corporate_tax_page.dart';
import 'package:ird_myanmar_app/src/ui/utils/util_package.dart';

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

final Map<int, String> _goodTypesMap = {
  0: '၂၀၁၄ ခုနှစ် ပြည်ထောင်စု၏ အခွန်အကောက်ဥပဒေပုဒ်မ ၁၁(ဂ) ပါ ကုန်စည်များနှင့် ပုဒ်မ ၁၁(စ) ပါ ဝန်ဆောင်မှုများ',
  1: '၂၀၁၅ ခုနှစ် ပြည်ထောင်စု၏ အခွန်အကောင်ဥပဒေ ပုဒ်မ ၁၁(ဂ) ပါ ကုန်စည်များနှင့် ပုဒ်မ ၁၁(စ) ပါ ဝန်ဆောင်မှုများ',
  2: '၂၀၁၆ ခုနှစ် ပြည်ထောင်စု၏ အခွန်အကောက်ဥပဒေပုဒ်မ ၁၄(က)ပါ ကုန်ပစ္စည်းများနှင့် ပုဒ်မ ၁၄(ဃ)ပါ ဝန်ဆောင်မှုများ',
  3: '၂၀၁၆ ခုနှစ် ပြည်ထောင်စု၏ အခွန်အကောက်ဥပဒေပုဒ်မ ၁၄(က)ပါ ကုန်ပစ္စည်းများနှင့် ပုဒ်မ ၁၄(ဃ)ပါ ဝန်ဆောင်မှုများ',
};


Widget build() {
  return new MaterialApp(
      home: Scaffold(
      body: CorporateTaxCalculationPage()));
}

void main() {
  testWidgets('Corporate Tax 2015-2016', (WidgetTester tester) async {
    await tester.pumpWidget(build());

    final yearSelectBoxFinder = find.byKey(CorporateTaxWidgetKey.YEAR_WIDGET_KEY);
    final bizTypeSelectBoxFinder = find.byKey(CorporateTaxWidgetKey.BIZ_TYPE_WIDGET_KEY);
    final incomeInputFinder = find.byKey(CorporateTaxWidgetKey.INCOME_WIDGET_KEY);
    final serviceRadioBtnOneFinder = find.byKey(CorporateTaxWidgetKey.SERVICE_TYPE_OPTION_KEY1);
    final serviceRadioBtnTwoFinder = find.byKey(CorporateTaxWidgetKey.SERVICE_TYPE_OPTION_KEY2);
    final taxPercentInputFinder = find.byKey(CorporateTaxWidgetKey.TAX_PERCENT_INPUT_KEY);
    final taxDescLabelFinder = find.byKey(CorporateTaxWidgetKey.SERVICE_TAX_DESC_WIDGET_KEY);
    final taxAmountInputFinder = find.byKey(CorporateTaxWidgetKey.AMOUNT_TAX_WIDGET_KEY);
    final taxNotIncludedInputFinder = find.byKey(CorporateTaxWidgetKey.AMT_NOT_INCLUDED_WIDGET_KEY);

    await tester.tap(yearSelectBoxFinder);
    await tester.tap(find.text(yearList[0]));
    await tester.pumpAndSettle();


    await tester.tap(find.text(corporateTypes[0])); await tester.pumpAndSettle();

    await tester.tap(find.text(_goodTypesMap[0])); await tester.pumpAndSettle();

    await tester.enterText(incomeInputFinder, '15000000'); await tester.pumpAndSettle();

    await tester.drag(find.byType(ListView), Offset(0.0, -300)); await tester.pump(); // flush the widget tree

    final productionCostInputFinder = find.byKey(CorporateTaxWidgetKey.PRODUCTION_COST_WIDGET_KEY);
    final basicProfitInputFinder = find.byKey(CorporateTaxWidgetKey.BASIC_PROFIT_WIDGET_KEY);
    final mgntCostInputFinder = find.byKey(CorporateTaxWidgetKey.MGNT_COST_WIDGET_KEY);
    final depreciationInputFinder = find.byKey(CorporateTaxWidgetKey.DEPRECIATION_WIDGET_KEY);
    final netProfitInputFinder = find.byKey(CorporateTaxWidgetKey.NET_PROFIT_WIDGET_KEY);
    final totalTaxInputFinder = find.byKey(CorporateTaxWidgetKey.TAX_AMOUNT_WIDGET_KEY);

    await tester.enterText(productionCostInputFinder, '100000'); await tester.pumpAndSettle();
    await tester.enterText(find.byKey(CorporateTaxWidgetKey.MGNT_COST_WIDGET_KEY), '200000'); await tester.pumpAndSettle();
    await tester.enterText(depreciationInputFinder, '300000'); await tester.pumpAndSettle();


    var text = totalTaxInputFinder.evaluate().single.widget as Text;
    print('tax amount: ${text.data}');
//    expect(find.text('3600000'), findsOneWidget);
//    expect(find.text('14400000'), findsOneWidget);
//    expect(find.text('15000000'), findsOneWidget);
//    expect(find.text('3600000'), findsOneWidget);
//    var text = finder.evaluate().single.widget as Text;
//    print(text.data);
//
//    expect(find.text(TaxConstantUtil.yearInfoMap[0].type), findsOneWidget);
//    expect(find.text(_goodTypesMap[0]), findsOneWidget);

  });


}

