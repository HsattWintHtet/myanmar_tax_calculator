import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:myanmar_tax_calculator/src/bloc/rental_service_tax/bloc.dart';
import 'package:myanmar_tax_calculator/src/ui/utils/constant_utils.dart';

/// ပစ္စည်းဌားရမ်းခလုပ်ငန်းမှဝင်ငွေခွန် တွက်ချက်ခြင်း
class RentalServiceTaxCalculationPage extends StatefulWidget {
  @override
  _MyAppState createState() => new _MyAppState();
}

class _MyAppState extends State<RentalServiceTaxCalculationPage> {
  final _formKey = GlobalKey<FormState>();

  final RentalServiceBloc _rentalServiceBloc = RentalServiceBloc();

  final _incomeController = TextEditingController();
  final _expenseController = TextEditingController();
  final _parentAllowanceController = TextEditingController();
  final _childrenAllowanceController = TextEditingController();
  final _partnerInsuranceController = TextEditingController();
  final _insuranceController = TextEditingController();
  final _ssbAmountController = TextEditingController();
  final _donationAmountController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _incomeController.addListener(_onIncomeTextChange);
    _expenseController.addListener(_onExpenseTextChange);
    _insuranceController.addListener(_onInsuranceTextChange);
    _parentAllowanceController.addListener(_onParentAllowanceTextChange);
    _childrenAllowanceController.addListener(_onChildrenAllowanceTextChange);
    _partnerInsuranceController.addListener((_onPartnerInsuranceTextChange));
    _ssbAmountController.addListener(_onSSBAmountTextChange);
    _donationAmountController.addListener(_onDonationTextChange);

  }
  
  void _onIncomeTextChange() {
    _rentalServiceBloc.dispatch(IncomeTextChangeEvent(
        int.tryParse(_incomeController.text)==null?
        0 : int.parse(_incomeController.text)));
  }

  void _onExpenseTextChange() {
    _rentalServiceBloc.dispatch(ExpenseTextChangeEvent(
        int.tryParse(_expenseController.text)==null?
        0 : int.parse(_expenseController.text)));
  }

  void _onParentAllowanceTextChange() {
    int value = int.tryParse(_parentAllowanceController.text);
    if(value != null && value <= 4) {
      _rentalServiceBloc.dispatch(ParentAllowanceTextChangeEvent(value));
    }
  }

  void _onPartnerInsuranceTextChange() {
    _rentalServiceBloc.dispatch(PartnerInsuranceTextChangeEvent(
        int.tryParse(_partnerInsuranceController.text)==null?
        0 : int.parse(_partnerInsuranceController.text)));
  }

  void _onInsuranceTextChange() {
    _rentalServiceBloc.dispatch(InsuranceTextChangeEvent(
        int.tryParse(_insuranceController.text)==null?
        0 : int.parse(_insuranceController.text)));
  }

  void _onSSBAmountTextChange() {
    _rentalServiceBloc.dispatch(SSBAmountTextChangeEvent(
        int.tryParse(_ssbAmountController.text)==null?
        0 : int.parse(_ssbAmountController.text)));
  }

  void _onDonationTextChange() {
    _rentalServiceBloc.dispatch(DonationTextChangeEvent(
        int.tryParse(_donationAmountController.text)==null?
        0 : int.parse(_donationAmountController.text)));
  }


  void _onChildrenAllowanceTextChange() {
    _rentalServiceBloc.dispatch(ChildrenAllowanceTextChangeEvent(
        int.tryParse(_childrenAllowanceController.text)==null?
        0 : int.parse(_childrenAllowanceController.text)));
  }

  void _onClearTextField() {
    _incomeController.clear();
    _expenseController.clear();
    _insuranceController.clear();
    _parentAllowanceController.clear();
    _childrenAllowanceController.clear();
    _partnerInsuranceController.clear();
    _ssbAmountController.clear();
    _donationAmountController.clear();

    _rentalServiceBloc.dispatch(ClearEvent());
  }

  @override
  void dispose() {
    _incomeController.dispose();
    _expenseController.dispose();
    _insuranceController.dispose();
    _parentAllowanceController.dispose();
    _donationAmountController.dispose();
    _childrenAllowanceController.dispose();
    _partnerInsuranceController.dispose();
    _ssbAmountController.dispose();

    _rentalServiceBloc.dispose();
    super.dispose();
  }

  void _onMaritalStatusOptionChange(int value) {
    _rentalServiceBloc.dispatch(MaritalStatusChangeEvent(value));
  }

  void _onServiceTypeOptionChange(int value) {
    _rentalServiceBloc.dispatch(ServiceTypeOptionChangeEvent(value));
  }

  void _onYearOptionChange(int newValue) {
    _rentalServiceBloc.dispatch(YearOptionChangeEvent(newValue));
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder(
      bloc: _rentalServiceBloc,
      builder: (BuildContext context, RentalServiceState state) {
        _parentAllowanceController.text = '${state.noOfParents}';
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
                    items: _rentalServiceBloc.yearList.entries.map((MapEntry<int, List> e) {
                      return DropdownMenuItem<int>(
                        value: e.key,
                        child: Text(e.value[0]),
                      );
                    }).toList(),
                  ),
                ),
              ),
              Text('ဝင်ငွေကာလ (၁-၄-${state.startYear}) မှ (၃၁-၃-${state.endYear}) ထိ'
                  , style: TextStyle(fontSize: 12.0, color: Colors.blueGrey)),
              new Padding(
                padding: new EdgeInsets.all(8.0),
              ),
              state.yearOptionIndex != 3 ? Wrap(
                  children: [
                    Text('ကုန်စည်/ဝန်ဆောင်မှုအမျိုးအစား',
                      style: new TextStyle(
                          fontSize: 12.0),

                    ),
                    Row(
                      children: <Widget>[
                        new Radio(
                          value: 0,
                          groupValue: state.serviceTypeOptionIndex,
                          onChanged: _onServiceTypeOptionChange,
                        ),
                        new Text(
                          'စီးပွားဖြစ်ဌားရမ်းခြင်း',
                          style: new TextStyle(fontSize: 12.0),
                        ),
                        new Radio(
                          value: 1,
                          groupValue: state.serviceTypeOptionIndex,
                          onChanged: _onServiceTypeOptionChange,
                        ),
                        new Text(
                          'အခြား',
                          style: new TextStyle(fontSize: 12.0),
                        ),
                      ],
                    )
                  ]
              ) : Container(),
              TextFormField(
                  controller: _incomeController,
                  decoration: InputDecoration(
                    labelText: 'ဝင်ငွေ (ကုန်သွယ်လုပ်ငန်းခွန် ${state.serviceTypeTaxDesc})',
                    labelStyle: new TextStyle(fontSize: 12.0),
                    hintText: "0",
                    counterText: '',
                  ),
                  validator: (value) {
                    if (value.isEmpty) {
                      return 'ရိုက်ထည့်ပေးပါ';
                    } else {
                      double val = double.parse(value);
                      if (val < 0)
                        return 'invalid. Should not be minus value.';
                    }
                  },
                  maxLength: ConstantUtils.INPUT_FIELD_LENGTH,
                  keyboardType: TextInputType.number,
                  ),
              new Padding(
                padding: new EdgeInsets.all(8.0),
              ),
              _buildLabelWidget('ကျသင့်ကုန်သွယ်လုပ်ငန်းခွန်(ဝင်ငွေx အခွန်ရာခိုင်နှုန်း) / (၁၀၀+အခွန်ရာခိုင်နှုန်း)'),
              _buildMainLabelWidget('${state.tradingTaxAmount}'),
              new Padding(
                padding: new EdgeInsets.all(8.0),
              ),
              Text('${_rentalServiceBloc.yearInfoMap[state.yearOptionIndex]}'
                  , style: TextStyle(fontSize: 12.0, color: Colors.blueGrey)),
              TextFormField(
                  controller: _expenseController,
                  decoration: InputDecoration(
                    labelText: '(နုတ်) ကုန်ကျစရိတ်များ',
                    labelStyle: new TextStyle(fontSize: 12.0),
                    hintText: "0",
                  ),
                  maxLength: ConstantUtils.INPUT_FIELD_LENGTH,
                  keyboardType: TextInputType.number,
              ),
              _buildLabelWidget('စုစုပေါင်းဝင်ငွေ (ဝင်ငွေ - ကုန်သွယ်လုပ်ငန်းခွန် - ကုန်ကျစရိတ်များ)'),
              _buildMainLabelWidget('${state.totalIncome}'),
              new Padding(
                padding: new EdgeInsets.only(top: 8.0, bottom: 8.0),
              ),
              Center(
                child: Text('သက်သာခွင့်များ',
                  style: new TextStyle(
                      fontSize: 14.0, fontWeight: FontWeight.bold),

                ),
              ),
              _buildLabelWidget('အခြေခံသက်သာခွင့် (စုစုပေါင်းဝင်ငွေ၏ ၂၀% ကျပ်သိန်း ၁၀၀ ထိ)'),
              _buildMainLabelWidget('${state.basicAllowance}'),
              state.isParentAllowanceIncluded ? TextFormField(
                  controller: _parentAllowanceController,
                  decoration: InputDecoration(
                    labelText: 'အတူနေမိဘဦးရေ(အတူနေမိဘ ၄ ဦးထက်မပိုရပါ)',
                    labelStyle: new TextStyle(fontSize: 12.0),
                    hintText: "0",
                  ),

                  validator: (value) {
                    if(value != null) {
                      int val = int.parse(value);
                      if (val < 0 || val > 4)
                        return 'အတူနေမိဘ ၄ ဦးထက်မပိုရပါ';
                    }
                  },
                  maxLength: 1,
                  keyboardType: TextInputType.number,
              ) : Container(),
              state.isParentAllowanceIncluded ?
              _buildLabelWidget('အတူနေမိဘအတွက် သက်သာခွင့်'):
              Container(),
              state.isParentAllowanceIncluded ?
              _buildMainLabelWidget('${state.parentAllowance}'):Container(),
              new Padding(
                padding: new EdgeInsets.only(top: 8.0, bottom: 8.0),
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
              _buildLabelWidget('အိမ်ထောင်ဖက်အတွက် သက်သာခွင့်'),
              _buildMainLabelWidget('${state.partnerAllowance}'),
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
            _buildLabelWidget('သား/သမီးအတွက် သက်သာခွင့်'),
            _buildMainLabelWidget('${state.childrenAllowance}'),
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
              _buildLabelWidget('စုစုပေါင်းဝင်ငွေ၏ ၂၅% အထိသာ'),
              _buildMainLabelWidget('${state.income25PercentDeduction}'),
              _buildLabelWidget('သက်သာခွင့်စုစုပေါင်း'),
              _buildMainLabelWidget('${state.totalDeduction}'),
              _buildLabelWidget('အခွန်စည်းကြပ်ရန်ဝင်ငွေ (စုစုပေါင်းဝင်ငွေ - သက်သာခွင့်များ)'),
              _buildMainLabelWidget('${state.taxableAmount}'),
              _buildLabelWidget('ကျသင့်ဝင်ငွေခွန်(၁၀ ရာခိုင်နှုန်း)'),
              _buildMainLabelWidget('${state.taxAmount}'),
              Container(
                child:
                RaisedButton(
                  color: Colors.blueGrey,
                  child: Text('Clear', style: TextStyle(color: Colors.white),),
                  onPressed: _onClearTextField,
                ),
              ),
            ]
        ),
      );
    });
  }

  Text _buildLabelWidget(String label) {
    return Text(
      label,
      style: new TextStyle(
        fontSize: 12.0,
        fontWeight: FontWeight.bold,
      ),
    );
  }

  Text _buildMainLabelWidget(String label) {
    return Text(
      label,
      style: new TextStyle(
          fontSize: 18.0,
          fontWeight: FontWeight.bold,
          color: Colors.blue),
    );
  }
}