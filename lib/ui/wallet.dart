import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mof/controllers/wallet.dart';
import 'package:mof/ui/new_wallet.dart';

class WalletUI extends GetView<WalletController> {
  static const routeName = '/wallet';

  const WalletUI({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Wallet List'),
      ),
      body: FutureBuilder(
        future: controller.fetchAndSet(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
          return Container(
            margin: const EdgeInsets.only(
              top: 10.0,
              left: 16.0,
              right: 16.0,
            ),
            child: Obx(
              () => Column(
                children: [
                  Expanded(
                    child: Card(
                      color: Colors.white,
                      child: SizedBox(
                        height: 500,
                        child: ListView.builder(
                          itemBuilder: (BuildContext context, int idx) {
                            final wallet = controller.wallets[idx];

                            return ListTile(
                              title: Text(wallet.name),
                              leading: wallet.iconId != null
                                  ? Icon(IconData(wallet.iconId as int))
                                  : null,
                              onTap: () {
                                Get.back(result: wallet);
                              },
                            );
                          },
                          itemCount: controller.wallets.length,
                        ),
                      ),
                    ),
                  ),
                  Container(
                    height: 100.0,
                    margin: const EdgeInsets.only(bottom: 10.0),
                    child: Center(
                      child: CircleAvatar(
                        backgroundColor: Theme.of(context).primaryColor,
                        radius: 24.0,
                        child: IconButton(
                          color: Colors.white,
                          icon: const Icon(Icons.add),
                          onPressed: () async {
                            final success =
                                await Get.toNamed(NewWalletScreen.routeName);
                            if (success != null && (success as bool)) {
                              controller.fetchAndSet();
                            }
                          },
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
