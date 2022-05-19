import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mof/controllers/list_tile_wallet.dart';
import 'package:mof/controllers/transaction.dart';
import 'package:mof/controllers/wallet.dart';
import 'package:mof/formatter/currency.dart';
import 'package:mof/models/wallet.dart';
import 'package:mof/ui/wallet.dart';

class ListTileWallet extends GetView<ListTileWalletController> {
  const ListTileWallet({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final WalletController walletController = Get.find();
    return Obx(
      () => FutureBuilder(
        future: walletController.getById(controller.selectedWallet.value),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const SizedBox();
          }

          final data = (snapshot.data as List<dynamic>)[0];
          final selectedWallet = WalletModel.parse(data);

          return ListTile(
            leading: const Icon(Icons.account_circle, size: 40.0),
            trailing: const Icon(Icons.arrow_drop_down, size: 30.0),
            title: Text(selectedWallet.name),
            subtitle:
                Text(CurrencyFormatter.formatCurrency(selectedWallet.amount)),
            onTap: () async {
              final TransactionController transactionController = Get.find();
              final data =
                  await Get.toNamed(WalletUI.routeName) as WalletModel?;
              if (data == null) return;
              controller.setSelectedWallet(data.id);
              transactionController.fetchAndSetAuto();
            },
          );
        },
      ),
    );
  }
}
