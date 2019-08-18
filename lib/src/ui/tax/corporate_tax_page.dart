import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:ird_myanmar_app/src/bloc/corporate/bloc.dart';
import 'package:ird_myanmar_app/src/ui/utils/util_package.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

/// စီးပွားရေးလုပ်ငန်းမှ ဝင်ငွေခွန်တွက်ချက်ခြင်း (Corporate)
class CorporateTaxCalculationPage extends StatefulWidget {
  @override
  _MyAppState createState() => new _MyAppState();
}

class _MyAppState extends State<CorporateTaxCalculationPage> {
  final _formKey = GlobalKey<FormState>();

  final CorporateBloc _corporateBloc = CorporateBloc();

  final _incomeInputController = TextEditingController();
  final _managementCostInputController = TextEditingController();
  final _productionCostInputController = TextEditingController();
  final _depreciationInputController = TextEditingController();

  final _taxPercentageInputController = TextEditingController();

  @override
  void initState() {
    super.initState();

    _incomeInputController.text = '0';
    _productionCostInputController.text = '0';
    _incomeInputController.text = '0';
    _depreciationInputController.text = '0';
    _taxPercentageInputController.text = '0';

    _incomeInputController.addListener(_onIncomeTextChange);
    _productionCostInputController.addListener(_onProductionCostTextChange);
    _managementCostInputController.addListener(_onManagementCostInputTextChange);
    _depreciationInputController.addListener(_onDepreciationInputTextChange);
  }

  void _onIncomeTextChange() {
      _corporateBloc.dispatch(
          IncomeTextChangeEvent(
              int.tryParse(_incomeInputController.text)==null?
              0 : int.parse(_incomeInputController.text)));
  }

  void _onProductionCostTextChange() {
    _corporateBloc.dispatch(ProductionCostTextChangeEvent(
        int.tryParse(_productionCostInputController.text)==null?
        0 : int.parse(_productionCostInputController.text)));
  }

  void _onManagementCostInputTextChange() {
    _corporateBloc.dispatch(ManagementCostTextChangeEvent(
        int.tryParse(_managementCostInputController.text)==null?
          0 : int.parse(_managementCostInputController.text)));
  }

  void _onDepreciationInputTextChange() {
    _corporateBloc.dispatch(DepreciationTextChangeEvent(
        int.tryParse(_depreciationInputController.text)==null?
        0 : int.parse(_depreciationInputController.text)));
  }

  void _clearTextField() {
    _incomeInputController.clear();
    _productionCostInputController.clear();
    _managementCostInputController.clear();
    _depreciationInputController.clear();

    _corporateBloc.dispatch(ClearEvent());
  }

  @override
  void dispose() {
    // Clean up the controller when the Widget is disposed
    _incomeInputController.dispose();
    _productionCostInputController.dispose();
    _managementCostInputController.dispose();
    _depreciationInputController.dispose();

    _corporateBloc.dispose();

    super.dispose();
  }

  void _goodsTypesRadioValueChange(int value) {
    _corporateBloc.dispatch(ServiceTypeOptionChangeEvent(value));
  }

  void _onYearOptionChange(int newValue) {
    _corporateBloc.dispatch(YearOptionChangeEvent(newValue));
  }

  void _onBizTypeOptionChange(int newValue) {
    _corporateBloc.dispatch(BizOptionChangeEvent(newValue));
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder(
      bloc: _corporateBloc,
      builder: (BuildContext context, CorporateState state) {
        return Form(
            key: _formKey,
            child: ListView(
                shrinkWrap: true,
                padding: const EdgeInsets.all(10.0),
                children: <Widget>[
                  Container(
                      alignment: Alignment.center,
                      padding: EdgeInsets.only(bottom: 15.0, top: 8.0),
                      child: new Text(
                        'စီးပွားရေးလုပ်ငန်းမှ ဝင်ငွေခွန်တွက်ချက်ခြင်း (Corporate)',
                        style: new TextStyle(
                          fontSize: 14.0,
                          fontWeight: FontWeight.bold,
                        ),
                      )),
                  DropdownButtonHideUnderline(
                    key: CorporateTaxWidgetKey.YEAR_WIDGET_KEY,
                    child: InputDecorator(
                      decoration: const InputDecoration(
                        labelText: '၁။ စည်းကြပ်နှစ်',
                        contentPadding: EdgeInsets.zero,
                      ),
                      isEmpty: false,
                      child: DropdownButton<int>(
                        value: state.yearOptionIndex,
                        onChanged: _onYearOptionChange,
                        items: _corporateBloc.yearList.entries.map((MapEntry<int, String> e) {
                          return DropdownMenuItem<int>(
                            value: e.key,
                            child: Text(e.value),
                          );
                        }).toList(),
                      ),
                    ),
                  ),
                  Text('ဝင်ငွေကာလ (၁-၄-${state.startYear}) မှ (၃၁-၃-${state.endYear}) ထိ',
                      style: TextStyle(fontSize: 12.0, color: Colors.blueGrey)),
                  new Padding(
                    padding: new EdgeInsets.all(8.0),
                  ),
                  DropdownButtonHideUnderline(
                    key: CorporateTaxWidgetKey.BIZ_TYPE_WIDGET_KEY,
                    child: InputDecorator(
                      decoration: const InputDecoration(
                        labelText: 'စီးပွားရေးလုပ်ငန်းအမျိုးအစား',
                        contentPadding: EdgeInsets.zero,
                      ),
                      isEmpty: false,
                      child: DropdownButton<int>(
                        value: state.bizTypeOptionIndex,
                        onChanged: _onBizTypeOptionChange,
                        items: _corporateBloc.corporateTypes.entries
                            .map((MapEntry<int, String> e) {
                          return DropdownMenuItem<int>(
                            value: e.key,
                            child: Text(e.value),
                          );
                        }).toList(),
                      ),
                    ),
                  ),
                  TextFormField(
                      key: CorporateTaxWidgetKey.INCOME_WIDGET_KEY,
                      controller: _incomeInputController,
                      decoration: InputDecoration(
                        labelText:
                            '၂။ ဝင်ငွေ (ရောင်းရငွေ/ဝန်ဆောင်မှုရငွေ/ထုတ်လုပ်ရောင်းရငွေ)',
                        labelStyle: new TextStyle(fontSize: 12.0),
                        hintText: "0",
                        counterText: '',
                      ),
                      autovalidate: true,
                      validator: (value) {
                        if (value.isEmpty) {
                          return 'ရိုက်ထည့်ပေးပါ';
                        }
                      },
                      maxLength: ConstantUtils.INPUT_FIELD_LENGTH,
                      keyboardType: TextInputType.number,
                      ),
                  new Padding(
                    padding: new EdgeInsets.all(8.0),
                  ),
                  new Text(
                    'အကုန်စည်/ဝန်ဆောင်မှုအမျိုးအစား',
                    style: new TextStyle(
                      fontSize: 12.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  new Wrap(children: <Widget>[
                    new Radio(
                      key: CorporateTaxWidgetKey.SERVICE_TYPE_OPTION_KEY1,
                      value: 0,
                      groupValue: state.serviceTypeOptionIndex,
                      onChanged: _goodsTypesRadioValueChange,
                    ),
                    new Text(
                      state.serviceTypeDesc,
                      style: new TextStyle(fontSize: 14.0),
                      maxLines: 3,
                    ),
                  ]),
                  new Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: <Widget>[
                        new Radio(
                          key: CorporateTaxWidgetKey.SERVICE_TYPE_OPTION_KEY2,
                          value: 1,
                          groupValue: state.serviceTypeOptionIndex,
                          onChanged: _goodsTypesRadioValueChange,
                        ),
                        new Text(
                          'အခြား',
                          style: new TextStyle(fontSize: 16.0),
                        ),
                      ]),
                  Text(
                    'အခွန်ရာခိုင်နှုန်း',
                    style: new TextStyle(fontSize: 12.0),
                  ),
                  Text(
                    '${state.taxPercentageOfServiceTax}',
                    style: new TextStyle(
                        fontSize: 16.0, fontWeight: FontWeight.bold),
                    key: CorporateTaxWidgetKey.TAX_PERCENT_INPUT_KEY,
                  ),
                  new Padding(
                    padding: new EdgeInsets.all(8.0),
                  ),
                  Text(
                    '${state.serviceTypeTaxDesc}',
                    style: new TextStyle(
                        fontSize: 14.0, fontWeight: FontWeight.bold, color: Colors.red),
                    key: CorporateTaxWidgetKey.SERVICE_TAX_DESC_WIDGET_KEY,
                  ),
                  new Padding(
                    padding: new EdgeInsets.all(8.0),
                  ),
                  Text(
                    '၃။ ကျသင့်ကုန်သွယ်လုပ်ငန်းခွန် (ဝင်ငွေ x အခွန်ရာခိုင်နှုန်း)/(၁၀၀+အခွန်ရာခိုင်နှုန်း)',
                    style: new TextStyle(fontSize: 12.0),
                  ),
                  Text(
                    '${state.amountOfServiceTax}',
                    style: new TextStyle(
                        fontSize: 16.0, fontWeight: FontWeight.bold),
                    key: CorporateTaxWidgetKey.AMOUNT_TAX_WIDGET_KEY,
                  ),
                  new Padding(
                    padding: new EdgeInsets.all(8.0),
                  ),
                  Text(
                    state.yearDesc,
                    style: new TextStyle(fontSize: 12.0, color: Colors.blue),
                    key: CorporateTaxWidgetKey.YEAR_DESC_WIDGET_KEY,
                  ),
                  new Padding(
                    padding: new EdgeInsets.all(8.0),
                  ),
                  Text(
                    '၄။ ကုန်သွယ်လုပ်ငန်းခွန်မပါရငွေ (၂ - ၃)',
                    style: new TextStyle(fontSize: 12.0),
                  ),
                  Text(
                    '${state.amountNotIncludedInServiceTax}',
                    style: new TextStyle(
                        fontSize: 16.0, fontWeight: FontWeight.bold),
                    key: CorporateTaxWidgetKey.AMT_NOT_INCLUDED_WIDGET_KEY,
                  ),
                  TextFormField(
                    key: CorporateTaxWidgetKey.PRODUCTION_COST_WIDGET_KEY,
                    controller: _productionCostInputController,
                      decoration: InputDecoration(
                        labelText:
                            '၅။ (နုတ်) ကုန်ထုတ်လုပ်မှု စရိတ်/ကုန်ဝယ်စရိတ်',
                        labelStyle: new TextStyle(fontSize: 12.0),
                        hintText: "0",
                        counterText: '',
                      ),
                      keyboardType: TextInputType.number,
                      maxLength: ConstantUtils.INPUT_FIELD_LENGTH,
                  ),
                  new Padding(
                    padding: new EdgeInsets.all(8.0),
                  ),
                  Text(
                    '၆။ အကြမ်းအမြတ် (၄ - ၅)',
                    style: new TextStyle(fontSize: 12.0),
                  ),
                  Text(
                    '${state.basicProfit}',
                    style: new TextStyle(
                        fontSize: 16.0, fontWeight: FontWeight.bold),
                    key: CorporateTaxWidgetKey.BASIC_PROFIT_WIDGET_KEY,
                  ),
                  TextFormField(
                    key: CorporateTaxWidgetKey.MGNT_COST_WIDGET_KEY,
                    controller: _managementCostInputController,
                      decoration: InputDecoration(
                        labelText: '၇။ စီမံအုပ်ချုပ်မှုစရိတ်များ',
                        labelStyle: new TextStyle(fontSize: 12.0),
                        hintText: "0",
                        counterText: '',
                      ),
                      maxLength: ConstantUtils.INPUT_FIELD_LENGTH,
                      keyboardType: TextInputType.number,
                  ),
                  TextFormField(
                    key: CorporateTaxWidgetKey.DEPRECIATION_WIDGET_KEY,
                    controller: _depreciationInputController,
                      decoration: InputDecoration(
                        labelText: '၈။ တန်ဖိုးလျော့',
                        labelStyle: new TextStyle(fontSize: 12.0),
                        hintText: "0",
                        counterText: '',
                      ),
                      maxLength: ConstantUtils.INPUT_FIELD_LENGTH,
                      keyboardType: TextInputType.number,
                  ),
                  new Padding(
                    padding: new EdgeInsets.all(8.0),
                  ),
                  Text(
                    '၉ ။ အသားတင်အမြတ် (၆ - ၇ - ၈)',
                    style: new TextStyle(fontSize: 12.0),
                  ),
                  Text(
                    '${state.netProfit}',
                    style: new TextStyle(
                        fontSize: 16.0, fontWeight: FontWeight.bold),
                    key: CorporateTaxWidgetKey.NET_PROFIT_WIDGET_KEY,
                  ),
                  new Padding(
                    padding: new EdgeInsets.all(8.0),
                  ),
                  Text(
                    '၁၀။ ကျသင့်ဝင်ငွေခွန်',
                    style: new TextStyle(fontSize: 12.0),
                  ),
                  Text(
                    '${state.taxAmount}',
                    style: new TextStyle(
                        fontSize: 18.0, fontWeight: FontWeight.bold,color: Colors.blue),
                    key: CorporateTaxWidgetKey.TAX_AMOUNT_WIDGET_KEY,
                  ),
                  new Padding(
                    padding: new EdgeInsets.all(10.0),
                  ),
                  Text('၂၀၁၄ ခုနှစ်ပြည်ထောင်စု၏ အခွန်အကောက်ဥပဒေအရ'),
                  new Padding(
                    padding: new EdgeInsets.only(top: 5.0, bottom: 5.0),
                  ),
                  ListView.builder(
                    itemBuilder: (context, index) {
                      return ExpansionTile(
                        title: ListTile(
                            leading: Text('လုပ်ငန်း'),
                            trailing: Text('ဝင်ငွေခွန် ရာခိုင်နှုန်း')),
                        children: <Widget>[
                          new Column(
                            children: _buildExpandableContent(),
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
                ]));
      },
    );
  }

  _buildExpandableContent() {
    List<Widget> columnContent = [];
    for (BusinessType item in TaxConstantUtil.businessTypeRules)
      columnContent.add(
        new ListTile(
          leading: Text(
            item.type,
            style: TextStyle(fontSize: 12.0),
          ),
          trailing: Text(item.percentage, style: TextStyle(fontSize: 12.0)),
        ),
      );

    return columnContent;
  }
}
