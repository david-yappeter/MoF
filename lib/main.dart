import 'package:flutter/material.dart';
import 'package:mof/screens/pin.dart';
import 'package:mof/theme/theme_data.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:mof/screens/index.dart';

Future main() async {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: SharedPreferences.getInstance(),
      builder: (BuildContext ctx, AsyncSnapshot<SharedPreferences> snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }

        return GetMaterialApp(
          title: 'Minister of Finance',
          theme: customTheme,
          initialRoute: Home.routeName,
          getPages: [
            GetPage(name: Home.routeName, page: () => const PinScreen(pin: '')
                // page: () => snapshot.data!.containsKey('setpin')
                //     ? PinScreen(pin: snapshot.data!.getString('setpin') as String)
                //     : const Home(),
                ),
            GetPage(
              name: Other.routeName,
              page: () => Other(),
            ),
          ],
          // home: const MyHomePage(title: 'Flutter Demo Home Page'),
        );
      },
    );
  }
}
