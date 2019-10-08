

import 'package:flutter_test/flutter_test.dart';
import 'package:myanmar_tax_calculator/main.dart';
import 'package:myanmar_tax_calculator/src/ui/utils/constant_utils.dart';

main() {
  testWidgets('Lottery Search test', (WidgetTester tester) async {
    // Build our app and trigger a frame.
    await tester.pumpWidget(MyMainApp());

    await tester.enterText(find.byKey(ConstantUtils.KEYS.elementAt(1)), '၁'); // အကြိမ်မြောက်
    await tester.enterText(find.byKey(ConstantUtils.KEYS.elementAt(3)), 'တ ၁၂၃၄၅၆');
    await tester.tap(find.byKey(ConstantUtils.KEYS.elementAt(8)).first);
    await tester.pump();

    // Verify that our counter has incremented.
    expect(find.text('0'), findsNothing);
    expect(find.text('1'), findsOneWidget);
  });
}