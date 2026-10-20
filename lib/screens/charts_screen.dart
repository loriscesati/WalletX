import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

class ChartsScreen extends StatefulWidget {
  const ChartsScreen({super.key});

  @override
  State<ChartsScreen> createState() => _ChartsScreenState();
}

class _ChartsScreenState extends State<ChartsScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Statistiche Finanziarie'),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            // Grafico spese mensili
            Container(
              height: 300,
              margin: const EdgeInsets.all(16),
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.purple[50],
                borderRadius: BorderRadius.circular(12),
              ),
              child: SfCartesianChart(
                primaryXAxis: CategoryAxis(),
                series: <ChartSeries>[
                  ColumnSeries<ExpenseData, String>(
                    dataSource: [
                      ExpenseData('Gennaio', 800),
                      ExpenseData('Febbraio', 950),
                      ExpenseData('Marzo', 720),
                      ExpenseData('Aprile', 1050),
                      ExpenseData('Maggio', 680),
                      ExpenseData('Giugno', 920),
                    ],
                    xMapper: (ExpenseData data) => data.month,
                    yMapper: (ExpenseData data) => data.amount,
                  ),
                ],
              ),
            ),
            
            // Grafico confronto tag
            Container(
              height: 300,
              margin: const EdgeInsets.all(16),
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.purple[50],
                borderRadius: BorderRadius.circular(12),
              ),
              child: SfCircularChart(
                series: <ChartSeries>[
                  PieSeries<ExpenseData, String>(
                    dataSource: [
                      ExpenseData('Cibo', 300),
                      ExpenseData('Trasporto', 200),
                      ExpenseData('Divertimento', 150),
                      ExpenseData('Altro', 250),
                    ],
                    xMapper: (ExpenseData data) => data.category,
                    yMapper: (ExpenseData data) => data.amount,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class ExpenseData {
  final String month;
  final double amount;
  final String category;

  ExpenseData(this.month, this.amount, [this.category = '']);
}