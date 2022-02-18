import 'package:Dictionary/cards/card_bloc/word_card_bloc.dart';
import 'package:flutter/material.dart';

class LangDropDownButton extends StatefulWidget {

 final WordCardBloc wordCardBloc;
  LangDropDownButton({required this.wordCardBloc});
  @override
  State<LangDropDownButton> createState() => _LangDropDownButtonState();
}

class _LangDropDownButtonState extends State<LangDropDownButton> {
  final Map<String, String> langes = {
    'English': 'en',
    'French': 'fr',
    'Spanish': 'es',
    'Russian': 'ru'
  };
  String value = 'English';

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 100,
      height: 50,
      child: DropdownButton(
          value: value,
          onChanged: (String? newValue) {
            setState(() {
              value = newValue!;
            });

            print(value);

          //  widget.wordCardBloc.add(WordChangeLang(lang: langes[value]!));
          },
          items: langes.keys.map((lang) {
            return DropdownMenuItem(
              child: Text(lang, style: TextStyle(fontSize: 16),),
              value: lang,
            );
          }).toList()),
    );
  }
}