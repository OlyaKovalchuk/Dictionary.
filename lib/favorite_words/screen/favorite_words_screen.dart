import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:swipable_stack/swipable_stack.dart';

import '../../cards/views/empty_view.dart';
import '../../cards/views/error_view.dart';
import '../bloc/favorite_words_bloc.dart';
import '../bloc/favorite_words_event.dart';
import '../bloc/favorite_words_state.dart';
import '../utils/is_empty_list_fav_words.dart';
import '../widgets/build_circular_indicator.dart';
import '../widgets/button_add_word.dart';
import '../widgets/fav_words_builder.dart';

class FavoriteWordsScreen extends StatefulWidget {
  @override
  State<FavoriteWordsScreen> createState() => _FavoriteWordsScreenState();
}

class _FavoriteWordsScreenState extends State<FavoriteWordsScreen> {
  late SwipableStackController _controller;

  @override
  void initState() {
    super.initState();
    _controller = SwipableStackController();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: ButtonAddWord(),
      body: BlocBuilder(
          bloc: BlocProvider.of<FavWordsBloc>(context)..add(GetFavWordsEvent()),
          builder: (BuildContext context, state) {
            if (state is LoadingState) {
              return BuildCircularIndicator();
            } else if (state is SuccessState) {
              if (isEmptyListFavWords(context)) {
                return EmptyView();
              } else {
                return ListFavWordsBuilder(controller: _controller);
              }
            }
            return ErrorView();
          }),
    );
  }
}
