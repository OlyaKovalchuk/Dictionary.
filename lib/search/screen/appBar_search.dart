import 'package:Dictionary/search/search_bloc/word_search_bloc.dart';
import 'package:Dictionary/search/search_bloc/word_search_event.dart';
import 'package:Dictionary/widgets/border/border_radius.dart';
import 'package:Dictionary/widgets/colors/grey_light_color.dart';
import 'package:Dictionary/widgets/colors/red_color.dart';
import 'package:Dictionary/widgets/gradientColor/gradient_widget.dart';
import 'package:Dictionary/widgets/gradientColor/icon_gradient.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

appBarSearch(BuildContext context) =>AppBar(flexibleSpace: gradientLinear(), title: textFieldBoard(context),
automaticallyImplyLeading: false,
);

textFieldBoard(BuildContext context) {
  late final _focusNode = FocusNode();
  TextEditingController _controller = TextEditingController();

  return PreferredSize(
      preferredSize: Size.fromHeight(40.0),
      child: Container(
          decoration: BoxDecoration(
            borderRadius: borderRadius(),
            color: Colors.white,
          ),
          height: 40,
          child: TextField(
            focusNode: _focusNode,
            onSubmitted: (word) {
              _focusNode.consumeKeyboardToken();
              if (word != '') {
                BlocProvider.of<WordSearchBloc>(context)..add(WordSearch(word: _controller.text));
              }
            },
            decoration: InputDecoration(
              focusedBorder: OutlineInputBorder(
                borderSide: BorderSide(
                  color: Colors.white,
                ),
                borderRadius: borderRadius(),
              ),
              enabledBorder: OutlineInputBorder(
                borderRadius: borderRadius(),
                borderSide: BorderSide(
                  color: Colors.white,
                ),
              ),
              contentPadding: EdgeInsets.only(left: 15),
              hintText: 'Enter a word',
              hintStyle: TextStyle(color: greyLightColor()),
              suffixIcon: IconButton(
                  icon: iconGradient(),
                  onPressed: () {
                    BlocProvider.of<WordSearchBloc>(context)..add(WordSearch(word: _controller.text));
                  }),
            ),
            autocorrect: true,
            maxLines: 1,
            cursorColor: redColor(),
            autofocus: false,
            style: TextStyle(
              fontSize: 15,
              color: Colors.black,
            ),
            controller: _controller,
          )));
}