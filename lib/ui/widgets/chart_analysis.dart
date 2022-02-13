import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:reade/shared/theme.dart';

class ChartAnalysis extends StatefulWidget {
  final List<dynamic> arrayScores;
  const ChartAnalysis({Key? key, required this.arrayScores}) : super(key: key);

  @override
  _ChartAnalysisState createState() => _ChartAnalysisState();
}

class _ChartAnalysisState extends State<ChartAnalysis> {
  List<Color> gradientColors = [
    kBackgroundColor,
    kPrimaryColor,
  ];

  @override
  Widget build(BuildContext context) {
    return Stack(
        children: <Widget>[
          AspectRatio(
            aspectRatio: 1.70,
            child: Container(
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.all(
                    Radius.circular(18),
                  ),
                  color: kDarkColor),
              child: Padding(
                padding: const EdgeInsets.only(
                  right: 18.0,
                  left: 12.0,
                  top: 24,
                  bottom: 12,
                ),
                child: LineChart(
                  mainData(),
                ),
              ),
            ),
          ),
        ],
      );
  }

  LineChartData mainData() {
    return LineChartData(
      titlesData: FlTitlesData(
        show: true,
        rightTitles: SideTitles(showTitles: false),
        topTitles: SideTitles(showTitles: false),
        bottomTitles: SideTitles(
          showTitles: true,
          reservedSize: 22,
          interval: 1,
          getTextStyles: (context, value) => TextStyle(
              color: kBackgroundColor,
              fontWeight: FontWeight.bold,
              fontSize: 16,
          ),
          getTitles: (value) {
            switch (value.toInt()) {
              case 3:
                return '1';
              case 6:
                return '2';
              case 9:
                return '3';
            }
            return '';
          },
          margin: 8,
        ),
        leftTitles: SideTitles(
          showTitles: true,
          interval: 1,
          getTextStyles: (context, value) => TextStyle(
            color: kBackgroundColor,
            fontWeight: FontWeight.bold,
            fontSize: 15,
          ),
          getTitles: (value) {
            switch (value.toInt()) {
              case 0:
                return '0';
              case 50:
                return '50';
              case 100:
                return '100';
            }
            return '';
          },
          reservedSize: 32,
          margin: 12,
        ),
      ),
      borderData: FlBorderData(
        show: true,
        border: Border.all(
          color: const Color(0xff37434d),
          width: 1,
        ),
      ),
      minX: 0,
      maxX: 11,
      minY: 0,
      maxY: 100,
      lineBarsData: [
        LineChartBarData(
          spots: [
            FlSpot(0, 0),
            FlSpot(3, widget.arrayScores.length > 3 ? widget.arrayScores[widget.arrayScores.length-3].toDouble() : 0,),
            FlSpot(6, widget.arrayScores.length > 2 ? widget.arrayScores[widget.arrayScores.length-2].toDouble() : 0),
            FlSpot(9, widget.arrayScores[widget.arrayScores.length-1].toDouble()),
          ],
          isCurved: true,
          colors: gradientColors,
          barWidth: 5,
          isStrokeCapRound: true,
          dotData: FlDotData(
            show: false,
          ),
          belowBarData: BarAreaData(
            show: true,
            colors:
                gradientColors.map((color) => color.withOpacity(0.3)).toList(),
          ),
        ),
      ],
    );
  }
}
