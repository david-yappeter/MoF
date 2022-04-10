import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:mof/controllers/orang_controller.dart';
// import 'package:mof/models/orang.dart';

// ignore: must_be_immutable
class Home extends StatelessWidget {
  // var orang = Orang(nama: "jone doe", umur: 25).obs;
  var orangC = Get.put(OrangController());

  var count = 0.obs;
  void add() {
    count++;
  }

  Home({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Center(
        child: Obx(
          () => Text(
            "angka ${orangC.orang.value.nama} ${orangC.orang.value.umur}",
            style: const TextStyle(
              fontSize: 35,
            ),
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.add),
        onPressed: () {
          orangC.changeUpperCase();
          // orang.update((val) {
          //   val?.nama = val.nama.toString().toUpperCase();
          //   // orang.value.nama = orang.value.nama.toString().toUpperCase();
          // });
        },
      ),
    );
  }
}
