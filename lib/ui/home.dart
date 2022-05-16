import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mof/controllers/transaction.dart';
import 'package:mof/models/wallet.dart';
import 'package:mof/router/custom_bottom_navigation.dart';
import 'package:mof/ui/new_transaction.dart';
import 'package:mof/ui/wallet.dart';
import 'package:mof/widgets/custom_bottom_navigation_bar.dart';
import 'package:mof/const/bottom_navigation.dart' as constant;
import 'package:mof/widgets/custom_tab_bar.dart';

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
        title: SizedBox(
          width: 200,
          child: ListTile(
            leading: const Icon(Icons.account_circle, size: 40.0),
            trailing: const Icon(Icons.arrow_drop_down, size: 30.0),
            title: Text('asd ${controller.currentIdx.value}'),
            subtitle: const Text('edgagr'),
            onTap: () async {
              final data =
                  await Get.toNamed(WalletUI.routeName) as WalletModel?;
              if (data == null) return;
              print(data.id);
              print(data.amount);
              print(data.iconId);
              print(data.name);
            },
          ),
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
