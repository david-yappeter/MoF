import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mof/controllers/controller.dart';
import 'package:mof/router/custom_bottom_navigation.dart';
import 'package:mof/widgets/custom_bottom_navigation_bar.dart';
import 'package:mof/const/bottom_navigation.dart' as constant;

class Home extends GetView<BottomNavigationRouter> {
  static const routeName = '/';

  const Home({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final Controller c = Get.put(Controller());

    return Scaffold(
      extendBody: true,
      appBar: AppBar(
        title: SizedBox(
          width: 200,
          child: ListTile(
            leading: Icon(Icons.account_circle),
            title: Text('asd'),
            subtitle: Text('edgagr'),
            onTap: () {
              print('test');
            },
          ),
        ),
      ),
      body: Navigator(
        key: Get.nestedKey(constant.BOTTOM_NAVIGATOR_ID),
        initialRoute: constant.ROUTE_TRANSACTION,
        onGenerateRoute: controller.onGenerateRoute,
      ),
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.add),
        onPressed: () {
          c.increment();
        },
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      bottomNavigationBar: const CustomBottomNavigationBar(),
    );
  }
}
