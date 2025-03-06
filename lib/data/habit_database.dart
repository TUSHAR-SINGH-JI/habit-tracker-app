import 'package:flutter/material.dart';
import 'package:habit_tracker/datetime/date_time.dart';
import 'package:hive_flutter/adapters.dart';

final _mybox =  Hive.box("my_habit");

class HabitDatabase{
  List todayHabitList = [];
  Map<DateTime,int> heatMapDataSet = {

  };
  // create initial default data
  void createDefaultData(){
    todayHabitList = [
      ["run",false],
      ["read",false]
    ];
    _mybox.put("START_DATE", todaysDateFormatted());
  }
  // read data if it already exists
  void loadData(){
    // IF IT IS NEW DAY
    if(_mybox.get(todaysDateFormatted())==null){
      todayHabitList = _mybox.get("CURRENT_HABIT_LIST");
      for(int i=0;i<todayHabitList.length;i++){
        todayHabitList[i][1] = false;
      }
    }else{
      todayHabitList = _mybox.get(todaysDateFormatted());
    }
  }
  // update database
  void updateDatabase(){
    _mybox.put(todaysDateFormatted(),todayHabitList);
    _mybox.put("CURRENT_HABIT_LIST", todayHabitList);

    // CALCULATE HABIT COMPLETE PERCENTAGE FOR EACH DAY
    calculateHabitPercentage();
    // LOAD HEAT MAP
    lodeHeatMap();
  }

  void calculateHabitPercentage(){
    int counterCompleted  =  0;
    for(int i =0 ; i<todayHabitList.length; i++){
      if(todayHabitList[i][1]==true){
        counterCompleted++;
      }
    }
  String percent = todayHabitList.isEmpty?"0.0":(counterCompleted/todayHabitList.length).toStringAsFixed(1);
  _mybox.put("PERCENTAGE_SUMMARY_${todaysDateFormatted()}", percent);
  }

    void lodeHeatMap(){
    DateTime startDate  =  createDateTimeObject(_mybox.get("START_DATE"));
    int daysInBetween = DateTime.now().difference(startDate).inDays;

    for (int i = 0; i < daysInBetween + 1; i++) {
      String yyyymmdd = convertDateTimeToString(
        startDate.add(Duration(days: i)),
      );
      double strengthAsPercent = double.parse(
        _mybox.get("PERCENTAGE_SUMMARY_$yyyymmdd") ?? "0.0",
      );

      // split the datetime up like below so it doesn't worry about hours/mins/secs etc.

      // year
      int year = startDate.add(Duration(days: i)).year;

      // month
      int month = startDate.add(Duration(days: i)).month;

      // day
      int day = startDate.add(Duration(days: i)).day;

      final percentForEachDay = <DateTime, int>{
        DateTime(year, month, day): (10*strengthAsPercent).toInt(),
      };
      heatMapDataSet.addEntries(percentForEachDay.entries);
      print(heatMapDataSet);
    }
  }

}
