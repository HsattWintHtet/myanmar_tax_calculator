import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:myanmar_tax_calculator/src/bloc/profit_tax/bloc.dart';
import 'package:myanmar_tax_calculator/src/ui/utils/constant_utils.dart';

/// အခြေပစ္စည်းမှမြတ်စွန်းငွေတွက်ချက်ခြင်း
class ProfitTaxCalculationPage extends StatefulWidget {
  @override
  _MyAppState createState() => new _MyAppState();
}

class _MyAppState extends State<ProfitTaxCalculationPage> {
  final _formKey = GlobalKey<FormState>();

  ProfitTaxBloc _profitTaxBloc = ProfitTaxBloc();

  final _pricingByOrgController = TextEditingController(); // ၃။ ရောင်းချသည့်နေ့ရှိ ကာလတန်းဖိုစိစစ်သတ်မှတ်ရေးအဖွဲ့က သတ်မှတ်သည့်အခြေပစ္စည်းတန်ဖိုး
  final _inHandPricingController = TextEditingController(); // (၂)(၁) လက်ဝယ်ရရှိသည့်နေ့တန်ဖိုး
  final _depreciationController = TextEditingController(); // (၂)(-) လက်ဝယ်ရရှိသည့်နေ့မှ ရောင်းချသည့်နေ့အထိ ပစ္စည်းတန်ဖို့လျော့စုစုပေါင်း
  final _additionalValueController = TextEditingController(); //  (ခ) ဖြည့်စွက်တန်ဖိုး (ခြံကာ/ရေတွင်းတူး စသည့်)
  final _marketingCostController = TextEditingController(); //  (ဂ) ရောင်းချစရိတ် (ကြော်ငြာခ/ပွဲစားခ စသည်များ)

  @override
  void initState() {
    super.initState();

    _pricingByOrgController.addListener(_onPricingByOrgTextChange);

    _inHandPricingController.addListener(_onInHandPricingTextChange);

    _depreciationController.addListener(_onDepreciationPricingTextChange);

    _additionalValueController.addListener(_onAdditionalValueTextChange);

    _marketingCostController.addListener(_marketingCostTextChange);
  }

  void _clearTextField() {

    _inHandPricingController.clear();
    _pricingByOrgController.clear();
    _depreciationController.clear();
    _additionalValueController.clear();
    _marketingCostController.clear();

    _profitTaxBloc.dispatch(ClearEvent());
  }

  @override
  void dispose() {
    _inHandPricingController.dispose();
    _pricingByOrgController.dispose();
    _depreciationController.dispose();
    _additionalValueController.dispose();
    _marketingCostController.dispose();

    _profitTaxBloc.dispose();

    super.dispose();
  }

  void _onInHandPricingTextChange() {
    _profitTaxBloc.dispatch(InHandPricingChangeEvent(
        int.tryParse(_inHandPricingController.text)==null?
        0 : int.parse(_inHandPricingController.text)));
  }

  void _marketingCostTextChange() {
    _profitTaxBloc.dispatch(MarketingCostChangeEvent(
        int.tryParse(_marketingCostController.text)==null?
        0 : int.parse(_marketingCostController.text)));
  }

  void _onPricingByOrgTextChange() {
    _profitTaxBloc.dispatch(PricingByOrgChangeEvent(
        int.tryParse(_pricingByOrgController.text)==null?
        0 : int.parse(_pricingByOrgController.text)));
  }

  void _onDepreciationPricingTextChange() {
    _profitTaxBloc.dispatch(DepreciationChangeEvent(
        int.tryParse(_depreciationController.text)==null?
        0 : int.parse(_depreciationController.text)));
  }

  void _onAdditionalValueTextChange() {
    _profitTaxBloc.dispatch(AdditionalValueChangeEvent(
        int.tryParse(_additionalValueController.text)==null?
        0 : int.parse(_additionalValueController.text)));
  }


  void _onYearOptionChange(int newValue) {
    _profitTaxBloc.dispatch(YearOptionChangeEvent(newValue));
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder (
      bloc: _profitTaxBloc,
      builder: (BuildContext context, ProfitState state) {
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
                        'အခြေပစ္စည်းမှမြတ်စွန်းငွေတွက်ချက်ခြင်း',
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
                        items: _profitTaxBloc.yearList.entries.map((
                            MapEntry<int, String> e) {
                          return DropdownMenuItem<int>(
                            value: e.key,
                            child: Text(e.value),
                          );
                        }).toList(),
                      ),
                    ),
                  ),
                  _buildLabelWidget('၂။ ရောင်းချသည့်နေ့ (၁-၄-${state
                      .startYear}) မှ (၃၁-၃-${state.endYear}) ထိ'),
                  new Padding(
                    padding: new EdgeInsets.all(8.0),
                  ),
                  TextFormField(
                    controller: _pricingByOrgController,
                    decoration: InputDecoration(
                      labelText: '၃။ ရောင်းချသည့်နေ့ရှိ ကာလတန်းဖိုစိစစ်သတ်မှတ်ရေးအဖွဲ့က \nသတ်မှတ်သည့်အခြေပစ္စည်းတန်ဖိုး',
                      labelStyle: new TextStyle(fontSize: 12.0),
                      hintText: "0",
                    ),
                    maxLength: ConstantUtils.INPUT_FIELD_LENGTH,
                    keyboardType: TextInputType.number,
                  ),
                  new Padding(
                    padding: new EdgeInsets.only(top: 8.0, bottom: 8.0),
                  ),
                  Text('၄။ (နှုတ်) ခွင့်ပြုစရိတ်များ',
                      style: new TextStyle(
                          fontSize: 14.0, fontWeight: FontWeight.bold),
                  ),
                  new Padding(
                    padding: new EdgeInsets.only(top: 8.0, bottom: 8.0),
                  ),
                  Text('(က) ရောင်းချသည့်နေ့ရှိပစ္စည်းတန်ဖိုး'
                      ,
                      style: TextStyle(fontSize: 12.0, color: Colors.blueGrey)),
                  TextFormField(
                    controller: _inHandPricingController,
                    decoration: InputDecoration(
                      labelText: '(၁) လက်ဝယ်ရရှိသည့်နေ့တန်ဖိုး',
                      labelStyle: new TextStyle(fontSize: 12.0),
                      hintText: "0",
                      counterText: '',
                    ),
                    keyboardType: TextInputType.number,
                  ),
                  TextFormField(
                    controller: _depreciationController,
                    decoration: InputDecoration(
                      labelText: '(၂)(-) လက်ဝယ်ရရှိသည့်နေ့မှ ရောင်းချသည့်နေ့အထိ ပစ္စည်းတန်ဖို့လျော့စုစုပေါင်း',
                      labelStyle: new TextStyle(fontSize: 12.0),
                      hintText: "0",
                    ),
                    maxLength: ConstantUtils.INPUT_FIELD_LENGTH,
                    keyboardType: TextInputType.number,
                  ),
                  _buildLabelWidget('ရောင်းချနေ့ရှိ ပစ္စည်းတန်ဖိုး (က(၁) - က(၂))'),
                  _buildMainLabelWidget('${state.sellingPrice}'),
                  TextFormField(
                    controller: _additionalValueController,
                    decoration: InputDecoration(
                      labelText: '(ခ) ဖြည့်စွက်တန်ဖိုး (ခြံကာ/ရေတွင်းတူး စသည့်)',
                      labelStyle: new TextStyle(fontSize: 12.0),
                      hintText: "0",
                    ),
                    maxLength: ConstantUtils.INPUT_FIELD_LENGTH,
                    keyboardType: TextInputType.number,
                  ),
                  TextFormField(
                    controller: _marketingCostController,
                    decoration: InputDecoration(
                      labelText: '(ဂ) ရောင်းချစရိတ် (ကြော်ငြာခ/ပွဲစားခ စသည်များ)',
                      labelStyle: new TextStyle(fontSize: 12.0),
                      hintText: "0",
                    ),
                    maxLength: ConstantUtils.INPUT_FIELD_LENGTH,
                    keyboardType: TextInputType.number,
                  ),
                  _buildLabelWidget('ခွင့်ပြုစရိတ်စုစုပေါင်း (က + ခ + ဂ)'),
                  _buildMainLabelWidget('${state.totalAllowrance}'),
                  _buildLabelWidget('၅။ အခြေပစ္စည်းမှမြတ်စွန်းငွေ (၃ - ၄)'),
                  _buildMainLabelWidget('${state.profit}'),
                  _buildLabelWidget('၆။ ကျသင့်အခွန် (မြတ်စွန်းငွေ၏ ၁၀%)'),
                  _buildMainLabelWidget('${state.taxAmount}'),
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