import 'package:Dictionary/theme/theme_colors.dart';
import 'package:flutter/material.dart';

//TODO reformat code
// class TextFieldBuilder extends StatelessWidget {
//   String? errorText;
//       FocusNode? focusNode;
//    TextEditingController controller;
//    TextInputType textInputType;
//    String hint;
//   String? validator(String? val){}
//   onSubmit(String str){}
//   const TextFieldBuilder({Key? key, this.errorText, this.focusNode, required this.controller, required this.textInputType, required this.hint, required this., }) : super(key: key);
//
//   @override
//   Widget build(BuildContext context) {
//     return Container();
//   }
// }
//

buildTextField({
  String? errorText,
  FocusNode? focusNode,
  required TextEditingController controller,
  required TextInputType textInputType,
  required String hint,
  String? validator(String? val)?,
  onSubmit(String str)?,
}) =>
    TextFormField(
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

_inputDecoration({required String? errorText, required String hint}) =>
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
