import 'dart:async';
import 'package:firebase_remote_config/firebase_remote_config.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:myanmar_tax_calculator/main.dart';
import 'package:myanmar_tax_calculator/src/home_page.dart';
import 'package:myanmar_tax_calculator/src/ui/utils/constant_utils.dart';

class SplashScreen extends StatefulWidget {

  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {



  @override
  void initState() {
    super.initState();

    setupFetchRemoteConfig().then((remoteConfig){
      print('fetchData ${remoteConfig.getString('url')}');
      // set the firebase remote config into URL.
      ConstantUtils.BASE_URL = remoteConfig.getString('url');
    });

    Timer(Duration(seconds: 3), () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => HomePage()),
        );
      }
    );
  }

  Future<RemoteConfig> setupFetchRemoteConfig() async {
    final RemoteConfig remoteConfig = await RemoteConfig.instance;
    await remoteConfig.setDefaults(<String, dynamic>{
      'url': ConstantUtils.BASE_URL
    });
    return await fetchData(remoteConfig);
  }

  Future<RemoteConfig> fetchData(RemoteConfig remoteConfig) async {
    try {
      // Using default duration to force fetching from remote server.
      await remoteConfig.fetch(expiration: const Duration(seconds: 0));
      await remoteConfig.activateFetched();
    } on FetchThrottledException catch (exception) {
      // Fetch throttled.
      print(exception);
    } catch (exception) {
      print(
          'Unable to fetch remote config. Cached or default values will be '
              'used');
    }
    return remoteConfig;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Stack(
          fit: StackFit.expand,
          children: <Widget>[
            Container(
              decoration: BoxDecoration(color: Colors.white),
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
                Expanded(
                  flex: 2,
                  child: Container(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        CircleAvatar(
                          backgroundImage: AssetImage("images/ird_mm_logo.png"),
                          radius: 50.0,
                        ),
                        Padding(
                          padding: EdgeInsets.only(top: 10.0),
                        ),
                        Text(
                          'Internal Revenue Department',
                          style: TextStyle(
                              color: MyMainApp.blue.shade900,
                              fontWeight: FontWeight.bold,
                              fontSize: 24.0),
                        )
                      ],
                    ),
                  ),
                ),
                Expanded(
                  flex: 1,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
//                      CircularProgressIndicator(),
//                      SpinKitWave(
//                        color: Colors.white,
//                        ),
                        SpinKitWave(
                          itemBuilder: (_, int index) {
                            return DecoratedBox(
                                decoration: BoxDecoration(
                                color: Colors.blue,
                              ),
                            );
                          },
                        )
                    ],
                  ),
                )
              ],
            )
          ],
        ),
      );
  }
}