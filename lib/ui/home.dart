import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mof/controllers/transaction.dart';
import 'package:mof/router/custom_bottom_navigation.dart';
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
    final TransactionController transactionController =
        Get.find<TransactionController>();
    return Scaffold(
      extendBody: true,
      appBar: AppBar(
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
