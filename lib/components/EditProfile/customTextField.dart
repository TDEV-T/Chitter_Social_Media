import 'package:flutter/material.dart';

class custom_TextField extends StatelessWidget {
  const custom_TextField(
      {Key? key,
      required this.label,
      required this.controller,
      required this.validator,
      required this.keyboardType,
      required this.enableStatus})
      : super(key: key);

  final String label;
  final TextEditingController controller;
  final String? Function(String?) validator;
  final TextInputType keyboardType;
  final bool enableStatus;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      decoration: InputDecoration(
        labelText: label,
      ),
      enabled: enableStatus,
      validator: validator,
      keyboardType: keyboardType,
    );
  }
}
