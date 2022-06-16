import 'package:flutter/material.dart';
import 'package:mof/bindings/category.dart';
import 'package:mof/bindings/home.dart';
import 'package:mof/bindings/introduction.dart';
import 'package:mof/bindings/new_transaction.dart';
import 'package:mof/bindings/set_pin.dart';
import 'package:mof/bindings/wallet.dart';
import 'package:mof/const/storage.dart';
import 'package:mof/controllers/category.dart';
import 'package:mof/controllers/list_tile_wallet.dart';
import 'package:mof/controllers/wallet.dart';
import 'package:mof/screens/pin.dart';
import 'package:mof/screens/splash_screen.dart';
import 'package:mof/theme/theme_data.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:mof/ui/category_list.dart';
import 'package:mof/ui/home.dart';
import 'package:mof/ui/introduction.dart';
import 'package:mof/ui/new_transaction.dart';
import 'package:mof/ui/set_pin.dart';
import 'package:mof/ui/wallet.dart';

void main() async {
  await GetStorage.init();
  // await DBHelper.deleteDB();
  // GetStorage().remove(SHOW_HOME);
  // GetStorage().write(USER_PIN, '123456');
  final bool showHome = GetStorage().read(SHOW_HOME) ?? false;
  final dynamic userPin = GetStorage().read(USER_PIN);

  Get.put(WalletController());
  Get.put(CategoryController());
  Get.put(ListTileWalletController());

  runApp(MyApp(
    showHome: showHome,
    userPin: userPin,
  ));
}

class MyApp extends StatelessWidget {
  final bool showHome;
  final dynamic userPin;

  const MyApp({
    Key? key,
    required this.showHome,
    required this.userPin,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Minister of Finance',
      theme: customTheme,
      initialRoute: SplashScreen.routeName,
      // initialRoute: !showHome
      //     ? IntroductionUI.routeName
      //     : (userPin != null)
      //         ? PinScreen.routeName
      //         : Home.routeName,
      getPages: [
        GetPage(
          name: SplashScreen.routeName,
          page: () => SplashScreen(
            showHome: showHome,
            userPin: userPin,
          ),
        ),
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
        GetPage(
          name: IntroductionUI.routeName,
          page: () => const IntroductionUI(),
          binding: IntroductionBinding(),
        ),
        GetPage(
          name: SetPinScreen.routeName,
          page: () => const SetPinScreen(),
          binding: SetPinBinding(),
        ),
      ],
    );
  }
}
