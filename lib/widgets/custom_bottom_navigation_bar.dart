import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mof/router/custom_bottom_navigation.dart';

class CustomBottomNavigationBar extends GetView<BottomNavigationRouter> {
  const CustomBottomNavigationBar({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => BottomAppBar(
        elevation: 8,
        shape: const CircularNotchedRectangle(),
        child: BottomNavigationBar(
          type: BottomNavigationBarType.fixed,
          items: const [
            BottomNavigationBarItem(
              icon: Icon(
                Icons.account_balance_wallet,
              ),
              label: 'Transaction',
            ),
            BottomNavigationBarItem(
              icon: Icon(
                Icons.pie_chart,
              ),
              label: 'Report',
            ),
            BottomNavigationBarItem(
              icon: Icon(
                Icons.home,
                color: Colors.transparent,
              ),
              label: "",
            ),
            BottomNavigationBarItem(
              icon: Icon(
                Icons.fiber_new_outlined,
              ),
              label: 'New Item',
            ),
            BottomNavigationBarItem(
              icon: Icon(
                Icons.settings,
              ),
              label: 'Settings',
            ),
          ],
          currentIndex: controller.currentIdx.value,
          onTap: controller.changePage,
        ),
      ),
    );
  }
}
