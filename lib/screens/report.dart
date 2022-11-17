import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mof/controllers/transaction.dart';
import 'package:mof/formatter/currency.dart';
import 'package:mof/theme/colors.dart';
import 'package:pie_chart/pie_chart.dart';

class ReportScreen extends GetView<TransactionController> {
  const ReportScreen({Key? key}) : super(key: key);

  Widget buildChart({required Map<String, double> data, required String text}) {
    if (data.isEmpty) return Container();
    return SizedBox(
      width: 50,
      height: 200,
      child: PieChart(
        dataMap: data,
        chartType: ChartType.ring,
        ringStrokeWidth: 40.0,
        chartValuesOptions: const ChartValuesOptions(
          showChartValues: false,
        ),
        centerText: text,
        colorList: const [
          Color(0xFF345C5C),
          Colors.black45,
          Color(0XFF46D5AD),
          Colors.black54,
          CustomColor.blue,
          Colors.black87,
          Color(0XFF30A28A),
          CustomColor.primary,
          Color(0XFF1A2728),
          CustomColor.red,
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Card(
          child: Container(
            width: double.infinity,
            padding: const EdgeInsets.only(
              top: 10.0,
              bottom: 10.0,
              left: 16.0,
              right: 32.0,
            ),
            child: Column(
              children: [
                const Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    'Balance',
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.w500),
                  ),
                ),
                const SizedBox(height: 10),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Center(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text('Opening Balance',
                              style: TextStyle(fontSize: 16.0)),
                          Obx(
                            () => Text(
                              CurrencyFormatter.formatCurrency(
                                controller.openingBalance.value,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Center(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text('Ending Balance',
                              style: TextStyle(fontSize: 16.0)),
                          Obx(
                            () => Text(
                              CurrencyFormatter.formatCurrency(
                                controller.endingBalance.value,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
        Expanded(
          child: Obx(() => ListView(
                padding: const EdgeInsets.symmetric(horizontal: 70.0),
                children: [
                  buildChart(
                    data: controller.groupedTransactionByCategory['income']
                        as Map<String, double>,
                    text: "Income",
                  ),
                  buildChart(
                    data: controller.groupedTransactionByCategory['expense']
                        as Map<String, double>,
                    text: "Expense",
                  ),
                ],
              )),
        ),
      ],
    );
  }
}
