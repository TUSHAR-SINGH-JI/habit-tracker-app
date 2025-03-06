import 'package:flutter/material.dart';

class MYFloatingActionButton extends StatelessWidget {
  final Function()? onPressed;

  const MYFloatingActionButton({super.key, required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return FloatingActionButton(
      onPressed: onPressed,
      child: Stack(
        alignment: Alignment.center,
        children: [
          // Outer shadow effect
          Positioned(
            top: 3,
            left: 3,
            child: Icon(
              Icons.fitness_center,
              size: 28,
              color: Colors.black.withOpacity(0.2), // Shadow color
            ),
          ),
          // Main icon
          Icon(
            Icons.fitness_center,
            size: 28,
            color: Colors.white, // Main icon color
          ),
        ],
      ),
      backgroundColor: Colors.blue, // Customize your FAB color
      elevation: 8, // Adds a drop shadow to the FAB itself
    );
  }
}
