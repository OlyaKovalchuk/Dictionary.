import 'package:Dictionary/theme/theme_colors.dart';
import 'package:flutter/material.dart';

class TextFieldBuilder extends StatelessWidget {
  final String? errorText;
  final FocusNode? focusNode;
  final TextEditingController controller;
  final TextInputType textInputType;
  final String hint;
  final String? Function(String? val) validator;
  final Function(String str)? onSubmit;

  TextFieldBuilder(
      {Key? key,
      this.errorText,
      this.focusNode,
      required this.controller,
      required this.textInputType,
      required this.hint,
      required this.validator,
      this.onSubmit})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      autovalidateMode: AutovalidateMode.onUserInteraction,
      validator: validator,
      focusNode: focusNode,
      onFieldSubmitted: onSubmit,
      decoration: _inputDecoration(errorText: errorText, hint: hint),
      maxLines: 1,
      enableSuggestions: true,
      style: TextStyle(
        fontSize: 15,
        color: Colors.black,
      ),
      keyboardType: textInputType,
      controller: controller,
    );
  }
}

InputDecoration _inputDecoration(
        {required String? errorText, required String hint}) =>
    InputDecoration(
        focusedBorder: _outlineInputDecor(redColor),
        enabledBorder: _outlineInputDecor(greyLightColor),
        contentPadding: EdgeInsets.only(left: 15),
        hintText: hint,
        hintStyle: TextStyle(color: greyLightColor),
        focusedErrorBorder: _outlineInputDecor(Colors.red),
        errorBorder: _outlineInputDecor(Colors.red),
        errorStyle: TextStyle(color: Colors.red),
        errorText: errorText);

OutlineInputBorder _outlineInputDecor(Color color) {
  return OutlineInputBorder(
    borderSide: BorderSide(color: color),
    borderRadius: BorderRadius.circular(40),
  );
}
