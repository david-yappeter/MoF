import 'package:get/get.dart';

import 'package:mof/models/orang.dart';

class OrangController extends GetxController {
  var orang = Orang(nama: "Agusss", umur: 50).obs;

  void changeUpperCase() {
    orang.update((_) {
      orang.value.nama = orang.value.nama.toString().toUpperCase();
    });
  }
}
