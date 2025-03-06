import 'package:flutter/material.dart';
import 'package:flutter_heatmap_calendar/flutter_heatmap_calendar.dart';
import 'package:habit_tracker/datetime/date_time.dart';

class MonthlySummary extends StatelessWidget {
  final Map<DateTime, int>? datasets;
  final String startDate;

  const MonthlySummary({
    super.key,
    required this.datasets,
    required this.startDate,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(top: 25, bottom: 25),
      child: HeatMap(
        startDate: createDateTimeObject(startDate),
        endDate: DateTime.now().add(Duration(days: 54)),
        datasets: datasets,
        colorMode: ColorMode.color,
        defaultColor: Colors.transparent,
        textColor: Colors.white,
        showColorTip: false,
        showText: true,
        scrollable: true,
        size: 30,
        colorsets: const {
          1: Color.fromARGB(50, 2, 179, 8),
          2: Color.fromARGB(100, 2, 179, 8),
          3: Color.fromARGB(150, 2, 179, 8),
          4: Color.fromARGB(200, 2, 179, 8),
          5: Color.fromARGB(230, 2, 179, 8),
          6: Color.fromARGB(255, 2, 179, 8),
          7: Color.fromARGB(255, 2, 160, 6),
          8: Color.fromARGB(255, 2, 140, 5),
          9: Color.fromARGB(255, 2, 120, 4),
          10: Color.fromARGB(255, 2, 100, 3),
        },
        onClick: (value) {
          ScaffoldMessenger.of(context)
              .showSnackBar(SnackBar(content: Text(value.toString())));
        },
      ),
    );
  }
}