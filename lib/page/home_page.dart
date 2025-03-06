import 'package:flutter/material.dart';
import 'package:habit_tracker/componet/habit_tile.dart';
import 'package:habit_tracker/componet/month_sumary.dart';
import 'package:habit_tracker/componet/myfloat.dart';
import 'package:habit_tracker/componet/new_habit_box.dart';
import 'package:habit_tracker/data/habit_database.dart';
import 'package:hive_flutter/adapters.dart';
class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  HabitDatabase db  = HabitDatabase();
  final _myBox =  Hive.box("my_habit");
  @override
  void initState() {

    // TODO: implement initState
    if(_myBox.get("CURRENT_HABIT_LIST")==null){
      db.createDefaultData();
    }
    else{
      // if data base already created
      db.loadData();
    }

    db.updateDatabase();
    super.initState();
  }
  // bool habitCompleted = false;
  void checkBoxTapped(bool? value,int index){
    setState(() {
  // habitCompleted=value ?? false;
  // print(value!);
      db.todayHabitList[index][1] = value;
  });
    db.updateDatabase();

  }

  final _newHabitNameController =  TextEditingController();


  void createNewHabit(){
    // dilog
    showDialog(context: context,
        builder: (context){
      return EnterHabit(
        Controller: _newHabitNameController,
        onCancel: cencelNewHabit,
        onSave: saveNewHabit,
      );}
    );


  }
  void saveNewHabit(){
    setState(() {
      db.todayHabitList.add(
          [_newHabitNameController.text,false]
      );
    });
    _newHabitNameController.clear();
    Navigator.of(context).pop();
    db.updateDatabase();

  }
  void cencelNewHabit(){
  _newHabitNameController.clear();
  Navigator.of(context).pop();
  }

  // Delete a habit
  void deleteHabit(int index) {
    setState(() {
      db.todayHabitList.removeAt(index);
    });

    db.updateDatabase();
  }


  // Open dialog to edit an existing habit
  void openHabitSetting(int index) {
    _newHabitNameController.text = db.todayHabitList[index][0];
    showDialog(
      context: context,
      builder: (context) {
        return EnterHabit(
          Controller: _newHabitNameController,
          onSave: () => saveExistingHabit(index),
          onCancel: cencelNewHabit,
        );
      },
    );
  }

  // Save changes to an existing habit
  void saveExistingHabit(int index) {
    setState(() {
      db.todayHabitList[index][0] = _newHabitNameController.text;
    });
    _newHabitNameController.clear();
    Navigator.of(context).pop();
    db.updateDatabase();

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[300],
      floatingActionButton: MYFloatingActionButton(onPressed: createNewHabit,),
      body: Stack(
        children: [
          // Background Image
          Container(
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage("assets/img.png"), // Replace with your image path
                fit: BoxFit.cover, // Adjust the image to cover the entire background
              ),
            ),
          ),
          // Foreground Content
          ListView(
            children: [
              MonthlySummary(
                datasets: db.heatMapDataSet,
                startDate: _myBox.get("START_DATE"),
              ),
              ListView.builder(
                shrinkWrap: true,
                physics: NeverScrollableScrollPhysics(),
                itemCount: db.todayHabitList.length,
                itemBuilder: (context, index) {
                  return HabitTile(
                    habitName: db.todayHabitList[index][0],
                    habitCompleted: db.todayHabitList[index][1],
                    onChange: (value) => checkBoxTapped(value, index),
                    settingsTapped: (context) => openHabitSetting(index),
                    deleteTapped: (context) => deleteHabit(index),
                  );
                },
              ),
            ],
          ),
        ],
      ),
    );
  }
}
