import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:mof/controllers/transaction.dart';
import 'package:mof/formatter/currency.dart';
import 'package:mof/models/transaction.dart';
import 'package:mof/theme/colors.dart';

class TransactionScreen extends GetView<TransactionController> {
  const TransactionScreen({Key? key}) : super(key: key);

  Widget buildGroupedCard(
      {required DateTime date,
      required List<TransactionModel> transactionModelList}) {
    return Card(
      color: Colors.white,
      child: Column(
        children: [
          ListTile(
            dense: true,
            leading: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  date.day.toString().padLeft(2, '0'),
                  style: const TextStyle(
                    fontSize: 40.0,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ],
            ),
            title: Text(
              DateFormat('EEEE').format(date),
              style: const TextStyle(fontWeight: FontWeight.w500),
            ),
            subtitle: Text(DateFormat("MMMM yyyy").format(date)),
            trailing: Text(
              CurrencyFormatter.formatCurrency(
                transactionModelList.fold<double>(
                  0,
                  (previousValue, e) =>
                      previousValue +
                      (e.categoryIsIncome ? e.amount : -1 * e.amount),
                ),
              ),
              style: const TextStyle(
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
          const Divider(height: 10.0, thickness: 2, color: Colors.black),
          for (var i = 0; i < transactionModelList.length; i++)
            ListTile(
              title: Text(
                transactionModelList[i].categoryName,
                style: const TextStyle(
                    fontWeight: FontWeight.bold, fontSize: 14.0),
              ),
              leading: transactionModelList[i].iconId != null
                  ? Icon(IconData(transactionModelList[i].iconId as int))
                  : null,
              trailing: Text(
                CurrencyFormatter.formatCurrency(
                    transactionModelList[i].amount),
                style: TextStyle(
                  color: transactionModelList[i].categoryIsIncome
                      ? Colors.green
                      : Colors.red,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: controller.fetchAndSetAuto(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }
        return Obx(
          () => Container(
            color: CustomColor.background,
            child: Column(
              children: [
                SizedBox(
                  width: double.infinity,
                  child: Card(
                    child: Container(
                      margin: const EdgeInsets.symmetric(
                          horizontal: 20.0, vertical: 16.0),
                      width: double.infinity,
                      height: 90.0,
                      child: Column(
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              const Text(
                                'Inflow',
                                style: TextStyle(
                                  fontSize: 18.0,
                                  fontWeight: FontWeight.w500,
                                  color: CustomColor.textGray,
                                ),
                              ),
                              Text(
                                CurrencyFormatter.formatCurrency(
                                    controller.totalInflow.value),
                                style: const TextStyle(
                                  color: CustomColor.blue,
                                  fontWeight: FontWeight.w500,
                                  fontSize: 16.0,
                                ),
                              ),
                            ],
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              const Text(
                                'Outflow',
                                style: TextStyle(
                                  fontSize: 18.0,
                                  fontWeight: FontWeight.w500,
                                  color: CustomColor.textGray,
                                ),
                              ),
                              Text(
                                CurrencyFormatter.formatCurrency(
                                    controller.totalOutflow.value),
                                style: const TextStyle(
                                  color: CustomColor.red,
                                  fontWeight: FontWeight.w500,
                                  fontSize: 16.0,
                                ),
                              ),
                            ],
                          ),
                          const Divider(
                            thickness: 2.0,
                            color: Colors.black,
                            indent: 150,
                          ),
                          Align(
                            alignment: Alignment.centerRight,
                            child: Text(
                              CurrencyFormatter.formatCurrency(
                                  controller.totalInflow.value -
                                      controller.totalOutflow.value),
                              style: const TextStyle(
                                color: Colors.black,
                                fontWeight: FontWeight.w500,
                                fontSize: 16.0,
                              ),
                              textAlign: TextAlign.right,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                Expanded(
                    child: ListView.builder(
                  itemCount: controller.groupedTransaction.length,
                  itemBuilder: (context, index) {
                    final DateTime date = DateTime.parse(
                        controller.groupedTransaction.keys.toList()[index]);
                    final List<TransactionModel> transactionList =
                        controller.groupedTransaction.values.toList()[index];

                    return buildGroupedCard(
                      date: date,
                      transactionModelList: transactionList,
                    );
                  },
                )),
              ],
            ),
          ),
        );
      },
    );
  }
}
