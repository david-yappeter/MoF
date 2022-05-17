import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:mof/const/storage.dart';
import 'package:mof/controllers/wallet.dart';
import 'package:mof/formatter/currency.dart';
import 'package:mof/models/wallet.dart';
import 'package:mof/ui/wallet.dart';

class ListTileWallet extends GetView<WalletController> {
  const ListTileWallet({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final selectedWalletId = GetStorage().read(SELECTED_WALLET);

    return FutureBuilder(
      future: controller.fetchAndSet(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }

        final selectedWallet = controller.getById(selectedWalletId);

        return ListTile(
          leading: const Icon(Icons.account_circle, size: 40.0),
          trailing: const Icon(Icons.arrow_drop_down, size: 30.0),
          title: Text(selectedWallet.name),
          subtitle:
              Text(CurrencyFormatter.formatCurrency(selectedWallet.amount)),
          onTap: () async {
            final data = await Get.toNamed(WalletUI.routeName) as WalletModel?;
            if (data == null) return;
          },
        );
      },
    );
  }
}
