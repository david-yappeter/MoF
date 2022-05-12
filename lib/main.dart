import 'package:flutter/material.dart';
import 'package:mof/bindings/category.dart';
import 'package:mof/bindings/home.dart';
import 'package:mof/bindings/new_transaction.dart';
import 'package:mof/bindings/wallet.dart';
import 'package:mof/database/helper.dart';
import 'package:mof/screens/pin.dart';
import 'package:mof/theme/theme_data.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:mof/ui/category_list.dart';
import 'package:mof/ui/home.dart';
import 'package:mof/ui/new_transaction.dart';
import 'package:mof/ui/wallet.dart';

void main() async {
  print("pass hererere");
  await GetStorage.init();
  await DBHelper.deleteDB();
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
        GetPage(
          name: NewTransactionScreen.routeName,
          page: () => const NewTransactionScreen(),
          binding: NewTransactionBinding(),
        ),
        GetPage(
          name: CategoryList.routeName,
          page: () => const CategoryList(),
          binding: CategoryBinding(),
        ),
        GetPage(
          name: WalletUI.routeName,
          page: () => const WalletUI(),
          binding: WalletBinding(),
        ),
      ],
    );
  }
}
