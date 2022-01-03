import 'package:Dictionary/favorite_words/bloc/favorite_words_bloc.dart';
import 'package:Dictionary/favorite_words/bloc/favorite_words_event.dart';
import 'package:Dictionary/favorite_words/model/words_model.dart';
import 'package:Dictionary/favorite_words/service/favorite_words_service.dart';
import 'package:Dictionary/theme/theme_colors.dart';
import 'package:favorite_button/favorite_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class FavoriteWordsButton extends StatefulWidget {
  final WordData word;
  final bool isFavorited;

  FavoriteWordsButton({required this.word, required this.isFavorited});

  @override
  State<FavoriteWordsButton> createState() => _FavoriteWordsButtonState();
}

class _FavoriteWordsButtonState extends State<FavoriteWordsButton> {
  FavWordsBloc _favWordsBloc = FavWordsBloc(FavWordsServiceImpl());

  @override
  void initState() {
    super.initState();
    _favWordsBloc.add(InitialEvent());
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder(
        bloc: _favWordsBloc,
        builder: (context, state) {
          return FavoriteButton(
              isFavorite: widget.isFavorited,
              iconSize: 30,
              iconDisabledColor: redColor,
              iconColor: redColor,
              valueChanged: (_isFavorite) {
                if (_isFavorite) {
                  _favWordsBloc.add(AddToFavWordsEvent(word: widget.word));
                  _favWordsBloc.favWords!.add(widget.word);
                } else {
                  _favWordsBloc.add(DeleteFavWordsEvent(word: widget.word));
                  _favWordsBloc.favWords!.remove(widget.word);
                }
              });
        });
  }
}
