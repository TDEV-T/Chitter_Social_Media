import 'package:flutter/material.dart';

class custom_TextField extends StatefulWidget {
  const custom_TextField(
      {Key? key,
      required this.label,
      required this.controller,
      required this.validator,
      required this.keyboardType,
      required this.enableStatus,
      required this.isPassword})
      : super(key: key);

  final String label;
  final TextEditingController controller;
  final String? Function(String?) validator;
  final TextInputType keyboardType;
  final bool enableStatus;
  final bool isPassword;

  @override
  State<custom_TextField> createState() => _custom_TextFieldState();
}

class _custom_TextFieldState extends State<custom_TextField> {
  bool _obscureText = true;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: widget.controller,
      decoration: InputDecoration(
        labelText: widget.label,
        suffixIcon: widget.isPassword
            ? IconButton(
                onPressed: () {
                  setState(() {
                    _obscureText = !_obscureText;
                  });
                },
                icon: Icon(
                    _obscureText ? Icons.visibility : Icons.visibility_off))
            : null,
      ),
      enabled: widget.enableStatus,
      validator: widget.validator,
      obscureText: widget.isPassword ? _obscureText : false,
      keyboardType: widget.keyboardType,
    );
  }
}
