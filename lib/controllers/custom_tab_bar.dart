import 'package:flutter/material.dart';
import 'package:get/get.dart';

class TabBarController extends GetxController
    with GetSingleTickerProviderStateMixin {
  late TabController _controller;
  final List<Tab> _tabs = const <Tab>[
    Tab(text: 'Tab 1'),
    Tab(text: 'Tab 2'),
    Tab(text: 'Tab 3'),
    Tab(text: 'Tab 4'),
    Tab(text: 'Tab 5'),
    Tab(text: 'Tab 6'),
    Tab(text: 'Tab 7'),
    Tab(text: 'Tab 8'),
    Tab(text: 'Tab 9'),
    Tab(text: 'Tab 10'),
  ];

  TabController get controller => _controller;
  List<Tab> get tabs => _tabs;

  @override
  void onInit() {
    _controller = TabController(length: _tabs.length, vsync: this);
    super.onInit();
  }

  @override
  void onClose() {
    _controller.dispose();
    super.onClose();
  }
}
