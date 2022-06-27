import 'dart:async';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mof/screens/pin.dart';
import 'package:mof/ui/home.dart';
import 'package:mof/ui/introduction.dart';

class SplashScreen extends StatefulWidget {
  static const routeName = '/splash-screen';
  final bool showHome;
  final dynamic userPin;

  const SplashScreen({Key? key, required this.showHome, required this.userPin})
      : super(key: key);

  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  startTime() async {
    var _duration = const Duration(seconds: 4);
    return Timer(_duration, navigationPage);
  }

  void navigationPage() {
    Get.offNamed(!widget.showHome
        ? IntroductionUI.routeName
        : (widget.userPin != null)
            ? PinScreen.routeName
            : Home.routeName);
  }

  @override
  void initState() {
    super.initState();
    startTime();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Container(
            padding:
                const EdgeInsets.symmetric(horizontal: 4.0, vertical: 80.0),
            height: MediaQuery.of(context).size.height,
            width: double.infinity,
            child: Center(
              child: SizedBox(
                width: 200,
                height: 200,
                child: Image.asset(
                  'assets/images/logo_primary.png',
                  fit: BoxFit.cover,
                ),
              ),
            ),
          ),
          Container(
            height: MediaQuery.of(context).size.height,
            color: Colors.blue.withOpacity(0.2),
          ),
          Positioned(
            top: MediaQuery.of(context).size.height * 0.9,
            left: MediaQuery.of(context).size.width * 0.15,
            child: Row(
              children: <Widget>[
                Image.asset(
                  'assets/icons/mof_logo_primary.png',
                  width: 50,
                  height: 50,
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    const Text(
                      "Minister of Finance",
                      style: TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                        fontSize: 20,
                      ),
                    ),
                    Text(
                      "Version 1.0.1",
                      style: TextStyle(
                        color: Colors.grey[700],
                        fontWeight: FontWeight.bold,
                        fontSize: 15,
                        wordSpacing: 2,
                        letterSpacing: 4,
                      ),
                    )
                  ],
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}
