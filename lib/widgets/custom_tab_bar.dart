import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mof/controllers/custom_tab_bar.dart';
import 'package:mof/controllers/transaction.dart';
import 'package:mof/router/custom_bottom_navigation.dart';

class CustomTabBar extends GetView<TabBarController> with PreferredSizeWidget {
  CustomTabBar({Key? key}) : super(key: key);
  final BottomNavigationRouter router = Get.find<BottomNavigationRouter>();
  final TransactionController transactionController = Get.find();

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => (router.currentIdx < 2)
          ? TabBar(
              isScrollable: true,
              controller: controller.controller,
              tabs: controller.tabs,
              onTap: (idx) {
                transactionController.fetchAndSetAuto();
              },
            )
          : Container(),
    );
  }

  @override
  Size get preferredSize => (router.currentIdx < 2)
      ? const Size.fromHeight(50.0)
      : const Size.fromHeight(0.0);
}
