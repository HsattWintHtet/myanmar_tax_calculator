import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:myanmar_tax_calculator/src/ui/tax/corporate_tax_page.dart';
import 'package:myanmar_tax_calculator/src/ui/about_us_fragment.dart';
import 'package:myanmar_tax_calculator/src/ui/tax/rental_service_tax_page.dart';
import 'package:myanmar_tax_calculator/src/ui/tax/individual_business_tax_page.dart';
import 'package:myanmar_tax_calculator/src/ui/tax/profit_tax_page.dart';
import 'package:myanmar_tax_calculator/src/ui/tax/salary_tax_page.dart';
import 'package:myanmar_tax_calculator/src/ui/tax/black_income_tax_calculation_page.dart';
import 'package:myanmar_tax_calculator/src/ui/tax/thet_mawe_tax_page.dart';

import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:firebase_analytics/observer.dart';
import 'package:myanmar_tax_calculator/src/ui/utils/constant_utils.dart';

class DrawerItem {
  String title;
  IconData icon;
  int index;
  DrawerItem(this.title, this.icon, this.index);
}

class HomePage extends StatefulWidget {

  final drawerItems = [
//    new DrawerItem("Lottery Result", Icons.search,0), TODO add later
    new DrawerItem("စည်းကြပ်မှုမှလွတ်ကင်းနေသောဝင်ငွေခွန်", Icons.search,1),
    new DrawerItem("စီးပွားရေးလုပ်ငန်း (Corporate)", Icons.search,2),
    new DrawerItem("လစာဝင်ငွေခွန်တွက်ချက်ခြင်း", Icons.search,3),
    new DrawerItem("အခြေခံပစ္စည်းမှမြတ်စွန်းငွေ", Icons.search,4),
    new DrawerItem("အသက်မွေး ပညာလုပ်ငန်းမှဝင်ငွေခွန်", Icons.search,5),
    new DrawerItem("စီးပွားရေးလုပ်ငန်းမှဝင်ငွေခွန်(Individual)", Icons.search,6),
    new DrawerItem("ပစ္စည်းဌားရမ်းခလုပ်ငန်းမှဝင်ငွေခွန်", Icons.search,7),
//    new DrawerItem("Lottery Number Register", Icons.save,8), TODO add later
//    new DrawerItem("Lottery Number List", Icons.list,9), TODO add later
    new DrawerItem("About Us", Icons.info,10),
  ];

  @override
  State<StatefulWidget> createState() {
    return new HomePageState();
  }

}

class HomePageState extends State<HomePage> with RouteAware {

  int _selectedDrawerIndex = 0;

  static FirebaseAnalytics analytics = FirebaseAnalytics();
  static FirebaseAnalyticsObserver observer =
  FirebaseAnalyticsObserver(analytics: analytics);


  _getDrawerItemWidget(int pos) {

    switch (pos) {
//      case 0:
//        return new LotterySearchFragment(); TODO add later
      case 0:
        return new TaxCalculationPage1();
      case 1:
        return new CorporateTaxCalculationPage();
      case 2:
        return new IncomeTaxCalculationPage();
      case 3:
        return new ProfitTaxCalculationPage();
      case 4:
        return new ThetMaweTaxCalculationPage();
      case 5:
        return new IndividualTaxCalculationPage();
      case 6:
        return new RentalServiceTaxCalculationPage();
//      case 8:
//        return new LotteryNoRegFragment(); TODO add later
//      case 9:
//        return new LotteryRegNoList(); TODO add later
      case 7:
        return new AboutUsFragment();

      default:
        return new Text("Error");
    }

  }

  Future<void> _sendAnalyticsEvent(int index) async {
    await analytics.logEvent(
      name: 'page_navigation',
      parameters: <String, dynamic>{
        'pageName': pageNames[index],
      },
    );
  }


  var pageNames = {
//    0:'LotterySearchFragment', TODO add later
    0:'TaxCalculationPage1',
    1:'CorporateTaxCalculationPage',
    2:'IncomeTaxCalculationPage',
    3:'ProfitTaxCalculationPage',
    4:'ThetMaweTaxCalculationPage',
    5:'IndividualTaxCalculationPage',
    6:'RentalServiceTaxCalculationPage',
//    8:'LotteryNoRegFragment', TODO add later
//    9:'LotteryRegNoList', TODO add later
    7:'AboutUsFragment',
  };

  _onSelectItem(int index) {
    print('selected index $index');
    _sendAnalyticsEvent(index);
    setState(() => _selectedDrawerIndex = index);
    Navigator.of(context).pop(); // close the drawer
  }

  @override
  Widget build(BuildContext context) {
    List<Widget> drawerOptions = [];

    //TODO add later
//    drawerOptions.add(new ListTile(
//      leading: new Icon(Icons.search),
//      title: new Text('Lottery Result'),
//      selected: _selectedDrawerIndex == 0,
//      onTap: () => _onSelectItem(0),
//    ));


    drawerOptions.addAll(<Widget>[
      ListTile(
        leading: Icon(Icons.monetization_on),
        title: new Text('စည်းကြပ်မှုမှလွတ်ကင်းနေသောဝင်ငွေခွန်', style: TextStyle(fontSize: 10),),
        selected: 0 == _selectedDrawerIndex,
        onTap: () => _onSelectItem(0),
      ),
      ListTile(
        leading: Icon(Icons.monetization_on),
        title: new Text('စီးပွားရေးလုပ်ငန်း (Corporate)', style: TextStyle(fontSize: 10),),
        selected: 1 == _selectedDrawerIndex,
        onTap: () => _onSelectItem(1),
      ),
      ListTile(
        leading: Icon(Icons.monetization_on),
        title: new Text('လစာဝင်ငွေခွန်တွက်ချက်ခြင်း', style: TextStyle(fontSize: 11),),
        selected: 2 == _selectedDrawerIndex,
        onTap: () => _onSelectItem(2),
      ),
      ListTile(
        leading: Icon(Icons.monetization_on),
        title: new Text('အခြေခံပစ္စည်းမှမြတ်စွန်းငွေ', style: TextStyle(fontSize: 11),),
        selected: 3 == _selectedDrawerIndex,
        onTap: () => _onSelectItem(3),
      ),
      ListTile(
        leading: Icon(Icons.monetization_on),
        title: new Text('အသက်မွေး ပညာလုပ်ငန်းမှဝင်ငွေခွန်', style: TextStyle(fontSize: 11),),
        selected: 4 == _selectedDrawerIndex,
        onTap: () => _onSelectItem(4),
      ),
      ListTile(
        leading: Icon(Icons.monetization_on),
        title: new Text('စီးပွားရေးလုပ်ငန်းမှဝင်ငွေခွန်(Individual)', style: TextStyle(fontSize: 11),),
        selected: 5 == _selectedDrawerIndex,
        onTap: () => _onSelectItem(5),
      ),
      ListTile(
        leading: Icon(Icons.monetization_on),
        title: new Text('ပစ္စည်းဌားရမ်းခလုပ်ငန်းမှဝင်ငွေခွန်', style: TextStyle(fontSize: 11),),
        selected: 6 == _selectedDrawerIndex,
        onTap: () => _onSelectItem(6),
      )
    ]);

    drawerOptions.add(new ListTile(
      leading: new Icon(Icons.info),
      title: new Text('About Us'),
      selected: _selectedDrawerIndex == 7,
      onTap: () => _onSelectItem(7),
    ));

    return new WillPopScope(
        onWillPop: ()=>SystemChannels.platform.invokeMethod('SystemNavigator.pop'),
        child: new Scaffold(
            appBar: new AppBar(
              title: new Text(widget.drawerItems[_selectedDrawerIndex].title),
              centerTitle: true,
            ),
            drawer: new Drawer(
              child:
                  new Column(
                    children: <Widget>[

                      UserAccountsDrawerHeader(
                        accountName: new Text('${ConstantUtils.APP_NAME} v0.4'),
                        accountEmail: Text(ConstantUtils.APP_DESCRIPTION,style: TextStyle(fontSize: 10),),
                        currentAccountPicture: new CircleAvatar(
                          backgroundImage: AssetImage('images/app_logo.png'),
                        ),
                      ),
                      new Expanded(
                        child: new ListView(children: drawerOptions)
                      )
                    ],
                  )
            ),
            body: _getDrawerItemWidget(_selectedDrawerIndex),
          )
    );
  }

}
