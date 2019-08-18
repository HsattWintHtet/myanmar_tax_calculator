import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ird_myanmar_app/src/bloc/black_income_tax/black_income_state.dart';
import 'package:ird_myanmar_app/src/bloc/income_tax/bloc.dart';
import 'package:ird_myanmar_app/src/ui/utils/constant_utils.dart';
import 'package:ird_myanmar_app/src/ui/utils/util_package.dart';

/// လစာဝင်ငွေခွန်တွက်ချက်ခြင်း
class IncomeTaxCalculationPage extends StatefulWidget {
  @override
  _MyAppState createState() => new _MyAppState();
}

class _MyAppState extends State<IncomeTaxCalculationPage> {
  final _formKey = GlobalKey<FormState>();

  SalaryTaxBloc _salaryTaxBloc = SalaryTaxBloc();

  final _incomeController = TextEditingController();
  final _noOfMonthController = TextEditingController();
  final _bonusController = TextEditingController();
  final _pocketMoneyController = TextEditingController();
  final _underTableMoneyController = TextEditingController();
  final _allowanceController = TextEditingController();

  final _noOfParentController = TextEditingController();
  final _partnerInsuranceController = TextEditingController();
  final _insuranceController = TextEditingController();
  final _ssbAmountController = TextEditingController();
  final _donationAmountController = TextEditingController();
  final _commissionController = TextEditingController();
  final _childrenAllowanceController = TextEditingController();

  @override
  void initState() {
    super.initState();

    _incomeController.addListener(_onIncomeTextChange);

    _noOfMonthController.addListener(_onNoOfMonthTextChange);
    _bonusController.addListener(_onBonusTextChange);
    _pocketMoneyController.addListener(_onPocketMoneyTextChange);
    _underTableMoneyController.addListener(_onUnderTableMoneyTextChange);
    _allowanceController.addListener(_onAllowanceTextChange);
    _noOfParentController.addListener(_onParentAllowanceTextChange);
    _partnerInsuranceController.addListener(_onPartnerInsuranceTextChange);
    _insuranceController.addListener(_onInsuranceTextChange);
    _ssbAmountController.addListener(_onSSBAmountTextChange);
    _donationAmountController.addListener(_onDonationAmountTextChange);

    _commissionController.addListener(_onCommissionTextChange);

    _childrenAllowanceController.addListener(_onChildrenAllowanceTextChange);
  }

  void _clearTextField() {
    _incomeController.clear();

    _noOfMonthController.clear();
    _bonusController.clear();
    _pocketMoneyController.clear();
    _underTableMoneyController.clear();
    _allowanceController.clear();
    _noOfParentController.clear();
    _partnerInsuranceController.clear();
    _insuranceController.clear();
    _ssbAmountController.clear();
    _donationAmountController.clear();

    _salaryTaxBloc.dispatch(ClearEvent());
  }

  @override
  void dispose() {
    _incomeController.dispose();

    _noOfMonthController.dispose();
    _bonusController.dispose();
    _pocketMoneyController.dispose();
    _underTableMoneyController.dispose();
    _allowanceController.dispose();
    _noOfParentController.dispose();
    _partnerInsuranceController.dispose();
    _insuranceController.dispose();
    _ssbAmountController.dispose();
    _donationAmountController.dispose();

    _salaryTaxBloc.dispose();

    super.dispose();
  }

  void _onMaritalStatusOptionChange(int value) {
    _salaryTaxBloc.dispatch(MaritalStatusChangeEvent(value));
  }

  void _onIncomeTextChange() {
    _salaryTaxBloc.dispatch(IncomeTextChangeEvent(
        int.tryParse(_incomeController.text) == null
            ? 0
            : int.parse(_incomeController.text)));
  }

  void _onNoOfMonthTextChange() {
    _salaryTaxBloc.dispatch(NoOfMonthChangeEvent(
        int.tryParse(_noOfMonthController.text) == null
            ? 0
            : int.parse(_noOfMonthController.text)));
  }

  void _onBonusTextChange() {
    _salaryTaxBloc.dispatch(BonusChangeEvent(
        int.tryParse(_bonusController.text) == null
            ? 0
            : int.parse(_bonusController.text)));
  }

  void _onPocketMoneyTextChange() {
    _salaryTaxBloc.dispatch(PocketMoneyChangeEvent(
        int.tryParse(_pocketMoneyController.text) == null
            ? 0
            : int.parse(_pocketMoneyController.text)));
  }

  void _onUnderTableMoneyTextChange() {
    _salaryTaxBloc.dispatch(UnderTableMoneyChangeEvent(
        int.tryParse(_underTableMoneyController.text) == null
            ? 0
            : int.parse(_underTableMoneyController.text)));
  }

  void _onAllowanceTextChange() {
    _salaryTaxBloc.dispatch(AllowanceChangeEvent(
        int.tryParse(_allowanceController.text) == null
            ? 0
            : int.parse(_allowanceController.text)));
  }

  void _onParentAllowanceTextChange() {
    int value = int.tryParse(_noOfParentController.text);
    if (value != null && value <= 4) {
      _salaryTaxBloc.dispatch(NoOfParentChangeEvent(value));
    }
  }

  void _onPartnerInsuranceTextChange() {
    _salaryTaxBloc.dispatch(PartnerInsuranceChangeEvent(
        int.tryParse(_partnerInsuranceController.text) == null
            ? 0
            : int.parse(_partnerInsuranceController.text)));
  }

  void _onInsuranceTextChange() {
    _salaryTaxBloc.dispatch(InsuranceChangeEvent(
        int.tryParse(_insuranceController.text) == null
            ? 0
            : int.parse(_insuranceController.text)));
  }

  void _onSSBAmountTextChange() {
    _salaryTaxBloc.dispatch(SSBAmountChangeEvent(
        int.tryParse(_ssbAmountController.text) == null
            ? 0
            : int.parse(_ssbAmountController.text)));
  }

  void _onDonationAmountTextChange() {
    _salaryTaxBloc.dispatch(DonationAmountChangeEvent(
        int.tryParse(_donationAmountController.text) == null
            ? 0
            : int.parse(_donationAmountController.text)));
  }

  void _onCommissionTextChange() {
    _salaryTaxBloc.dispatch(CommissionChangeEvent(
        int.tryParse(_commissionController.text) == null
            ? 0
            : int.parse(_commissionController.text)));
  }

  void _onChildrenAllowanceTextChange() {
    _salaryTaxBloc.dispatch(ChildrenAllowanceChangeEvent(
        int.tryParse(_childrenAllowanceController.text) == null
            ? 0
            : int.parse(_childrenAllowanceController.text)));
  }

  void _onYearOptionChange(int newValue) {
    _salaryTaxBloc.dispatch(YearOptionChangeEvent(newValue));
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder(
        bloc: _salaryTaxBloc,
        builder: (BuildContext context, SalaryTaxState state) {
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
                          'လစာဝင်ငွေခွန်တွက်ချက်ခြင်း',
                          style: new TextStyle(
                            fontSize: 14.0,
                            fontWeight: FontWeight.bold,
                          ),
                        )),
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
                          items: _salaryTaxBloc.yearList.entries
                              .map((MapEntry<int, String> e) {
                            return DropdownMenuItem<int>(
                              value: e.key,
                              child: Text(e.value),
                            );
                          }).toList(),
                        ),
                      ),
                    ),
                    Text(
                        'ဝင်ငွေကာလ (၁-၄-${state.startYear}) မှ (၃၁-၃-${state.endYear}) ထိ',
                        style:
                            TextStyle(fontSize: 12.0, color: Colors.blueGrey)),
                    new Padding(
                      padding: new EdgeInsets.all(8.0),
                    ),
                    TextFormField(
                      controller: _incomeController,
                      decoration: InputDecoration(
                        labelText: 'တစ်လဝင်ငွေ',
                        labelStyle: new TextStyle(fontSize: 12.0),
                        hintText: "0",
                      ),
                      maxLength: ConstantUtils.INPUT_FIELD_LENGTH,
                      keyboardType: TextInputType.number,
                    ),
                    new Padding(
                      padding: new EdgeInsets.all(8.0),
                    ),
                    TextFormField(
                      controller: _noOfMonthController,
                      decoration: InputDecoration(
                        labelText: 'လအရေအတွက်',
                        labelStyle: new TextStyle(fontSize: 12.0),
                        hintText: "0",
                      ),
                      maxLength: ConstantUtils.INPUT_FIELD_LENGTH,
                      keyboardType: TextInputType.number,
                    ),
                    buildLabelWidget('တစ်လဝင်ငွေ x လအရေအတွက်'),
                    buildMainLabelWidget('${state.totalMonthlyIncome}'),
                    TextFormField(
                      controller: _bonusController,
                      decoration: InputDecoration(
                        labelText: 'နှစ်စဉ်ကြေး',
                        labelStyle: new TextStyle(fontSize: 12.0),
                        hintText: "0",
                      ),
                      maxLength: ConstantUtils.INPUT_FIELD_LENGTH,
                      keyboardType: TextInputType.number,
                    ),
                    TextFormField(
                      controller: _pocketMoneyController,
                      decoration: InputDecoration(
                        labelText: 'ဂရုဏာကြေး',
                        labelStyle: new TextStyle(fontSize: 12.0),
                        hintText: "0",
                      ),
                      maxLength: ConstantUtils.INPUT_FIELD_LENGTH,
                      keyboardType: TextInputType.number,
                    ),
                    TextFormField(
                      controller: _underTableMoneyController,
                      decoration: InputDecoration(
                        labelText: 'အခကြေးငွေ',
                        labelStyle: new TextStyle(fontSize: 12.0),
                        hintText: "0",
                      ),
                      maxLength: ConstantUtils.INPUT_FIELD_LENGTH,
                      keyboardType: TextInputType.number,
                    ),
                    TextFormField(
                      controller: _commissionController,
                      decoration: InputDecoration(
                        labelText: 'ကော်မရှင်',
                        labelStyle: new TextStyle(fontSize: 12.0),
                        hintText: "0",
                      ),
                      maxLength: ConstantUtils.INPUT_FIELD_LENGTH,
                      keyboardType: TextInputType.number,
                    ),
                    TextFormField(
                      controller: _allowanceController,
                      decoration: InputDecoration(
                        labelText: 'အကျိုးခံစားခွင့်',
                        labelStyle: new TextStyle(fontSize: 12.0),
                        hintText: "0",
                      ),
                      maxLength: ConstantUtils.INPUT_FIELD_LENGTH,
                      keyboardType: TextInputType.number,
                    ),
                    buildLabelWidget('စုစုပေါင်းဝင်ငွေ'),
                    buildMainLabelWidget('${state.totalIncome}'),
                    new Padding(
                      padding: new EdgeInsets.only(top: 8.0, bottom: 8.0),
                    ),
                    state.yearOptionIndex > 1
                        ? buildLabelWidget(
                            '(၄၈)သိန်းကျော်မှသာလျှင် ၂၀၁၆ ခုနှစ် ပြည်ထောင်စု၏ အခွန်အကောက်ဥပဒေ ပုဒ်မ ၁၉ (က) အရ အခွန်စည်းကြပ်မည်')
                        : Container(),
                    Center(
                      child: Text(
                        'သက်သာခွင့်များ',
                        style: new TextStyle(
                            fontSize: 18.0, fontWeight: FontWeight.bold),
                      ),
                    ),
                    new Padding(
                      padding: new EdgeInsets.only(top: 8.0, bottom: 8.0),
                    ),
                    buildLabelWidget(
                        'အခြေခံသက်သာခွင့် (စုစုပေါင်းဝင်ငွေ၏ ၂၀% ကျပ်သိန်း ၁၀၀ ထိ)'),
                    buildMainLabelWidget('${state.basicAllowance}'),
                    state.isParentAllowanceIncluded
                        ? TextFormField(
                            controller: _noOfParentController,
                            decoration: InputDecoration(
                              labelText: 'အတူနေမိဘဦးရေ',
                              labelStyle: new TextStyle(fontSize: 12.0),
                              hintText: "0",
                            ),
                            maxLength: 1,
                            keyboardType: TextInputType.number,
                          )
                        : Container(),
                    state.isParentAllowanceIncluded
                        ? buildLabelWidget('အတူနေမိဘအတွက် သက်သာခွင့်')
                        : Container(),
                    state.isParentAllowanceIncluded
                        ? buildMainLabelWidget('${state.parentAllowance}')
                        : Container(),
                    new Padding(
                      padding: new EdgeInsets.only(top: 8.0, bottom: 8.0),
                    ),
                    Text(
                      'အိမ်ထောင်ဖက်/အလုပ်အကိုင်',
                      style: new TextStyle(fontSize: 12.0),
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
                        ]),
                    buildLabelWidget('အိမ်ထောင်ဖက်အတွက် သက်သာခွင့်'),
                    buildMainLabelWidget('${state.partnerAllowance}'),
                    TextFormField(
                      controller: _childrenAllowanceController,
                      decoration: InputDecoration(
                        labelText:
                            'အသက် ၁၈ နှစ်မပြည့်သော သား/သမီး\n၁၈ နှစ်ပြည့်ပြီး ပညာသင်ကြားဆဲ အိမ်ထောင်မရှိသားသမီးအရေအတွက်',
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
                      padding: new EdgeInsets.only(top: 8.0, bottom: 8.0),
                    ),
                    buildLabelWidget('သက်သာခွင့်စုစုပေါင်း'),
                    buildMainLabelWidget('${state.totalReductionAmount}'),
                    new Padding(
                      padding: new EdgeInsets.only(top: 8.0, bottom: 8.0),
                    ),
                    buildLabelWidget(
                        'အခွန်စည်းကြပ်ရန်ဝင်ငွေ (စုစုပေါင်းဝင်ငွေ - သက်သာခွင့်များ)'),
                    buildMainLabelWidget('${state.taxableAmount}'),
                    new Padding(
                      padding: new EdgeInsets.only(top: 8.0, bottom: 8.0),
                    ),
                    buildLabelWidget('ကျသင့်ဝင်ငွေခွန်(${state.totalMonth} လ)'),
                    buildMainLabelWidget('${state.taxAmount}'),
                    ListView.builder(
                      itemBuilder: (context, index) {
                        return ExpansionTile(
                          title: ListTile(
                              leading: Text('ဝင်ငွေ'),
                              trailing: Text('ရာခိုင်နှုန်း')),
                          children: <Widget>[
                            new Column(
                              children: _buildExpandableContent(
                                  state.selectedRuleItems),
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
        });
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
