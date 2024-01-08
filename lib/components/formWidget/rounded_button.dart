import 'package:flutter/material.dart';

class RoundedButton extends StatefulWidget {
  const RoundedButton({Key? key, required this.label, required this.onPressed})
      : super(key: key);

  final String label;
  final VoidCallback onPressed;

  @override
  _RoundedButtonState createState() => _RoundedButtonState();
}

class _RoundedButtonState extends State<RoundedButton> {
  bool isPressed = false;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: () {
        widget.onPressed();
        setState(() {
          isPressed = !isPressed;
        });
      },
      style: ElevatedButton.styleFrom(
        padding: EdgeInsets.zero,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
        ),
        backgroundColor: isPressed ? Colors.amber[300] : Colors.amber[500],
      ),
      child: Ink(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
        ),
        child: Container(
          height: 40,
          alignment: Alignment.center,
          child: Text(
            widget.label,
            style: const TextStyle(fontSize: 15, color: Colors.white),
          ),
        ),
      ),
    );
  }
}
