import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:mof/bindings/category.dart';
import 'package:mof/bindings/home.dart';
import 'package:mof/bindings/introduction.dart';
import 'package:mof/bindings/new_category.dart';
import 'package:mof/bindings/new_transaction.dart';
import 'package:mof/bindings/new_wallet.dart';
import 'package:mof/bindings/set_pin.dart';
import 'package:mof/bindings/wallet.dart';
import 'package:mof/const/storage.dart';
import 'package:mof/controllers/category.dart';
import 'package:mof/controllers/list_tile_wallet.dart';
import 'package:mof/controllers/wallet.dart';
import 'package:mof/firebase_options.dart';
import 'package:mof/notification/NotificationService.dart';
import 'package:mof/permission/helper.dart';
import 'package:mof/provider/myProvider.dart';
import 'package:mof/screens/pin.dart';
import 'package:mof/screens/splash_screen.dart';
import 'package:mof/theme/theme_data.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:mof/ui/category_list.dart';
import 'package:mof/ui/home.dart';
import 'package:mof/ui/introduction.dart';
import 'package:mof/ui/new_category.dart';
import 'package:mof/ui/new_transaction.dart';
import 'package:mof/ui/new_wallet.dart';
import 'package:mof/ui/set_pin.dart';
import 'package:mof/ui/wallet.dart';
import 'package:provider/provider.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:firebase_messaging/firebase_messaging.dart';

Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  // If you're going to use other Firebase services in the background, such as Firestore,
  // make sure you call `initializeApp` before using other Firebase services.
  await Firebase.initializeApp(
    name: "mof",
    options: DefaultFirebaseOptions.currentPlatform,
  );

  print("Handling a background message: ${message.messageId}");
}

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await MobileAds.instance.initialize();
  await Firebase.initializeApp(
    name: "mof",
    options: DefaultFirebaseOptions.currentPlatform,
  );
  await GetStorage.init();
  await mustGetStoragePermission();

  NotificationService.initialize();

  FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);
  FirebaseMessaging messaging = FirebaseMessaging.instance;
  NotificationSettings settings = await messaging.requestPermission(
    alert: true,
    announcement: false,
    badge: true,
    carPlay: false,
    criticalAlert: false,
    provisional: false,
    sound: true,
  );
  print('User granted permission:  ${settings.authorizationStatus}');
  print('asgasgasgas  ${await messaging.getToken()}');

  FirebaseMessaging.onMessage.listen(
    (RemoteMessage message) {
      if (message.notification != null) {
        NotificationService.showLocalNotification(
          title: message.notification!.title!,
          body: message.notification!.body!,
        );
      }
    },
  );

  // await DBHelper.deleteDB();
  // GetStorage().remove(SHOW_HOME);
  // GetStorage().write(USER_PIN, '123456');
  final bool showHome = GetStorage().read(SHOW_HOME) ?? false;
  final dynamic userPin = GetStorage().read(USER_PIN);

  Get.put(WalletController());
  Get.put(CategoryController());
  Get.put(ListTileWalletController());

  runApp(
    MultiProvider(
      providers: [ChangeNotifierProvider(create: (_) => myProvider())],
      child: MyApp(
        showHome: showHome,
        userPin: userPin,
      ),
    ),
  );
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
    final prov = Provider.of<myProvider>(context);
    return GetMaterialApp(
      title: 'Minister of Finance',
      theme: prov.status == true ? prov.dark : customTheme,
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
          name: NewWalletScreen.routeName,
          page: () => const NewWalletScreen(),
          binding: NewWalletBinding(),
        ),
        GetPage(
          name: NewCategoryScreen.routeName,
          page: () => const NewCategoryScreen(),
          binding: NewCategoryBinding(),
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
