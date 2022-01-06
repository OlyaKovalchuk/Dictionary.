import 'package:Dictionary/search/bloc/word_search_bloc.dart';
import 'package:Dictionary/search/bloc/word_search_event.dart';
import 'package:Dictionary/search/utils/error_output.dart';
import 'package:Dictionary/theme/theme_colors.dart';
import 'package:Dictionary/search/widgets/icon_gradient.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

textFieldBoard(BuildContext context) {
  final BorderRadius borderRadius = BorderRadius.circular(40);
  late final _focusNode = FocusNode();
  TextEditingController _controller = TextEditingController();

  return PreferredSize(
      preferredSize: Size.fromHeight(40.0),
      child: Container(
          decoration: BoxDecoration(
            borderRadius: borderRadius,
            color: Colors.white,
          ),
          height: 40,
          child: TextField(
            focusNode: _focusNode,
            onSubmitted: (word) {
              _focusNode.consumeKeyboardToken();
              if (word != '') {
                BlocProvider.of<WordSearchBloc>(context)
                  ..add(WordSearch(word: _controller.text));
              }
            },
            decoration: InputDecoration(
              focusedBorder: OutlineInputBorder(
                borderSide: BorderSide(
                  color: Colors.white,
                ),
                borderRadius: borderRadius,
              ),
              enabledBorder: OutlineInputBorder(
                borderRadius: borderRadius,
                borderSide: BorderSide(
                  color: Colors.white,
                ),
              ),
              contentPadding: EdgeInsets.only(left: 15),
              hintText: 'Enter a word',
              hintStyle: TextStyle(color: greyLightColor),
              counterStyle: Theme.of(context)
                  .textTheme
                  .bodyText1!
                  .copyWith(color: greyDarkColor),
              suffixIcon: IconButton(
                  icon: iconGradient(),
                  onPressed: () {
                    if (_controller.text == '') {
                      errorOutput(error: 'Enter a word', context: context);
                    } else {
                      BlocProvider.of<WordSearchBloc>(context)
                        ..add(WordSearch(word: _controller.text));
                    }
                  }),
            ),
            autocorrect: true,
            maxLines: 1,
            autofocus: false,
            style: TextStyle(
              fontSize: 15,
              color: Colors.black,
            ),
            controller: _controller,
          )));
}
