import 'package:Dictionary/blocs/request_word.dart';
import 'package:Dictionary/views/empty_view.dart';
import 'package:Dictionary/views/error_view.dart';
import 'package:Dictionary/views/word_info_view.dart';
import 'package:Dictionary/blocs/search_bloc/word_search_bloc.dart';
import 'package:Dictionary/blocs/search_bloc/word_search_states.dart';
import 'package:Dictionary/widgets/border/border_radius.dart';
import 'package:Dictionary/widgets/cardDecoration/indicator_decoration.dart';
import 'package:Dictionary/widgets/colors/grey_color.dart';
import 'package:Dictionary/widgets/colors/grey_light_color.dart';
import 'package:Dictionary/widgets/colors/red_color.dart';
import 'package:Dictionary/widgets/gradientColor/gradient_widget.dart';
import 'package:Dictionary/widgets/gradientColor/icon_gradient.dart';
import 'package:flutter/material.dart';
import 'package:Dictionary/service/definition.api.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({Key? key}) : super(key: key);

  @override
  _SearchScreenState createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  TextEditingController _controller = TextEditingController();
  late WordSearchBloc _wordBloc = WordSearchBloc(repository: Repository());
  late final _focusNode = FocusNode();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar:
            AppBar(flexibleSpace: gradientLinear(), title: _textFieldBoard()),
        body: BlocBuilder(
            bloc: _wordBloc,
            builder: (_, WordSearchState state) {
              if (state is WordSearchError) {
                return errorView();
              }
              if (state is WordSearchLoading) {
                return indicatorCircular();
              }
              if (state is WordSearchLoaded) {
                return Column(children: [
                  Padding(
                    padding: EdgeInsets.only(
                      top: 20,
                      bottom: 20,
                    ),
                    child: Text(
                      _controller.text,
                      style: TextStyle(
                          fontFamily: 'Futura',
                          fontSize: 35,
                          color: greyColor()),
                      textAlign: TextAlign.center,
                    ),
                  ),
                  Expanded(
                    child: wordInfo(state.response),
                  ),
                ]);
              }
              return emptyView();
            }));
  }

  _textFieldBoard() => PreferredSize(
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
                _wordBloc.add(WordSwipe(word: word));
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
                    _wordBloc.add(WordSwipe(word: _controller.text));
                  }),
            ),
            autocorrect: true,
            maxLines: 1,
            enableSuggestions: true,
            cursorColor: redColor(),
            autofocus: true,
            style: TextStyle(
              fontSize: 15,
              color: Colors.black,
            ),
            controller: _controller,
          )));
}
