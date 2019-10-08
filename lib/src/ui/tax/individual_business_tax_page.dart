import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:myanmar_tax_calculator/src/bloc/individual_biz_tax/bloc.dart';
import 'package:myanmar_tax_calculator/src/ui/utils/common_widget.dart';
import 'package:myanmar_tax_calculator/src/ui/utils/constant_utils.dart';

/// စီးပွားရေးလုပ်ငန်းမှ ဝင်ငွေခွန်တွက်ချက်ခြင်း (Individual)
class IndividualTaxCalculationPage extends StatefulWidget {
  @override
  _MyAppState createState() => new _MyAppState();
}

class _MyAppState extends State<IndividualTaxCalculationPage> {
  final _formKey = GlobalKey<FormState>();

  final IndividualBizTaxBloc _individualBizBloc = IndividualBizTaxBloc();

  final _incomeInputController = TextEditingController();
  final _expenseInputController = TextEditingController();
  final _noOfParentController = TextEditingController();

  final _partnerInsuranceController = TextEditingController();
  final _insuranceController = TextEditingController();
  final _ssbAmountController = TextEditingController();
  final _donationAmountController = TextEditingController();
  final _childrenAllowanceController = TextEditingController();


  @override
  void initState() {
    super.initState();

    _incomeInputController.addListener(_onIncomeTextChange);
    _expenseInputController.addListener(_onExpenseTextChange);
    _noOfParentController.addListener(_onParentAllowanceTextChange);

    _partnerInsuranceController.addListener(_onPartnerInsuranceTextChange);
    _insuranceController.addListener(_onInsuranceTextChange);
    _ssbAmountController.addListener(_onSSBAmountTextChange);
    _donationAmountController.addListener(_onDonationAmountTextChange);

    _childrenAllowanceController.addListener(_onChildrenAllowanceTextChange);

  }

  void _onMaritalStatusOptionChange(int value) {
    _individualBizBloc.dispatch(MaritalStatusChangeEvent(value));
  }

  void _onIncomeTextChange() {
    _individualBizBloc.dispatch(
        IncomeTextChangeEvent(
            int.tryParse(_incomeInputController.text)==null?
            0 : int.parse(_incomeInputController.text)));
  }

  void _onExpenseTextChange() {
    _individualBizBloc.dispatch(ExpenseTextChangeEvent(
        int.tryParse(_expenseInputController.text)==null?
        0 : int.parse(_expenseInputController.text)));
  }

  void _onParentAllowanceTextChange() {
    int value = int.tryParse(_noOfParentController.text);
    if(value != null && value <= 4) {
      _individualBizBloc.dispatch(NoOfParentChangeEvent(value));
    }
  }

  void _onPartnerInsuranceTextChange() {
    _individualBizBloc.dispatch(
        PartnerInsuranceChangeEvent(
            int.tryParse(_partnerInsuranceController.text)==null?
            0 : int.parse(_partnerInsuranceController.text)));
  }

  void _onInsuranceTextChange() {
    _individualBizBloc.dispatch(
        InsuranceChangeEvent(
            int.tryParse(_insuranceController.text)==null?
            0 : int.parse(_insuranceController.text)));
  }

  void _onSSBAmountTextChange() {
    _individualBizBloc.dispatch(
        SSBAmountChangeEvent(
            int.tryParse(_ssbAmountController.text)==null?
            0 : int.parse(_ssbAmountController.text)));
  }

  void _onDonationAmountTextChange() {
    _individualBizBloc.dispatch(
        DonationAmountChangeEvent(
            int.tryParse(_donationAmountController.text)==null?
            0 : int.parse(_donationAmountController.text)));
  }

  void _onChildrenAllowanceTextChange() {
    _individualBizBloc.dispatch(
        ChildrenAllowanceChangeEvent(
            int.tryParse(_childrenAllowanceController.text)==null?
            0 : int.parse(_childrenAllowanceController.text)));
  }

  void _clearTextField() {
    _incomeInputController.clear();

    _noOfParentController.clear();
    _partnerInsuranceController.clear();
    _insuranceController.clear();
    _ssbAmountController.clear();
    _donationAmountController.clear();

    _expenseInputController.clear();
    _childrenAllowanceController.clear();

    _individualBizBloc.dispatch(ClearEvent());
  }

  @override
  void dispose() {
    super.dispose();

    _incomeInputController.dispose();

    _individualBizBloc.dispose();
  }

  void _onBizTypeOptionChange(int value) {
    _individualBizBloc.dispatch(BizOptionChangeEvent(value));
  }


  void _onYearOptionChange(int newValue) {
    _individualBizBloc.dispatch(YearOptionChangeEvent(newValue));
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder(
        bloc: _individualBizBloc,
        builder: (BuildContext context, IndividualBizTaxState state) {
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
                          'စီးပွားရေးလုပ်ငန်းမှ ဝင်ငွေခွန်တွက်ချက်ခြင်း (Individual)',
                          style: new TextStyle(
                            fontSize: 14.0,
                            fontWeight: FontWeight.bold,
                          ),
                        )
                    ),
                    DropdownButtonHideUnderline(
                      child: InputDecorator(
                        decoration: const InputDecoration(
                          labelText: '၁။ စည်းကြပ်နှစ်',
                          contentPadding: EdgeInsets.zero,
                        ),
                        isEmpty: false,
                        child: DropdownButton<int>(
                          value: state.yearOptionIndex,
                          onChanged: _onYearOptionChange,
                          items: _individualBizBloc.yearList.entries.map((MapEntry<int, List> e) {
                            return DropdownMenuItem<int>(
                              value: e.key,
                              child: Text(e.value[0]),
                            );
                          }).toList(),
                        ),
                      ),
                    ),
                    Text('ဝင်ငွေကာလ (၁-၄-${state.startYear}) မှ (၃၁-၃-${state.endYear}) ထိ'
                        , style: TextStyle(
                            fontSize: 12.0, color: Colors.blueGrey)),
                    new Padding(
                      padding: new EdgeInsets.all(8.0),
                    ),
                    TextFormField(
                      controller: _incomeInputController,
                      decoration: InputDecoration(
                        labelText: 'ဝင်ငွေ (ကုန်သွယ်လုပ်ငန်းခွန် ${state.serviceTypeTaxDesc})',
                        labelStyle: new TextStyle(fontSize: 12.0),
                        hintText: "0",
                        counterText: '',
                      ),
                      maxLength: ConstantUtils.INPUT_FIELD_LENGTH,
                      keyboardType: TextInputType.number,
                    ),
                    Wrap(
                        children: [
                          Text('ကုန်စည်/ဝန်ဆောင်မှုအမျိုးအစား',
                            style: new TextStyle(
                                fontSize: 12.0),

                          ),
                          Wrap(
                              children: <Widget>[
                                new Radio(
                                  value: 0,
                                  groupValue: state.bizTypeOptionIndex,
                                  onChanged: _onBizTypeOptionChange,
                                ),
                                new Text(
                                  '${state.bizOptionTypeDesc}',
                                  style: new TextStyle(fontSize: 12.0),
                                ),
                              ]),
                          Row(
                            children: [
                              new Radio(
                                value: 1,
                                groupValue: state.bizTypeOptionIndex,
                                onChanged: _onBizTypeOptionChange,
                              ),
                              new Text(
                                'အခြား',
                                style: new TextStyle(fontSize: 12.0),
                              ),
                            ],
                          )
                        ]
                    ),

                    new Padding(
                      padding: new EdgeInsets.all(8.0),
                    ),
                    buildLabelWidget('ကျသင့်ကုန်သွယ်လုပ်ငန်းခွန်(ဝင်ငွေx အခွန်ရာခိုင်နှုန်း) / (၁၀၀+အခွန်ရာခိုင်နှုန်း)'),
                    buildMainLabelWidget('${state.tradingTaxAmount}'),
                    new Padding(
                      padding: new EdgeInsets.all(8.0),
                    ),
                    Text('${state.yearTaxDesc}'
                        , style: TextStyle(
                            fontSize: 12.0, color: Colors.blueGrey)),
                    TextFormField(
                        controller: _expenseInputController,
                        decoration: InputDecoration(
                          labelText: '(နုတ်) ကုန်ကျစရိတ်များ',
                          labelStyle: new TextStyle(fontSize: 12.0),
                          hintText: "0",
                        ),
                        maxLength: ConstantUtils.INPUT_FIELD_LENGTH,
                        keyboardType: TextInputType.number,
                    ),
                    buildLabelWidget('စုစုပေါင်းဝင်ငွေ (ဝင်ငွေ - ကုန်သွယ်လုပ်ငန်းခွန် - ကုန်ကျစရိတ်များ)'),
                    buildMainLabelWidget('${state.totalIncome}'),
                    new Padding(
                      padding: new EdgeInsets.only(top: 8.0, bottom: 8.0),
                    ),
                    Center(
                      child: Text('သက်သာခွင့်များ',
                        style: new TextStyle(
                            fontSize: 14.0, fontWeight: FontWeight.bold),

                      ),
                    ),
                    buildLabelWidget('အခြေခံသက်သာခွင့် (စုစုပေါင်းဝင်ငွေ၏ ၂၀% ကျပ်သိန်း ၁၀၀ ထိ)'),
                    buildMainLabelWidget('${state.basicAllowance}'),
                    state.isParentAllowanceIncluded ? TextFormField(
                      controller: _noOfParentController,
                      decoration: InputDecoration(
                        labelText: 'အတူနေမိဘဦးရေ',
                        labelStyle: new TextStyle(fontSize: 12.0),
                        hintText: "0",
                      ),
                      maxLength: 1,
                      keyboardType: TextInputType.number,
                    ) : Container(),
                    state.isParentAllowanceIncluded ?
                    buildLabelWidget('အတူနေမိဘအတွက် သက်သာခွင့်'):
                    Container(),
                    state.isParentAllowanceIncluded ?
                    buildMainLabelWidget('${state.parentAllowance}'):Container(),
                    new Padding(
                      padding: new EdgeInsets.only(top:8.0, bottom: 8.0),
                    ),
                    Text('အိမ်ထောင်ဖက်/အလုပ်အကိုင်',
                      style: new TextStyle(
                          fontSize: 12.0),

                    ),
                    new Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: <Widget>[
                          new Radio(
                            value: 0,
                            groupValue: state.maritalStatusOptionIndex,
                            onChanged: _onMaritalStatusOptionChange,
                          ),
                          new Text(
                            'ရှိ/မရှိ',
                            style: new TextStyle(fontSize: 12.0),
                          ),
                          new Radio(
                            value: 1,
                            groupValue: state.maritalStatusOptionIndex,
                            onChanged: _onMaritalStatusOptionChange,
                          ),
                          new Text(
                            'မရှိ',
                            style: new TextStyle(fontSize: 12.0),
                          ),
                        ]
                    ),
                    buildLabelWidget('အိမ်ထောင်ဖက်အတွက် သက်သာခွင့်'),
                    buildMainLabelWidget('${state.partnerAllowance}'),
                    TextFormField(
                      controller: _childrenAllowanceController,
                      decoration: InputDecoration(
                        labelText: 'အသက် ၁၈ နှစ်မပြည့်သော သား/သမီး\n၁၈ နှစ်ပြည့်ပြီး ပညာသင်ကြားဆဲ အိမ်ထောင်မရှိသားသမီးအရေအတွက်',
                        labelStyle: new TextStyle(fontSize: 12.0),
                        hintText: "0",
                      ),
                      maxLength: ConstantUtils.INPUT_FIELD_LENGTH,
                      keyboardType: TextInputType.number,
                    ),
                    buildLabelWidget('သား/သမီးအတွက် သက်သာခွင့်'),
                    buildMainLabelWidget('${state.childrenAllowance}'),
                    TextFormField(
                      controller: _partnerInsuranceController,
                      decoration: InputDecoration(
                        labelText: 'အိမ်ထောင်ဖက်အသက်အာမခံ',
                        labelStyle: new TextStyle(fontSize: 12.0),
                        hintText: "0",
                      ),
                      maxLength: ConstantUtils.INPUT_FIELD_LENGTH,
                    ),
                    TextFormField(
                      controller: _insuranceController,
                      decoration: InputDecoration(
                        labelText: 'မိမိအသက်အာမခံ',
                        labelStyle: new TextStyle(fontSize: 12.0),
                        hintText: "0",
                      ),
                      maxLength: ConstantUtils.INPUT_FIELD_LENGTH,
                      keyboardType: TextInputType.number,
                    ),
                    TextFormField(
                      controller: _ssbAmountController,
                      decoration: InputDecoration(
                        labelText: 'လူမှုဖူလုံရေးရန်ပုံငွေထည့်ဝင်ငွေ',
                        labelStyle: new TextStyle(fontSize: 12.0),
                        hintText: "0",
                      ),
                      maxLength: ConstantUtils.INPUT_FIELD_LENGTH,
                      keyboardType: TextInputType.number,
                    ),
                    TextFormField(
                      controller: _donationAmountController,
                      decoration: InputDecoration(
                        labelText: 'လှူဒါန်းငွေ',
                        labelStyle: new TextStyle(fontSize: 12.0),
                        hintText: "0",
                        counterText: '',
                      ),
                      maxLength: ConstantUtils.INPUT_FIELD_LENGTH,
                      keyboardType: TextInputType.number,
                    ),
                    new Padding(
                      padding: new EdgeInsets.only(top:8.0, bottom: 8.0),
                    ),
                    buildLabelWidget('သက်သာခွင့်စုစုပေါင်း'),
                    buildMainLabelWidget('${state.totalReductionAmount}'),
                    new Padding(
                      padding: new EdgeInsets.only(top:8.0, bottom: 8.0),
                    ),
                    buildLabelWidget('အခွန်စည်းကြပ်ရန်ဝင်ငွေ (စုစုပေါင်းဝင်ငွေ - သက်သာခွင့်များ)'),
                    buildMainLabelWidget('${state.taxableAmount}'),
                    new Padding(
                      padding: new EdgeInsets.only(top:8.0, bottom: 8.0),
                    ),
                    buildLabelWidget('ကျသင့်ဝင်ငွေခွန်'),
                    buildMainLabelWidget('${state.taxAmount}'),
                    ListView.builder(itemBuilder: (context, index) {
                      return ExpansionTile(
                        title: ListTile(
                            leading: Text('ဝင်ငွေ'),
                            trailing: Text('ရာခိုင်နှုန်း')),
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
                      child:
                      RaisedButton(
                        color: Colors.blueGrey,
                        child: Text(
                          'Clear', style: TextStyle(color: Colors.white),),
                        onPressed: _clearTextField,
                      ),
                    ),
                  ]));
        }
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