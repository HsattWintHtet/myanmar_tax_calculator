import 'dart:async';

import 'package:flutter/material.dart';
import 'package:myanmar_tax_calculator/src/model/Lottery_result_param.dart';
import 'package:myanmar_tax_calculator/src/presenter/lottery_result_presenter.dart';
import 'package:myanmar_tax_calculator/src/ui/model/LotteryResultUIParam.dart';
import 'package:connectivity/connectivity.dart';
import 'package:myanmar_tax_calculator/src/ui/utils/constant_utils.dart';

class LotterySearchFragment extends StatefulWidget {
  @override
  _MyAppState createState() => new _MyAppState();
}

class _MyAppState extends State<LotterySearchFragment> {
  int _radioValue1 = 2;
  String _charLabel = 'တစ်စောင်ချင်းစီကို(comma,)ခံပေးပါ(က ၁၂၃၄၅၆,ခ ၁၂၃၄၅၈)';



  int _charLength;
  final Map<String, String> _checkingForms = {'1':'တစ်စောင်ချင်း', '2':'အက္ခရာအတွဲ', '3':'ဂဏန်းအတွဲ'};

  // to show the related with checkingForms key 1
  bool visible1 = true;

  // to show the related with _checkingForms key 2
  bool visible2 = false;

  // to show the related with checkingForms key 3
  bool visible3 = false;

  LotteryResultUIParam lotteryParam = LotteryResultUIParam(2, '1');

  final _formKey = GlobalKey<FormState>();

  String _connectionStatus;
  final Connectivity _connectivity = new Connectivity();
  //For subscription to the ConnectivityResult stream
  StreamSubscription<ConnectivityResult> _connectionSubscription;

  LotteryResultPresenter presenter;

  void _handleRadioValueChange1(int value) {
    setState(() {
      _radioValue1 = value;
    });
    lotteryParam.lotteryType = value;

  }

  @override
  void initState() {
    super.initState();
    // initConnectivity(); before calling on button press
    _connectionSubscription =
        _connectivity.onConnectivityChanged.listen((ConnectivityResult result) {
          setState(() {
            _connectionStatus = result.toString();
          });
        });
    print("Initstate : $_connectionStatus");

    presenter = LotteryResultPresenter();

    // register event bus
    _registerEvents();
  }
  
  void _registerEvents() {
    presenter.eventBus.on<ProgressDialogEvent>().listen((event) {
      print('dialog loading event ${event.isLoading}');
      if(event.isLoading) {
        ConstantUtils.progressLoadingDialog('Checking Lottery Result', context);
      } else {
        Navigator.of(context).pop();
      }
    });

    presenter.eventBus.on<LotteryResponseEvent>().listen((event) {
      print('in ui ${event.result}');
      ConstantUtils.showResultDialog('Checking Lottery Result', event.result.resultMsg??'Please try again.', context);
    });
  }

  //For cancelling the stream subscription...Good way to release resources
  @override
  void dispose() {
    _connectionSubscription.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return _buildBodyWidget();
  }


  Widget _buildBodyWidget() {
    return DropdownButtonHideUnderline(
        child: Center(
          child: ListView(
            shrinkWrap: true,
            padding: const EdgeInsets.all(20.0),
            children: <Widget>[
              new Container(
                  padding: EdgeInsets.only(bottom: 0,left: 0, right: 0,top: 5),
                  child: Form(
                    key: _formKey,
                    child: new Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: <Widget>[
                        new Padding(
                          padding: new EdgeInsets.all(8.0),
                        ),
                        new Text(
                          'အောင်ဘာလေထီအမျိုးအစားကို ရွေးချယ်ပေးပါ',
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
                                key: ConstantUtils.KEYS.elementAt(0),
                                value: 1,
                                groupValue: _radioValue1,
                                onChanged: _handleRadioValueChange1,
                              ),
                              new Text(
                                '၅၀၀',
                                style: new TextStyle(fontSize: 16.0),
                              ),
                              new Radio(
                                value: 2,
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
                          key: ConstantUtils.KEYS.elementAt(1),
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
                            key: ConstantUtils.KEYS.elementAt(2),
                            value: lotteryParam.checkingType==null?'1': lotteryParam.checkingType,
                            onChanged: (String newValue) {
                              setState(() {
                                // assign for param
                                lotteryParam.checkingType = newValue;
                                _hideOrShowWidgets(newValue);
                              });
                            },
                            items: _checkingForms.entries.map((MapEntry<String, String> e) {
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
                                    padding: const EdgeInsets.only(right:8),
                                    child: TextFormField(
                                        key: ConstantUtils.KEYS.elementAt(3),
                                        decoration: InputDecoration(
                                          labelText: _charLabel,
                                          labelStyle: new TextStyle(fontSize: 12.0),
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
                              visible2? new Flexible(
                                  child: Container(
                                      child: TextFormField(
                                          key: ConstantUtils.KEYS.elementAt(4),
                                          decoration: InputDecoration(
                                            labelText: 'အက္ခရာ',
                                            labelStyle: new TextStyle(fontSize: 12.0),
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
                              ): Container(),

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
                                      padding: const EdgeInsets.only(right:8),
                                      child: TextFormField(
                                          key: ConstantUtils.KEYS.elementAt(5),
                                          decoration: InputDecoration(
                                            labelText: 'ဂဏန်း',
                                            labelStyle: new TextStyle(fontSize: 12.0),
                                            hintText: "၁၂၃၄၅၆",
                                          ),
                                          maxLength: 6,
                                          validator: (value) {
                                            if (value.isEmpty) {
                                              return 'ဂဏန်း ရိုက်ထည့်ပေးပါ';
                                            }

                                            if(value.length < 6) {
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
                                            labelStyle: new TextStyle(fontSize: 12.0),
                                            hintText: "၁၂၃၄၅၆",
                                          ),
                                          maxLength: 6,
                                          validator: (value) {
                                            if (value.isEmpty) {
                                              return 'ဂဏန်း ရိုက်ထည့်ပေးပါ';
                                            }

                                            if(value.length < 6) {
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
                          key: ConstantUtils.KEYS.elementAt(8),
                          mainAxisSize: MainAxisSize.min,
                          children: <Widget>[
                            RaisedButton(
                              child: Text('တိုက်စစ်မည်'),
                              color: Colors.blue[900],
                              textColor: Colors.white,
                              onPressed: onSubmit,
                            ),
                            RaisedButton(
                              child: Text('Clear', semanticsLabel: 'Clear BUTTON'),
                              onPressed: (){
                                LotterySearchUtil.clearTextField(_formKey);
                              },
                            ),
                          ],
                        ),
                      ],
                    ),
                  )
              )
            ],
          ),
        )
    );
  }

  void onSubmit() async {

    var connectivityResult = await (Connectivity().checkConnectivity());

    if(connectivityResult == ConnectivityResult.mobile || connectivityResult == ConnectivityResult.wifi) {
      // check the input field null or empty
      if (_formKey.currentState.validate()) {
        _formKey.currentState.save();
        print(lotteryParam);
        String _param = _bakedResultParam();

        print('check param before call api:$_param');
        print('check lottery param:$lotteryParam');
        presenter.eventBus.fire(LotterySearchEvent(LotteryResultParam(param: _param, numOfTime: lotteryParam.numOfTimes)));
      }
    } else {
      ConstantUtils.showSnackBar("Please check your internet connection.", context);
    }

  }


  void _hideOrShowWidgets(String optionValue) {
    switch(optionValue) {
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


  String _bakedResultParam() {
    String _param = '';
    switch(lotteryParam.lotteryType) {
      case 0:
        _param += '200 ';
        break;
      case 1:
        _param += '500 ';
        break;
    }
    switch(lotteryParam.checkingType) {

      case '1': // find by single number:(က ၁၂၃၄၅၆)
          _param += lotteryParam.character1;
        break;

      case '2': // find by character range: char char number(က ည ၁၂၃၄၅၆)
        _param += '${lotteryParam.character1} ${lotteryParam.character2} ${lotteryParam.number1}';
        break;

      case '3': // find by number range: char num1 num2(က ၁၂၃၄၅၆ ၁၂၃၄၅၉)
        _param += '${lotteryParam.character1} ${lotteryParam.number1} ${lotteryParam.number2}';
        break;
    }
    print('baked param:$_param');
    return _param;
  }


}