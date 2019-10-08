import 'package:flutter/material.dart';
import 'package:flutter_driver/driver_extension.dart';
import 'package:myanmar_tax_calculator/src/ui/tax/corporate_tax_page.dart';

void main() {
  // This line enables the extension
  enableFlutterDriverExtension();

  // Call the `main()` function of your app or call `runApp` with any widget you
  // are interested in testing.
  runApp(new CorporateTaxCalculationPage());
}