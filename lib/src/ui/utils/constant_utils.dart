import 'package:firebase_remote_config/firebase_remote_config.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:myanmar_tax_calculator/src/ui/model/LotteryResultUIParam.dart';

class ConstantUtils {

  static const int MAXIMUM_CLAIM_AMOUNT = 100000000;

  static const int INPUT_FIELD_LENGTH = 25;

  // this data will get from firebase remote config
  static String BASE_URL = "https://www.localhost.com";

  static const String APP_NAME = 'တွက်ချက်';
  static const String APP_DESCRIPTION = 'a Tax Calculator based on Internal Revenue website.';

  static final KEYS = {
    Key('1'), Key('2'), Key('3'),Key('4'),
    Key('5'),Key('6'),Key('7'),Key('8'),Key('9')
  };

  static void showSnackBar(String msg, BuildContext context) {
    final snackBar = SnackBar(
      content: Text(msg),
      action: SnackBarAction(
        label: 'close',
        onPressed: () {
          // Some code to undo the change!
        },
      ),
    );
    // Find the Scaffold in the Widget tree and use it to show a SnackBar!
    Scaffold.of(context).showSnackBar(snackBar);
  }

  static void progressLoadingDialog(String title, BuildContext context) {
    AlertDialog dialog = AlertDialog(
      title: new Text(title),
      content: new Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          SpinKitWave(
            itemBuilder: (_, int index) {
              return DecoratedBox(
                decoration: BoxDecoration(
                  color: Colors.blue,
                ),
              );
            },
          ),
        ],
      ),

      actions: <Widget>[
        // usually buttons at the bottom of the dialog
        // do nothing.

      ],
    );

    // flutter defined function
    showDialog(
      context: context,
      child: new WillPopScope(
        onWillPop: () => new Future.value(false),
        child: dialog,
      ),
      //barrierDismissible: false,
    );
  }

  static void showResultDialog(String title, String message, BuildContext context) {

    AlertDialog dialog = AlertDialog(
      title: new Text(title),
      content: new Text(message),
      actions: <Widget>[
        // usually buttons at the bottom of the dialog
        new FlatButton(
          child: new Text("Close"),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
      ],
    );

    // flutter defined function
    showDialog(
      context: context,
      child: dialog,
      barrierDismissible: false,
    );
  }
}


class TaxConstantUtil {
  static final List<BusinessType> businessTypeRules = [
    BusinessType('ကုမ္ပဏီ', '(အသားတင်အမြတ်၏ - ၂၅%)', 0.25),
    BusinessType('ပြည်ပနေနိုင်ငံခြားသား', '(အသားတင်အမြတ်၏ - ၃၅%)', 0.35),
    BusinessType(
        'နိုင်ငံပိုင်စီးပွားရေးအဖွဲ့အစည်းများ', '(အသားတင်အမြတ်၏ - ၂၅%)', 0.25),
  ];

  static final List<YearlyTaxType> yearInfoMap = [
    YearlyTaxType('၂၀၁၄ ခုနှစ် ပြည်ထောင်စု၏ အခွန်အကောက်ဥပဒေပုဒ်မ ၁၁(ဂ) ပါ ကုန်စည်များနှင့် ပုဒ်မ ၁၁(စ) ပါ ဝန်ဆောင်မှုများမှ အပရောင်းရငွေကျပ်သိန်း (၁၅၀) ကျော်လျှင် ကုန်သွယ်လုပ်ငန်းခွန် ကျသင့်သည်။', 15000000),
    YearlyTaxType('၂၀၁၅ ခုနှစ် ပြည်ထောင်စု၏ အခွန်အကောင်ဥပဒေ ပုဒ်မ ၁၁(ဂ) ပါ ကုန်စည်များနှင့် ပုဒ်မ ၁၁(စ) ပါ ဝန်ဆောင်မှုများမှအပ ရေင်းရငွေကျပ်သိန်း (၂၀၀) ကျော်လျှင် ကုန်သွယ်လုပ်ငန်းခွန် ကျသင့်သည်။', 20000000),
    YearlyTaxType('၂၀၁၆ ခုနှစ် ပြည်ထောင်စု၏ အခွန်အကောက်ဥပဒေပုဒ်မ ၁၄(က) ပါ ကုန်ပစ္စည်းများနှင့် ပုဒ်မ ၁၄(ဃ)ပါ ဝန်ဆောင်မှုများမှအပ ရောင်းရငွေကျပ်သိန်း (၂၀၀) ကျော်လျှင် ကုန်သွယ်လုပ်ငန်းခွန် ကျသင့်သည်။', 20000000),
    YearlyTaxType('၂၀၁၆ ခုနှစ် ပြည်ထောင်စု၏ အခွန်အကောက်ဥပဒေပုဒ်မ ၁၄(က) ပါ ကုန်ပစ္စည်းများနှင့် ပုဒ်မ ၁၄(ဃ)ပါ ဝန်ဆောင်မှုများမှအပ ရောင်းရငွေကျပ်သိန်း (၂၀၀) ကျော်လျှင် ကုန်သွယ်လုပ်ငန်းခွန် ကျသင့်သည်။', 20000000)
  ];

  List<RuleItem> items = [
    RuleItem('၂,၀၀၀,၀၀၁ မှ ၅,၀၀၀,၀၀၀ ထိ', '၅%', 2000001, 5000000, 5),
    RuleItem('၅,၀၀၀,၀၀၁ မှ ၁၀,၀၀၀,၀၀၀ ထိ', '၁၀%', 5000001, 10000000, 10),
    RuleItem('၁၀,၀၀၀,၀၀၁ မှ ၂၀,၀၀၀,၀၀၀ ထိ', '၁၅%', 10000001, 20000000, 15),
    RuleItem('၂၀,၀၀၀,၀၀၁ မှ ၃၀,၀၀၀,၀၀၀ ထိ', '၂၀%', 20000001, 30000000, 20),
    RuleItem('၃၀,၀၀၀,၀၀၁ နှင့်အထက်', '၂၅%', 30000001, double.infinity, 25),
  ];

  // based on 2014 rule. It is for show.
  List<RuleItem> _incomeTaxRules = [
    RuleItem('၁ မှ ၂,၀၀၀,၀၀၀ ထိ', '၀%', 1, 2000000, 0),
    RuleItem('၂,၀၀၀,၀၀၁ မှ ၅,၀၀၀,၀၀၀ ထိ', '၅%', 2000001, 5000000, 5),
    RuleItem('၅,၀၀၀,၀၀၁ မှ ၁၀,၀၀၀,၀၀၀ ထိ', '၁၀%', 5000001, 10000000, 10),
    RuleItem('၁၀,၀၀၀,၀၀၁ မှ ၂၀,၀၀၀,၀၀၀ ထိ', '၁၅%', 10000001, 20000000, 15),
    RuleItem('၂၀,၀၀၀,၀၀၁ မှ ၃၀,၀၀၀,၀၀၀ ထိ', '၂၀%', 20000001, 30000000, 20),
    RuleItem('၃၀,၀၀၀,၀၀၁ နှင့်အထက်', '၂၅%', 30000001, double.infinity, 25),
  ];
}


class RuleItem {
  String rangeAmount;
  String percentage;

  double startAmount;
  double endAmount;
  double taxPercentage; // percentage

  RuleItem(this.rangeAmount, this.percentage, this.startAmount, this.endAmount, this.taxPercentage);

  @override
  String toString() {
    return '''RuleItem {
      rangeAmount: $rangeAmount,
      percentage: $percentage,
      startAmount: $startAmount,
      endAmount: $endAmount,
      taxPercentage: $taxPercentage,
    }''';
  }
}

class YearlyTaxType {
  String type;

  double limitTaxAmount; // percentage

  YearlyTaxType(this.type, this.limitTaxAmount);
}

class BusinessType {
  String type;
  String percentage;

  double taxPercentage; // percentage

  BusinessType(this.type, this.percentage, this.taxPercentage);
}

class LotterySearchUtil {

  static void clearTextField(GlobalKey<FormState> formKey) {
    formKey.currentState?.reset();
  }


  static String bakedResultParam(LotteryResultUIParam lotteryParam) {
    String _param = '';
    switch (lotteryParam.checkingType) {
      case '1': // find by single number:(က ၁၂၃၄၅၆)
        _param = lotteryParam.character1;
        break;

      case '2': // find by character range: char char number(က ည ၁၂၃၄၅၆)
        _param =
        '${lotteryParam.character1} ${lotteryParam.character2} ${lotteryParam
            .number1}';
        break;

      case '3': // find by number range: char num1 num2(က ၁၂၃၄၅၆ ၁၂၃၄၅၉)
        _param =
        '${lotteryParam.character1} ${lotteryParam.number1} ${lotteryParam
            .number2}';
        break;
    }
    print('baked param:$_param');
    return _param;
  }
}