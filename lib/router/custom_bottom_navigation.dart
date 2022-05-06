import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mof/const/bottom_navigation.dart' as constant;
import 'package:mof/screens/planning.dart';
import 'package:mof/screens/report.dart';
import 'package:mof/screens/setting.dart';
import 'package:mof/screens/transaction.dart';

class BottomNavigationRouter extends GetxController {
  static BottomNavigationRouter get to => Get.find();

  var currentIdx = 0.obs;

  final pages = <String>[
    constant.ROUTE_TRANSACTION,
    constant.ROUTE_REPORT,
    '',
    constant.ROUTE_PLANNING,
    constant.ROUTE_SETTINGS,
  ];

  void changePage(int index) {
    if (index == 2) return;
    currentIdx.value = index;
    Get.toNamed(
      pages[index],
      id: constant.BOTTOM_NAVIGATOR_ID,
    );
  }

  Route? onGenerateRoute(RouteSettings settings) {
    if (settings.name == constant.ROUTE_TRANSACTION) {
      return GetPageRoute(
        settings: settings,
        page: () => const TransactionScreen(),
        transition: Transition.fade,
      );
    }

    if (settings.name == constant.ROUTE_REPORT) {
      return GetPageRoute(
        settings: settings,
        page: () => const ReportScreen(),
        transition: Transition.fade,
      );
    }

    if (settings.name == constant.ROUTE_PLANNING) {
      return GetPageRoute(
        settings: settings,
        page: () => const PlanningScreen(),
        transition: Transition.fade,
      );
    }

    if (settings.name == constant.ROUTE_SETTINGS) {
      return GetPageRoute(
        settings: settings,
        page: () => const SettingScreen(),
        transition: Transition.fade,
      );
    }
  }
}
