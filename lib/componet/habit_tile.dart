import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';

class HabitTile extends StatelessWidget {
  final String habitName;
  final bool habitCompleted;
  final Function(bool?)? onChange;
  final Function(BuildContext)? settingsTapped;
  final Function(BuildContext)? deleteTapped;

  const HabitTile({
    super.key,
    required this.habitName,
    required this.habitCompleted,
    required this.onChange,
    required this.settingsTapped,
    required this.deleteTapped,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Slidable(
        endActionPane: ActionPane(
          motion: StretchMotion(),
          children: [
            SlidableAction(
              onPressed: settingsTapped,
              icon: Icons.settings,
              backgroundColor: Colors.grey.shade800,
              foregroundColor: Colors.white,
              borderRadius: BorderRadius.circular(12),
            ),
            SlidableAction(
              onPressed: deleteTapped,
              backgroundColor: Colors.redAccent,
              icon: Icons.delete,
              foregroundColor: Colors.white,
              borderRadius: BorderRadius.circular(12),
            ),
          ],
        ),
        child: Container(
          padding: const EdgeInsets.all(24),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(12),
            gradient: LinearGradient(
              colors: [
                Colors.deepPurpleAccent,
                Colors.lightBlueAccent,
                Colors.grey,
              ],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
            boxShadow: [
              BoxShadow(
                color: Colors.redAccent.withOpacity(0.5),
                offset: Offset(4, 4), // Bottom-right shadow
                blurRadius: 8,
              ),
              BoxShadow(
                color: Colors.orangeAccent,
                offset: Offset(-4, -4), // Top-left shadow
                blurRadius: 8,
              ),
              BoxShadow(
                color: Colors.grey.withOpacity(0.2),
                offset: Offset(0, 4), // Bottom shadow
                blurRadius: 6,
              ),
            ],
          ),
          child: Row(
            children: [
              Checkbox(
                value: habitCompleted,
                onChanged: onChange,
              ),
              Text(
                habitName,
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                  color: Colors.white, // Text color for better contrast
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
