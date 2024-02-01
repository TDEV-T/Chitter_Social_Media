import 'package:flutter/material.dart';
class custom_Switch extends StatelessWidget {
  final String label;
  final bool value;
  final ValueChanged<bool> onChanged;

  custom_Switch({required this.label, required this.value, required this.onChanged});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Text(label),
        Switch(
          value: value,
          onChanged: onChanged,
        ),
      ],
    );
  }
}