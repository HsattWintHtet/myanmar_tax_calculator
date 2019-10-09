import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:logging/logging.dart';
import 'package:myanmar_tax_calculator/src/bloc/black_income_tax/bloc.dart';
import 'package:myanmar_tax_calculator/src/services/tax_calculator.dart';
import 'package:myanmar_tax_calculator/src/ui/utils/constant_utils.dart';

/// စည်းကြပ်မှုမှလွတ်ကင်းနေသောဝင်ငွေခွန် တွက်ချက်ခြင်း
class TaxCalculationPage1 extends StatefulWidget {
  @override
  _MyAppState createState() => new _MyAppState();
}

class Item {
  String rangeAmount;
  String percentage;

  double startAmount;
  double endAmount;
  double taxPercentage; // percentage

  Item(this.rangeAmount, this.percentage, this.startAmount, this.endAmount, this.taxPercentage);
}

class InputData{
  double totalCost = 0 ;
  double reductionAmount = 0;
}

class _MyAppState extends State<TaxCalculationPage1> {

  final Logger log = new Logger('black_income_tax_page');
  final _formKey = GlobalKey<FormState>();

  final BlackIncomeTaxBloc _blackIncomeBloc = BlackIncomeTaxBloc();

  int _selectedIndex = 0;

  final InputData data = InputData();

  TaxCalculator _taxCalculator;



  Map<int, List<Item>> _taxCalRange;

  String _startYear;
  String _endYear;

  double _eligibleTaxAmt = 0.0;

  var _focusNode = new FocusNode();

  final _expenseInputController = TextEditingController();
  final _whiteMoneyInputController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _expenseInputController.addListener(_onExpenseTextChange);
    _whiteMoneyInputController.addListener(_onWhiteMoneyTextChange);
  }

  void _onWhiteMoneyTextChange() {
    _blackIncomeBloc.dispatch(WhiteMoneyTextChangeEvent(
        int.tryParse(_whiteMoneyInputController.text)==null?
        0 : int.parse(_whiteMoneyInputController.text)));
  }

  void _onExpenseTextChange() {
    _blackIncomeBloc.dispatch(ExpenseTextChangeEvent(
        int.tryParse(_expenseInputController.text)==null?
        0 : int.parse(_expenseInputController.text)));
  }

  @override
  void dispose() {
    // Clean up the controller when the Widget is disposed
    _expenseInputController.dispose();
    _whiteMoneyInputController.dispose();

    _blackIncomeBloc.dispose();

    super.dispose();
  }


  void _clearTextField() {
    _expenseInputController.clear();
    _whiteMoneyInputController.clear();

    _blackIncomeBloc.dispatch(ClearEvent());
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder(
      bloc: _blackIncomeBloc,
      builder: (BuildContext context, BlackIncomeState state) {
        return Form(
            key: _formKey,
            child: ListView(
                shrinkWrap: true,
                padding: const EdgeInsets.all(20.0),
                children: <Widget>[
                  Container(
                      alignment: Alignment.center,
                      padding: EdgeInsets.only(bottom:15.0, top:8.0),
                      child:new Text(
                        'စည်းကြပ်မှုမှလွတ်ကင်းနေသောဝင်ငွေခွန် တွက်ချက်ခြင်း',
                        style: new TextStyle(
                          fontSize: 14.0,
                          fontWeight: FontWeight.bold,
                        ),
                      )
                  ),
                  DropdownButtonHideUnderline(
                    child: InputDecorator(
                      decoration: const InputDecoration(
                        labelText: 'စည်းကြပ်နှစ်',
                        contentPadding: EdgeInsets.zero,
                      ),
                      isEmpty: false,
                      child: DropdownButton<int>(
                        value: state.yearOptionIndex,
                        onChanged: (int newValue) {
                          log.info('newvalue $newValue');
                          _blackIncomeBloc.dispatch(YearOptionChangeEvent(newValue));
                        },
                        items: _blackIncomeBloc.yearList.entries.map((MapEntry<int, String> e) {
                          return DropdownMenuItem<int>(
                            value: e.key,
                            child: Text(e.value),
                          );
                        }).toList(),
                      ),
                    ),
                  ),
                  Text('ဝင်ငွေကာလ (၁-၄-${state.startYear}) မှ (၃၁-၃-${state.endYear}) ထိ'
                      ,style: TextStyle(fontSize: 12.0,color: Colors.blueGrey)),
                  new Padding(
                    padding: new EdgeInsets.all(8.0),
                  ),
                  TextFormField(
                    controller: _expenseInputController,
                      decoration: InputDecoration(
                        labelText: 'ဝယ်ယူ/တည်ဆောက်/ပြုပြင်သည့်တန်ဖိုး',
                        labelStyle: new TextStyle(fontSize: 12.0),
                        hintText: "0",
                        counterText: '',
                      ),
                      maxLength: ConstantUtils.INPUT_FIELD_LENGTH,
                      validator: (value) {
                        if (value.isEmpty) {
                          return 'ရိုက်ထည့်ပေးပါ';
                        }
                      },
                      keyboardType: TextInputType.number,
                  ),
                  Container(
                    child: IconButton(
                      icon: Icon(Icons.info,color: Colors.blue,),
                      tooltip: '(သက်ဆိုင်ရာတိုင်းဒေသကြီး/ပြည်နယ် (သို့မဟုတ်) မြို့နယ်အလိုက်တန်ဖိုးစိစစ်သတ်မှတ်ရေးအဖွဲမှ သတ်မှတ်ထားသည့်တန်ဖိုး)',
                    ),
                    alignment: Alignment.centerLeft,
                  ),
                  TextFormField(
                    controller: _whiteMoneyInputController,
                      decoration: InputDecoration(
                        labelText: '(နုတ်) ဝင်ငွေရလမ်းတင်ပြနိုင်သည့်ဝင်ငွေပမာဏ',
                        labelStyle: new TextStyle(fontSize: 12.0),
                        hintText: "0",
                        counterText: '',
                      ),
                      validator: (value) {
                        if (value.isEmpty) {
                          return 'ရိုက်ထည့်ပေးပါ';
                        }
                      },
                      maxLength: ConstantUtils.INPUT_FIELD_LENGTH,
                      keyboardType: TextInputType.number,
                  ),
                  Container(
                    child: IconButton(
                      icon: Icon(Icons.info,color: Colors.blue,),
                      tooltip: '(အောင်ဘာလေသိန်းဆုရငွေ၊ စီးပွားရေးလုပ်ငန်းမှဝင်ငွေ၊ အစုရှယ်ယာ၊ အိမ်ခြံရောင်းချခြင်းမှရငွေ)',
                    ),
                    alignment: Alignment.centerLeft,
                  ),
                  Text(
                    'အခွန်စည်းကြပ်ရန်ဝင်ငွေ',
                    style: new TextStyle(fontSize: 12.0),
                  ),
                  Text(
                    '${state.taxableAmount}',
                    style: new TextStyle(
                        fontSize: 16.0, fontWeight: FontWeight.bold),
                  ),
                  Text(
                    'ကျသင့်အခွန် (${state.startYear}-${state.endYear} ခုနှစ်ပြည်ထောင်စု၏ အခွန်အကောက် ဥပဒေအရ)',
                    style: new TextStyle(fontSize: 12.0),
                  ),
                  Text(
                    '${state.taxAmount}',
                    style: new TextStyle(
                        fontSize: 18.0, fontWeight: FontWeight.bold,color: Colors.blue),
                  ),
                  new Padding(
                    padding: new EdgeInsets.all(10.0),
                  ),
                  Text('${state.startYear} ခုနှစ်ပြည်ထောင်စု၏ အခွန်အကောက်ဥပဒေအရ'),
                  new Padding(
                    padding: new EdgeInsets.all(5.0),
                  ),
                  ListView.builder(itemBuilder: (context, index){
                    return ExpansionTile(
                      title: ListTile(
                          leading: Text('ဝင်ငွေ(ကျပ်)'),
                          trailing: Text('ဝင်ငွေခွန် ရာခိုင်နှုန်း')),
                      children: <Widget>[
                        new Column(
                          children: _buildExpandableContent(state.selectedRuleItems),
                        ),
                      ],
                    );
                  },
                    itemCount: 1,
                    shrinkWrap: true,
                  ),
                  Container(
                    child: RaisedButton(
                      color: Colors.blueGrey,
                      child: Text(
                        'Clear',
                        style: TextStyle(color: Colors.white),
                      ),
                      onPressed: _clearTextField,
                    ),
                  ),
                ])
        );
      },
    );
  }

  _buildExpandableContent(List<RuleItem> items) {
    List<Widget> columnContent = [];

    for (RuleItem item in items)
      columnContent.add(
        new ListTile(
          leading: Text(item.rangeAmount),
          trailing: Text(item.percentage),
        ),
      );

    return columnContent;
  }
}