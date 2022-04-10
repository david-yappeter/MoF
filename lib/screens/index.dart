import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mof/controllers/controller.dart';

class Home extends StatelessWidget {
  static const routeName = '/';

  const Home({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final Controller c = Get.put(Controller());

    return Scaffold(
      appBar: AppBar(title: Obx(() => Text("Clicks: ${c.count}"))),
      body: Center(
        child: ElevatedButton(
          child: const Text('Go to Other'),
          onPressed: () => Get.toNamed(Other.routeName),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.add),
        onPressed: () {
          c.increment();
        },
      ),
    );
  }
}

class Other extends StatelessWidget {
  static const routeName = '/others';
  final Controller c = Get.find<Controller>();

  Other({Key? key}) : super(key: key);

  @override
  Widget build(context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Others'),
      ),
      body: Center(
        child: Obx(() => Text("${c.count}")),
      ),
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.add),
        onPressed: () {
          c.increment();
        },
      ),
    );
  }
}
