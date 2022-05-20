import 'package:flutter/material.dart';
import 'package:pie_chart/pie_chart.dart';

class ReportScreen extends StatelessWidget {
  const ReportScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: SizedBox(
        width: 250,
        height: 500,
        child: PieChart(
          dataMap: const {
            "Flutter": 5,
            "React": 3,
            "Xamarin": 2,
            "Ionic": 2,
          },
          chartType: ChartType.ring,
          ringStrokeWidth: 40.0,
          chartValuesOptions: const ChartValuesOptions(
            showChartValues: false,
          ),
        ),
      ),
    );
  }
}
