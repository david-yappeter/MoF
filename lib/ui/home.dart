import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mof/controllers/controller.dart';
import 'package:mof/router/custom_bottom_navigation.dart';
import 'package:mof/widgets/custom_bottom_navigation_bar.dart';
import 'package:mof/const/bottom_navigation.dart' as constant;
import 'package:mof/router/custom_tab_bar.dart';

class Home extends GetView<BottomNavigationRouter> {
  static const routeName = '/';

  const Home({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final Controller c = Get.put(Controller());
    final CustomTabBar _tabs = Get.put(CustomTabBar());

    return Scaffold(
      extendBody: true,
      appBar: AppBar(
        title: SizedBox(
          width: 200,
          child: ListTile(
            leading: Icon(Icons.account_circle),
            title: Text('asd ${controller.currentIdx.value}'),
            subtitle: Text('edgagr'),
            onTap: () {
              print('test');
            },
          ),
        ),
        bottom: (controller.currentIdx.value < 2)
            ? TabBar(
                isScrollable: true,
                controller: _tabs.controller,
                tabs: _tabs.myTabs,
              )
            : null,
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
