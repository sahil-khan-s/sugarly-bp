import 'dart:math';

import 'package:bpcheck/config/app_colors.dart';
import 'package:bpcheck/pages/patient_screens/models/dashboard_card_data.dart';
import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:intl/intl.dart';

import '../../login/database_service.dart';

class SugarChart extends StatefulWidget {
  @override
  _SugarChartState createState() => _SugarChartState();
}

class _SugarChartState extends State<SugarChart> {
  final DatabaseService _databaseService = DatabaseService();


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.primaryColor,
        title: Text('Blood Sugar Chart'),
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: StreamBuilder(
        stream: _databaseService.getBloodSugarRecords(),
        builder: (BuildContext context, AsyncSnapshot<List<BloodSugarRecord>> snapshot) {
          if (snapshot.hasData) {
            if (snapshot.data!.isNotEmpty) {
              snapshot.data!.sort((a, b) => a.date.compareTo(b.date));
              List<FlSpot> spots = snapshot.data!
                  .asMap()
                  .map((index, record) => MapEntry(index, FlSpot(index.toDouble(), record.sugarConcentration)))
                  .values
                  .toList();
              return Padding(
                padding: const EdgeInsets.all(20),
                child: SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: SizedBox(
                    width: (snapshot.data!.length * 50).toDouble(),

                    child: LineChart(
                      LineChartData(
                        gridData: FlGridData(
                          show: true,

                          drawVerticalLine: true,
                          drawHorizontalLine: true,

                          getDrawingVerticalLine: (value) => FlLine(color: Colors.grey.withOpacity(0.2), strokeWidth: 1),
                          getDrawingHorizontalLine: (value) => FlLine(color: Colors.grey.withOpacity(0.2), strokeWidth: 1),
                        ),
                        minX: 0,
                        maxX: (snapshot.data!.length - 1).toDouble(),
                        minY: 0,
                        maxY: snapshot.data!.map((record) => record.sugarConcentration).reduce(max).toDouble(),
                        borderData: FlBorderData(show: false),
                        lineTouchData: LineTouchData(enabled: false),
                        lineBarsData: [
                          LineChartBarData(
                            spots: spots,
                            isCurved: true,
                            colors: [AppColors.primaryColor],
                            barWidth: 2,
                            isStrokeCapRound: true,
                            dotData: FlDotData(show: false),
                            belowBarData: BarAreaData(show: false),
                          ),
                        ],
                        titlesData: FlTitlesData(
                          bottomTitles: SideTitles(
                            showTitles: true,
                            getTitles: (value) {
                              int index = value.toInt();
                              if (index >= 0 && index < snapshot.data!.length) {
                                DateTime date = snapshot.data![index].date;
                                int numberOfLabels = 5; // Change this value to control the number of labels

                                List<int> labelIndices = List.generate(numberOfLabels, (i) {
                                  int step = ((snapshot.data!.length - 1) / (numberOfLabels - 1)).ceil();
                                  int recordIndex = i * step;
                                  return recordIndex;
                                });

                                if (labelIndices.contains(index) || index == snapshot.data!.length - 1) {
                                  return DateFormat('MMM dd').format(date);
                                }
                              }
                              return '';
                            },
                          ),
                        leftTitles: SideTitles(
                            showTitles: true,
                            reservedSize: 32,
                            margin: 8,
                            getTitles: (value) {
                              return value.toInt().toString();

                            },
                          ),
                        ),

                      ),
                    ),
                  ),
                ),
              );
            } else {
              return Center(child: Text('No records found.'));
            }
          } else {
            return Center(child: CircularProgressIndicator());
          }
        },
      ),
    );
  }
}