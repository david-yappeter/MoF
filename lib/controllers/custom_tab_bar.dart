import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

class TabBarController extends GetxController
    with GetSingleTickerProviderStateMixin {
  late TabController _controller;
  final List<Tab> _tabs = <Tab>[
    Tab(
      text: DateFormat("MMMM yyyy")
          .format(
            DateTime.now().add(
              const Duration(days: -120),
            ),
          )
          .toUpperCase(),
    ),
    Tab(
      text: DateFormat("MMMM yyyy")
          .format(
            DateTime.now().add(
              const Duration(days: -90),
            ),
          )
          .toUpperCase(),
    ),
    Tab(
      text: DateFormat("MMMM yyyy")
          .format(
            DateTime.now().add(
              const Duration(days: -60),
            ),
          )
          .toUpperCase(),
    ),
    Tab(
      text: DateFormat("MMMM yyyy")
          .format(
            DateTime.now().add(
              const Duration(days: -30),
            ),
          )
          .toUpperCase(),
    ),
    Tab(
      text: DateFormat("MMMM yyyy")
          .format(
            DateTime.now().add(
              const Duration(days: 0),
            ),
          )
          .toUpperCase(),
    ),
    Tab(
      text: DateFormat("MMMM yyyy")
          .format(
            DateTime.now().add(
              const Duration(days: 30),
            ),
          )
          .toUpperCase(),
    ),
    Tab(
      text: DateFormat("MMMM yyyy")
          .format(
            DateTime.now().add(
              const Duration(days: 60),
            ),
          )
          .toUpperCase(),
    ),
    Tab(
      text: DateFormat("MMMM yyyy")
          .format(
            DateTime.now().add(
              const Duration(days: 90),
            ),
          )
          .toUpperCase(),
    ),
    Tab(
      text: DateFormat("MMMM yyyy")
          .format(
            DateTime.now().add(
              const Duration(days: 120),
            ),
          )
          .toUpperCase(),
    ),
  ];

  TabController get controller => _controller;
  List<Tab> get tabs => _tabs;
  List<DateTime> get currentSelectedMonthRange {
    final now = DateTime.now().add(Duration(days: controller.index * 30 - 120));
    final start = DateTime(now.year, now.month, 1);
    final end = DateTime(now.year, now.month + 1, 1);
    return [start, end];
  }

  @override
  void onInit() {
    _controller =
        TabController(length: _tabs.length, vsync: this, initialIndex: 4);
    super.onInit();
  }

  @override
  void onClose() {
    _controller.dispose();
    super.onClose();
  }
}
