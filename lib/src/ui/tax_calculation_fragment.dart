// Copyright 2015 The Chromium Authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

import 'package:flutter/material.dart';

enum TabsDemoStyle {
  iconsAndText,
  iconsOnly,
  textOnly
}

class _Page {
  const _Page({ this.icon, this.text });
  final IconData icon;
  final String text;
}

const List<_Page> _allPages = <_Page>[
  _Page(text: 'စည်းကြပ်မှုမှလွတ်ကင်းနေသောဝင်ငွေခွန်'),
  _Page(text: 'စီးပွားရေးလုပ်ငန်းမှဝင်ငွေခွန် (Corporate)'),
  _Page(text: 'လစာဝင်ငွေခွန်'),
  _Page(text: 'အခြေပစ္စည်းမှမြတ်စွန်းငွေခွန်'),
  _Page(text: 'အသက်မွေးဝမ်းကျောင်းပညာလုပ်ငန်းမှဝင်ငွေခွန်'),
  _Page(text: 'စီးပွားရေးလုပ်ငန်းမှဝင်ငွေခွန် (Individual)'),
  _Page(text: 'ပစ္စည်းဌားရမ်းခလုပ်ငန်းမှဝင်ငွေခွန်'),
];

class TaxCalculationFragment extends StatefulWidget {
  static const String routeName = '/material/scrollable-tabs';

  @override
  ScrollableTabsDemoState createState() => ScrollableTabsDemoState();

}

class ScrollableTabsDemoState extends State<TaxCalculationFragment> with SingleTickerProviderStateMixin {
  TabController _controller;
  TabsDemoStyle _demoStyle = TabsDemoStyle.iconsAndText;
  bool _customIndicator = false;

  @override
  void initState() {
    super.initState();
    _controller = TabController(vsync: this, length: _allPages.length);
  }



  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void changeDemoStyle(TabsDemoStyle style) {
    setState(() {
      _demoStyle = style;
    });
  }

  Decoration getIndicator() {
    if (!_customIndicator)
      return const UnderlineTabIndicator();

    switch(_demoStyle) {
      case TabsDemoStyle.iconsAndText:
        return ShapeDecoration(
          shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(4.0)),
            side: BorderSide(
              color: Colors.white24,
              width: 2.0,
            ),
          ) + const RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(4.0)),
            side: BorderSide(
              color: Colors.transparent,
              width: 4.0,
            ),
          ),
        );

      case TabsDemoStyle.iconsOnly:
        return ShapeDecoration(
          shape: const CircleBorder(
            side: BorderSide(
              color: Colors.white24,
              width: 4.0,
            ),
          ) + const CircleBorder(
            side: BorderSide(
              color: Colors.transparent,
              width: 4.0,
            ),
          ),
        );

      case TabsDemoStyle.textOnly:
        return ShapeDecoration(
          shape: const StadiumBorder(
            side: BorderSide(
              color: Colors.white24,
              width: 2.0,
            ),
          ) + const StadiumBorder(
            side: BorderSide(
              color: Colors.transparent,
              width: 4.0,
            ),
          ),
        );
    }
    return null;
  }

  // appbar
  Widget createAppBar() {
    return AppBar(
        title: const Text('Scrollable tabs'),
    actions: <Widget>[
    IconButton(
    icon: const Icon(Icons.sentiment_very_satisfied),
    onPressed: () {
    setState(() {
    _customIndicator = !_customIndicator;
    });
    },
    ),
    PopupMenuButton<TabsDemoStyle>(
    onSelected: changeDemoStyle,
    itemBuilder: (BuildContext context) => <PopupMenuItem<TabsDemoStyle>>[
    const PopupMenuItem<TabsDemoStyle>(
    value: TabsDemoStyle.iconsAndText,
    child: Text('Icons and text'),
    ),
    const PopupMenuItem<TabsDemoStyle>(
    value: TabsDemoStyle.iconsOnly,
    child: Text('Icons only'),
    ),
    const PopupMenuItem<TabsDemoStyle>(
    value: TabsDemoStyle.textOnly,
    child: Text('Text only'),
    ),
    ],
    ),
    ],
    );
  }

  // bottom.
  Widget createTabBar() {
    return TabBar(
      controller: _controller,
      isScrollable: true,
      indicator: getIndicator(),
      tabs: _allPages.map<Tab>((_Page page) {
        assert(_demoStyle != null);
        switch (_demoStyle) {
          case TabsDemoStyle.iconsAndText:
            return Tab(text: page.text, icon: Icon(page.icon));
          case TabsDemoStyle.iconsOnly:
            return Tab(icon: Icon(page.icon));
          case TabsDemoStyle.textOnly:
            return Tab(text: page.text);
        }
        return null;
      }).toList(),
    );
  }

  @override
  Widget build(BuildContext context) {
    Color iconColor = Theme.of(context).accentColor;
    return TabBarView(
        controller: _controller,
        children: _allPages.map<Widget>((_Page page) {
          return SafeArea(
            top: false,
            bottom: false,
            child: Container(
              key: ObjectKey(page.icon),
              padding: const EdgeInsets.all(12.0),
              child: Card(
                child: Center(
                  child: Icon(
                    page.icon,
                    color: iconColor,
                    size: 128.0,
                    semanticLabel: 'Placeholder for ${page.text} tab',
                  ),
                ),
              ),
            ),
          );
        }).toList(),
    );
  }
}