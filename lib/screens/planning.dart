import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mof/ui/new_category.dart';
import 'package:mof/ui/new_wallet.dart';

class PlanningScreen extends StatelessWidget {
  const PlanningScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Card(
        child: Column(
          children: [
            ListTile(
              title: const Text('New Category'),
              onTap: () {
                Get.toNamed(NewCategoryScreen.routeName);
              },
            ),
            ListTile(
              title: const Text('New Wallet'),
              onTap: () {
                Get.toNamed(NewWalletScreen.routeName);
              },
            ),
          ],
        ),
      ),
    );
  }
}
