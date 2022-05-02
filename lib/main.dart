import 'package:flutter/material.dart';
import 'package:mof/bindings/home.dart';
import 'package:mof/screens/pin.dart';
import 'package:mof/theme/theme_data.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:mof/ui/home.dart';

void main() async {
  await GetStorage.init();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final localStorage = GetStorage();
    final userPin = localStorage.read('user_pin');

    return GetMaterialApp(
      title: 'Minister of Finance',
      theme: customTheme,
      initialRoute: (userPin != null) ? PinScreen.routeName : Home.routeName,
      getPages: [
        GetPage(
          name: PinScreen.routeName,
          page: () => const PinScreen(pin: ''),
        ),
        GetPage(
          name: Home.routeName,
          page: () => const Home(),
          binding: HomeBinding(),
        ),
      ],
      // home: Scaffold(
      //   body: Center(
      //     child: Column(
      //       mainAxisAlignment: MainAxisAlignment.center,
      //       crossAxisAlignment: CrossAxisAlignment.center,
      //       children: [
      //         ElevatedButton(
      //           onPressed: () {
      //             Get.closeCurrentSnackbar();
      //             Get.snackbar(
      //               'Snackbar Title',
      //               'This is the mesasge',
      //               snackPosition: SnackPosition.BOTTOM,
      //             );
      //           },
      //           child: const Text('Show Snackbar'),
      //         ),
      //       ],
      //     ),
      //   ),
      // ),
    );
  }
}
