/**
 *
    MIT License

    Copyright (c) 2018 Romain Rastel

    Permission is hereby granted, free of charge, to any person obtaining a copy
    of this software and associated documentation files (the "Software"), to deal
    in the Software without restriction, including without limitation the rights
    to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
    copies of the Software, and to permit persons to whom the Software is
    furnished to do so, subject to the following conditions:

    The above copyright notice and this permission notice shall be included in all
    copies or substantial portions of the Software.

    THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
    IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
    FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
    AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
    LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
    OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
    SOFTWARE.
 */

import 'dart:async';

import 'package:connectivity/connectivity.dart';

import 'package:flutter/material.dart';
import 'package:myanmar_tax_calculator/src/model/Lottery_result_param.dart';
import 'package:myanmar_tax_calculator/src/presenter/lottery_list_presenter.dart';
import 'package:myanmar_tax_calculator/src/presenter/lottery_result_presenter.dart';
import 'package:myanmar_tax_calculator/src/services/SharedPreferencesHelper.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:myanmar_tax_calculator/src/ui/utils/constant_utils.dart';


/// reference
/// https://github.com/letsar/flutter_slidable


class LotteryRegNoList extends StatefulWidget {
  const LotteryRegNoList({Key key}) : super(key: key);

  static const String routeName = '/material/leave-behind';


  @override
  LotteryRegNoListState createState() => LotteryRegNoListState();
}

class LotteryRegNoListState extends State<LotteryRegNoList> {
  List<SharedItem> dataList = new List();

  LotteryResultPresenter lotteryPresenter;
  LotteryListPresenter savedResultPresenter;

  Future<String> getData() async {
    await SharedPreferencesHelper.getAllParam().then((list) {
      print(list);
      this.setState(() {
        dataList = list;
      });
    });
    return "Success!";
  }

  @override
  void initState() {
    super.initState();

    lotteryPresenter = LotteryResultPresenter();
    savedResultPresenter = LotteryListPresenter();
    
    // register event bus
    _registerResultListPresenterEvents();

    _registerLotteryPresenterEvents();

    // publish event to load data
    savedResultPresenter.eventBus.fire(LoadResultEvent());
  }

  void _registerResultListPresenterEvents() {
    lotteryPresenter.eventBus.on<ProgressDialogEvent>().listen((event) {
      print('dialog loading event ${event.isLoading}');
      if(event.isLoading) {
        ConstantUtils.progressLoadingDialog('Processing...', context);
      } else {
        Navigator.of(context).pop();
      }
    });

    lotteryPresenter.eventBus.on<LotteryResponseEvent>().listen((event) {
      print('in ui ${event.result}');
      ConstantUtils.showResultDialog('Checking Lottery Result', event.result.resultMsg??'Please try again.', context);
    });
  }

  void _registerLotteryPresenterEvents() {
    savedResultPresenter.eventBus.on<ProgressDialogEvent>().listen((event) {
      print('dialog loading event ${event.isLoading}');
      if(event.isLoading) {
        ConstantUtils.progressLoadingDialog('Processing...', context);
      } else {
        Navigator.of(context).pop();
      }
    });

    savedResultPresenter.eventBus.on<LoadResultResponseEvent>().listen((event) {
      this.setState(() {
        dataList = event.resultList;
      });
    });

    savedResultPresenter.eventBus.on<ResultDeleteResponseEvent>().listen((event) {
      this.setState(() {
        dataList.remove(event.sharedItem);
      });
      ConstantUtils.showSnackBar('You deleted ${event.sharedItem.param}', context);
    });
  }

  void _handleDelete(SharedItem item) {
    AlertDialog dialog = AlertDialog(
      title: new Text("Confirmation",style: TextStyle(color: Colors.blue),),
      content: new Text('Are you Sure Want To Delete?'),
      actions: <Widget>[
        // usually buttons at the bottom of the dialog
        new FlatButton(
          child: new Text("CANCEL"),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
        new FlatButton(
          color: Colors.blue,
          child: new Text("YES", style: TextStyle(color: Colors.white),),
          onPressed: () {
            lotteryPresenter.eventBus.fire(ProgressDialogEvent(false));
            savedResultPresenter.eventBus.fire(ResultDeleteEvent(item));
          },
        ),
      ],
    );

    // flutter defined function
    showDialog(
      context: context,
      builder: (BuildContext context) => dialog,
      barrierDismissible: false,
    );
  }

  @override
  Widget build(BuildContext context) {
    Widget body;
    // ignore: null_aware_in_condition
    if (dataList.isEmpty) {
      body = Center(child: const Text('Add New Lottery Number'));
    } else {
      body = ListView(
        children: dataList.map<Widget>((SharedItem item) {
        return new Slidable(
          delegate: new SlidableDrawerDelegate(),
          actionExtentRatio: 0.25,
          child: new Container(
            color: Colors.white,
            child: new ListTile(
              leading: new CircleAvatar(
                backgroundColor: Colors.blue,
                child: new Text(item.numOfTimes),
                foregroundColor: Colors.white,
              ),
              title: new Text('(${item.numOfTimes}) အကြိမ်မြောက်'),
              subtitle: new Text(item.param),
            ),
          ),
          secondaryActions: <Widget>[
            new IconSlideAction(
              caption: 'Search',
              color: Colors.blueGrey,
              icon: Icons.search,
              onTap: () => _onSubmit(item),
            ),
            new IconSlideAction(
              caption: 'Delete',
              color: Colors.red,
              icon: Icons.delete,
              onTap: () => _handleDelete(item),
            ),
          ],
        );
      }
      ).toList()
      );
    }
    return body;
  }

  void _onSubmit(SharedItem item) async {

      var connectivityResult = await (Connectivity().checkConnectivity());

      if(connectivityResult == ConnectivityResult.mobile || connectivityResult == ConnectivityResult.wifi) {

        print('check lottery param:${item.param} $connectivityResult');
        lotteryPresenter.eventBus.fire(LotterySearchEvent(LotteryResultParam(param: item.param, numOfTime: int.parse(item.numOfTimes))));

      } else {
        ConstantUtils.showSnackBar("Please check your internet connection.", context);
      }

  }
}