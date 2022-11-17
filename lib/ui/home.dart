import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mof/const/storage.dart';
import 'package:mof/controllers/filter.dart';
import 'package:mof/controllers/transaction.dart';
import 'package:mof/firebase/myAnalytics.dart';
import 'package:mof/models/category.dart';
import 'package:mof/router/custom_bottom_navigation.dart';
import 'package:mof/ui/category_list.dart';
import 'package:mof/ui/new_transaction.dart';
import 'package:mof/widgets/custom_bottom_navigation_bar.dart';
import 'package:mof/const/bottom_navigation.dart' as constant;
import 'package:mof/widgets/custom_tab_bar.dart';
import 'package:mof/widgets/list_tile_wallet.dart';

class Home extends GetView<BottomNavigationRouter> {
  static const routeName = '/';

  const Home({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final FilterController filterController = Get.find<FilterController>();
    final TransactionController transactionController =
        Get.find<TransactionController>();
    MyFirebaseAnalytics firebaseanalytics = MyFirebaseAnalytics();
    return Scaffold(
      extendBody: true,
      appBar: AppBar(
        actions: [
          Obx(
            () => IconButton(
              color: filterController.categoryId.value != 0
                  ? Colors.red
                  : Colors.black,
              onPressed: () async {
                final result = await Get.toNamed(CategoryList.routeName);
                if (result == null) {
                  filterController.reset();
                  return;
                }
                final categoryModel = (result as CategoryModel);
                filterController.set(categoryModel.id);
              },
              icon: const Icon(Icons.filter_list_sharp),
            ),
          ),
        ],
        title: const SizedBox(
          width: 230,
          child: ListTileWallet(),
        ),
        bottom: CustomTabBar(),
      ),
      body: Navigator(
        key: Get.nestedKey(constant.BOTTOM_NAVIGATOR_ID),
        initialRoute: constant.ROUTE_TRANSACTION,
        onGenerateRoute: controller.onGenerateRoute,
      ),
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.add),
        onPressed: () async {
          await Get.toNamed(NewTransactionScreen.routeName);
          transactionController.fetchAndSetAuto();
        },
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      bottomNavigationBar: const CustomBottomNavigationBar(),
    );
  }
}
