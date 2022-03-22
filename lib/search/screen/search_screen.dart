import 'package:Dictionary/cards/model/search_response.dart';
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
    return BlocConsumer<WordSearchBloc, WordSearchState>(
      listener: (context, state) {
        if (state is WordSearchError) {
          return errorOutput(
              error: 'There is no such word in the dictionary',
              context: context);
        }
      },
      builder: (_, state) {
        if (state is WordSearchLoading) {
          return indicatorCircular();
        }
        if (state is WordSearchLoaded) {
          return WordInfo(
            response: state.response,
          );
        }
        if (state is WordSearchEmpty) {
          return EmptyView();
        }

        return EmptyView();
      },
    );
  }
}

class WordInfo extends StatelessWidget {
  final SearchResponse response;

  WordInfo({Key? key, required this.response}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(children: [
      Padding(
        padding: const EdgeInsets.symmetric(
          vertical: 20,
        ),
        child: Text(
          response.word,
          style: Theme.of(context).textTheme.subtitle1,
          textAlign: TextAlign.center,
        ),
      ),
      Expanded(
        child: BackCard(
            response: response, color: greyLightColor.withOpacity(0.3)),
      ),
    ]);
  }
}
