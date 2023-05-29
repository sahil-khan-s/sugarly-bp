import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';

class BloodSugarChart extends StatefulWidget {
  final List<BloodSugarData> bloodSugarData;

  BloodSugarChart({required this.bloodSugarData});

  @override
  _BloodSugarChartState createState() => _BloodSugarChartState();
}

class _BloodSugarChartState extends State<BloodSugarChart> {
  @override
  Widget build(BuildContext context) {
    return LineChart(
      LineChartData(
        minX: 0,
        maxX: widget.bloodSugarData.length.toDouble() - 1,
        minY: 0,
        maxY: 7,
        lineBarsData: [
          LineChartBarData(
            spots: _generateSpots(),
            colors: [Theme.of(context).canvasColor],
            isCurved: true,
            barWidth: 2,
            dotData: FlDotData(show: true),
            belowBarData: BarAreaData(show: false),
          ),
        ],
        gridData: FlGridData(
          show: true,

          drawVerticalLine: true,
          drawHorizontalLine: true,

          getDrawingVerticalLine: (value) => FlLine(color: Colors.grey.withOpacity(0.2), strokeWidth: 1),
          getDrawingHorizontalLine: (value) => FlLine(color: Colors.grey.withOpacity(0.2), strokeWidth: 1),
        ),
        titlesData: FlTitlesData(
          bottomTitles: SideTitles(
            showTitles: true,
            margin: 8,
            getTitles: (value) {
              if (value.toInt() < widget.bloodSugarData.length) {
                return widget.bloodSugarData[value.toInt()].date;
              }
              return '';
            },
          ),
          leftTitles: SideTitles(
            showTitles: true,
            margin: 8,
            reservedSize: 32,
            getTitles: (value) => (value % 1 == 0) ? value.toInt().toString() : '',
          ),
        ),
        borderData: FlBorderData(show: false),
      ),
    );
  }

  List<FlSpot> _generateSpots() {
    return widget.bloodSugarData
        .asMap()
        .entries
        .map((entry) => FlSpot(entry.key.toDouble(), entry.value.value))
        .toList();
  }
}

class BloodSugarData {
  final String date;
  final double value;

  BloodSugarData({required this.date, required this.value});
}