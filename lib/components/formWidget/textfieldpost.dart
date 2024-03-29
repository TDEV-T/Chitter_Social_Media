import 'package:flutter/material.dart';
class TextFieldPost extends StatelessWidget {
  const TextFieldPost({    Key? key,
    required this.controller,
    required this.hintText,
    required this.validator,
    required this.onChange,
    required this.maxLength,
    required this.keyboardType}) : super(key: key);


  final TextEditingController controller;
  final String hintText;
  final String? Function(String?) validator;
  final int? maxLength;
  final void  Function(String?) onChange;
  final TextInputType keyboardType;

  @override
  Widget build(BuildContext context) {
    return  TextFormField(
      controller: controller,
      autovalidateMode: AutovalidateMode.disabled,
      keyboardType: keyboardType,
      autofocus: false,
      enableSuggestions: false,
      autocorrect: false,
      maxLines: null,
      maxLength: maxLength,
      onChanged: onChange,
      validator: validator,
      decoration:  InputDecoration(
        errorText: validator(controller.value.toString()),
        counterText: '',
        hintText: hintText,
        hintStyle:  const TextStyle(color: Colors.grey),
      ),
    );
  }
}
