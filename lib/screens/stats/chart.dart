import 'dart:math';
import 'package:flutter/material.dart';
import 'package:pie_chart/pie_chart.dart';
import 'package:expense_repository/expense_repository.dart'; // Ensure this is the correct path

class MyChart extends StatelessWidget {
  final List<Expense> expenses;
  const MyChart(this.expenses, {super.key});

  @override
  Widget build(BuildContext context) {
    // Dynamic data calculation for pie chart
    Map<String, double> dataMap = {};
    for (var expense in expenses) {
      if (!dataMap.containsKey(expense.category)) {
        dataMap[expense.category.name] = 0;
      }
      dataMap[expense.category.name] = dataMap[expense.category.name]! + expense.amount;
    }

    // Dynamic color list generation
    List<Color> colorList = dataMap.keys.map((_) => Colors.primaries[Random().nextInt(Colors.primaries.length)]).toList();

    return Scaffold(
      appBar: AppBar(
        title: Text('Account Breakdown'),
      ),
      body: Center(
        child: PieChart(
          dataMap: dataMap,
          animationDuration: Duration(milliseconds: 800),
          chartLegendSpacing: 32,
          chartRadius: MediaQuery.of(context).size.width / 2,
          colorList: colorList,
          initialAngleInDegree: 0,
          chartType: ChartType.ring,
          ringStrokeWidth: 32,
          centerText: "Account",
          legendOptions: LegendOptions(
            showLegendsInRow: false,
            legendPosition: LegendPosition.right,
            showLegends: true,
            legendShape: BoxShape.circle,
            legendTextStyle: TextStyle(
              fontWeight: FontWeight.bold,
            ),
          ),
          chartValuesOptions: ChartValuesOptions(
            showChartValueBackground: true,
            showChartValues: true,
            showChartValuesInPercentage: true,
            showChartValuesOutside: false,
            decimalPlaces: 1,
          ),
        ),
      ),
    );
  }
}


