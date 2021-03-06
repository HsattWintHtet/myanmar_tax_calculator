import 'package:flutter/material.dart';
import 'package:myanmar_tax_calculator/src/model/Lottery_result_param.dart';
import 'package:myanmar_tax_calculator/src/presenter/lottery_list_presenter.dart';
import 'package:myanmar_tax_calculator/src/presenter/lottery_result_presenter.dart';
import 'package:myanmar_tax_calculator/src/ui/model/LotteryResultUIParam.dart';
import 'package:myanmar_tax_calculator/src/ui/utils/constant_utils.dart';


class LotteryNoRegFragment extends StatefulWidget {
  LotteryNoRegFragment();

  @override
  _MyAppState createState() => new _MyAppState();
}

class _MyAppState extends State<LotteryNoRegFragment> {

  int _radioValue1 = 0;
  String _charLabel = 'တစ်စောင်ချင်းစီကို(comma,)ခံပေးပါ(က ၁၂၃၄၅၆,ခ ၁၂၃၄၅၈)';

  int _charLength;
  final Map<String, String> _checkingForms = {
    '1': 'တစ်စောင်ချင်း',
    '2': 'အက္ခရာအတွဲ',
    '3': 'ဂဏန်းအတွဲ'
  };

  // to show the related with checkingForms key 1
  bool visible1 = true;

  // to show the related with _checkingForms key 2
  bool visible2 = false;

  // to show the related with checkingForms key 3
  bool visible3 = false;

  LotteryResultUIParam lotteryParam = LotteryResultUIParam(2, '1');

  final _formKey = GlobalKey<FormState>();

  LotteryListPresenter savedResultPresenter;
  LotteryResultPresenter lotteryPresenter;

  @override
  void initState() {
    super.initState();

    lotteryPresenter = LotteryResultPresenter();
    savedResultPresenter = LotteryListPresenter();

    _savedResultPresenterEvents();
  }

  void _savedResultPresenterEvents() {
    lotteryPresenter.eventBus.on<ProgressDialogEvent>().listen((event) {
      print('dialog loading event ${event.isLoading}');
      if(event.isLoading) {
        ConstantUtils.progressLoadingDialog('Processing...', context);
      } else {
        Navigator.of(context).pop();
      }
    });

    savedResultPresenter.eventBus.on<SaveResultResponseEvent>().listen((event) {
      print('in ui ${event.value}');
      ConstantUtils.showSnackBar(event.value, context);
    });
  }

  @override
  Widget build(BuildContext context) {
    return _buildBodyWidget();
  }

  Widget _buildBodyWidget() {
    return DropdownButtonHideUnderline(
        child: ListView(
          shrinkWrap: true,
          padding: const EdgeInsets.all(20.0),
          children: <Widget>[
            new Container(
                padding: EdgeInsets.only(bottom: 0, left: 0, right: 0, top: 5),
                child: Form(
                  key: _formKey,
                  child: new Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: <Widget>[
                      new Padding(
                        padding: new EdgeInsets.all(8.0),
                      ),
                      new Text(
                        'အောင်ဘာလေထီအမျိုးအစား',
                        style: new TextStyle(
                          fontSize: 12.0,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      new Padding(
                        padding: new EdgeInsets.all(8.0),
                      ),
                      new Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            new Radio(
                              value: 0,
                              groupValue: _radioValue1,
                              onChanged: _handleRadioValueChange1,
                            ),
                            new Text(
                              '၁၀၀၀',
                              style: new TextStyle(fontSize: 16.0),
                            ),
                          ]
                      ),
                      TextFormField(
                          decoration: InputDecoration(
                            labelText: "အကြိမ်မြောက်",
                            labelStyle: new TextStyle(fontSize: 12.0),
                            hintText: "1",
                          ),
                          maxLength: 3,
                          validator: (value) {
                            if (value.isEmpty) {
                              return 'အကြိမ်မြောက်ကို ရိုက်ထည့်ပေးပါ';
                            }
                          },
                          keyboardType: TextInputType.number,
                          onSaved: (String value) {
                            // keep the value for RESTful param
                            lotteryParam.numOfTimes = int.parse(value);
                          }
                      ),

                      InputDecorator(
                        decoration: const InputDecoration(
                          labelText: 'တိုက်စစ်လိုသော ပုံစံကို ရွေးချယ်ပေးပါ',
                          contentPadding: EdgeInsets.zero,
                        ),
                        isEmpty: false,
                        child: DropdownButton<String>(
                          value: lotteryParam.checkingType == null
                              ? '1'
                              : lotteryParam.checkingType,
                          onChanged: (String newValue) {
                            setState(() {
                              // assign for param
                              lotteryParam.checkingType = newValue;
                              _hideOrShowWidget(newValue);
                            });
                          },
                          items: _checkingForms.entries.map((
                              MapEntry<String, String> e) {
                            return DropdownMenuItem<String>(
                              value: e.key,
                              child: Text(e.value),
                            );
                          }).toList(),
                        ),
                      ),
                      new Padding(
                        padding: new EdgeInsets.all(8.0),
                      ),
                      Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            new Flexible(
                                child: Container(
                                  padding: const EdgeInsets.only(right: 8),
                                  child: TextFormField(
                                      decoration: InputDecoration(
                                        labelText: _charLabel,
                                        labelStyle: new TextStyle(
                                            fontSize: 12.0),
                                        hintText: "က",
                                      ),
                                      maxLength: _charLength,
                                      validator: (value) {
                                        if (value.isEmpty) {
                                          return '$_charLabel ရိုက်ထည့်ပေးပါ';
                                        }
                                      },
                                      keyboardType: TextInputType.text,
                                      onSaved: (String value) {
                                        // keep the value for RESTful param
                                        lotteryParam.character1 = value;
                                      }
                                  ),
                                )
                            ),
                            visible2 ? new Flexible(
                                child: Container(
                                    child: TextFormField(
                                        decoration: InputDecoration(
                                          labelText: 'အက္ခရာ',
                                          labelStyle: new TextStyle(
                                              fontSize: 12.0),
                                          hintText: "က",
                                        ),
                                        maxLength: 2,
                                        validator: (value) {
                                          if (value.isEmpty) {
                                            return 'အက္ခရာ ရိုက်ထည့်ပေးပါ';
                                          }
                                        },
                                        keyboardType: TextInputType.text,
                                        onSaved: (String value) {
                                          // keep the value for RESTful param
                                          lotteryParam.character2 = value;
                                        }
                                    )
                                )
                            ) : Container(),

                          ]
                      ),
                      new Padding(
                        padding: new EdgeInsets.all(8.0),
                      ),
                      Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            visible2 || visible3 ? new Flexible(
                                child: Container(
                                    padding: const EdgeInsets.only(right: 8),
                                    child: TextFormField(
                                        decoration: InputDecoration(
                                          labelText: 'ဂဏန်း',
                                          labelStyle: new TextStyle(
                                              fontSize: 12.0),
                                          hintText: "၁၂၃၄၅၆",
                                        ),
                                        maxLength: 6,
                                        validator: (value) {
                                          if (value.isEmpty) {
                                            return 'ဂဏန်း ရိုက်ထည့်ပေးပါ';
                                          }

                                          if (value.length < 6) {
                                            return 'ဂဏန်း 6လုံးရိုက်ထည့်ပေးပါ';
                                          }
                                        },
                                        keyboardType: TextInputType.number,
                                        onSaved: (String value) {
                                          // keep the value for RESTful param
                                          lotteryParam.number1 = value;
                                        }
                                    )
                                )
                            ) : Container(),
                            visible3 ? new Flexible(
                                child: Container(

                                    child: TextFormField(
                                        decoration: InputDecoration(
                                          labelText: 'ဂဏန်း',
                                          labelStyle: new TextStyle(
                                              fontSize: 12.0),
                                          hintText: "၁၂၃၄၅၆",
                                        ),
                                        maxLength: 6,
                                        validator: (value) {
                                          if (value.isEmpty) {
                                            return 'ဂဏန်း ရိုက်ထည့်ပေးပါ';
                                          }

                                          if (value.length < 6) {
                                            return 'ဂဏန်း 6လုံးရိုက်ထည့်ပေးပါ';
                                          }
                                        },
                                        keyboardType: TextInputType.number,
                                        onSaved: (String value) {
                                          // keep the value for RESTful param
                                          lotteryParam.number2 = value;
                                        }
                                    )
                                )
                            ) : Container(),
                          ]
                      ),
                      ButtonBar(
                        mainAxisSize: MainAxisSize.min,
                        children: <Widget>[
                          RaisedButton(
                            child: Text('သိမ်းမည်'),
                            color: Colors.blue[900],
                            textColor: Colors.white,
                            onPressed: _saveData,
                          ),
                          RaisedButton(
                            child: Text(
                                'Clear', semanticsLabel: 'Clear BUTTON'),
                            onPressed: () {
                              _clearTextField();
                            },
                          ),
                        ],
                      ),
                    ],
                  ),
                )
            )
          ],
        )
    );
  }

  void _handleRadioValueChange1(int value) {
    setState(() {
      _radioValue1 = value;
    });
    lotteryParam.lotteryType = value;
  }

  void _hideOrShowWidget(String optionValue) {
    switch (optionValue) {
      case '1':
        _charLabel = 'တစ်စောင်ချင်းစီကို(comma,)ခံပေးပါ(က ၁၂၃၄၅၆,ခ ၁၂၃၄၅၈)';
        _charLength = null;
        visible1 = true;
        visible2 = false;
        visible3 = false;
        break;
      case '2':
        _charLabel = 'အက္ခရာ';
        _charLength = 2;
        visible1 = false;
        visible2 = true;
        visible3 = false;
        break;
      case '3':
        _charLabel = 'အက္ခရာ';
        _charLength = 2;
        visible1 = false;
        visible2 = false;
        visible3 = true;
        break;
    }
  }

  void _clearTextField() {
    _formKey.currentState?.reset();
  }

  void _saveData() {
    if (_formKey.currentState.validate()) {
      _formKey.currentState.save();
      LotteryResultParam param = LotteryResultParam(param: LotterySearchUtil.bakedResultParam(lotteryParam), numOfTime: lotteryParam.numOfTimes);
      savedResultPresenter.eventBus.fire(
          SaveResultEvent(param.numOfTime.toString(), param.param));
    }
  }

}

