import 'package:flutter/material.dart';

// VoidCallback : It’s used because buttons don't expect the function to return anything — they just want to execute some code when pressed.
// The function you provide (() { ... }) is of type VoidCallback.

// It runs when the button is tapped.

// It doesn't return a value, because the button doesn’t need one.

// It just performs side effects (like printing, updating state, navigating)

class MyButton extends StatelessWidget {
  final String text;
  VoidCallback onPressed;

  MyButton({super.key, required this.text, required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return MaterialButton(
      onPressed: onPressed,
      color: Color(0xFF1a1b3a),
      child: Text(
        text,
        style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
      ),
    );
  }
}
