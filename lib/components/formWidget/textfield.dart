import 'package:flutter/material.dart';

class TextInputField extends StatefulWidget {
  const TextInputField({
    Key? key,
    required this.controller,
    required this.hintText,
    required this.validator,
    required this.keyboardType,
    required this.prefixIcon,
  }) : super(key: key);

  final TextEditingController controller;
  final String hintText;
  final String? Function(String?) validator;
  final Icon prefixIcon;
  final TextInputType keyboardType;

  @override
  State<TextInputField> createState() => _TextInputFieldState();
}

class _TextInputFieldState extends State<TextInputField>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<double> _animation;
  late FocusNode _focusNode;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 500),
    );
    _animation = Tween(begin: 0.0, end: 1.0).animate(_animationController);
    _focusNode = FocusNode();
    _focusNode.addListener(() {
      if (_focusNode.hasFocus) {
        _animationController.forward();
      } else {
        _animationController.reverse();
      }
    });
  }

  @override
  void dispose() {
    _animationController.dispose();
    _focusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      focusNode: _focusNode,
      controller: widget.controller,
      keyboardType: widget.keyboardType,
      autofocus: false,
      enableSuggestions: false,
      autocorrect: false,
      decoration: InputDecoration(
        hintText: widget.hintText,
        hintStyle: const TextStyle(color: Colors.black),
        prefixIcon: widget.prefixIcon,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(40),
          borderSide: const BorderSide(width: 0, style: BorderStyle.none),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(40),
          borderSide: BorderSide.lerp(
            const BorderSide(color: Colors.transparent),
            const BorderSide(color: Colors.amberAccent, width: 2),
            _animation.value,
          ),
        ),
        filled: true,
        isDense: true,
        contentPadding: const EdgeInsets.fromLTRB(10, 10, 10, 10),
        fillColor: Colors.grey[300],
      ),
      validator: widget.validator,
      onTap: () => _animationController.forward(),
    );
  }
}
