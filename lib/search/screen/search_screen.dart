import 'package:Dictionary/cards/views/empty_view.dart';
import 'package:Dictionary/cards/views/word_info_view.dart';
import 'package:Dictionary/cards/widgets/cardDecoration/indicator_decoration.dart';
import 'package:Dictionary/search/bloc/word_search_bloc.dart';
import 'package:Dictionary/search/bloc/word_search_states.dart';
import 'package:Dictionary/search/utils/error_output.dart';
import 'package:Dictionary/theme/theme_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SearchScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocListener<WordSearchBloc, WordSearchState>(
      listener: (_, state) {
        if (state is WordSearchError) {
          return errorOutput(
              error: 'There is no such word in the dictionary',
              context: context);
        }
      },
      child: BlocBuilder<WordSearchBloc, WordSearchState>(
        builder: (_, state) {
          if (state is WordSearchLoading) {
            return indicatorCircular();
          }
          if (state is WordSearchLoaded) {
            return Column(children: [
              Padding(
                padding: EdgeInsets.symmetric(
                  vertical: 20,
                ),
                child: Text(
                  state.response.word,
                  style: Theme.of(context).textTheme.subtitle1,
                  textAlign: TextAlign.center,
                ),
              ),
              Expanded(
                child:
                    wordInfo(state.response, greyLightColor.withOpacity(0.3)),
              ),
            ]);
          }
          if (state is WordSearchEmpty) {
            return emptyView();
          }

          return emptyView();
        },
      ),
    );
  }
}
