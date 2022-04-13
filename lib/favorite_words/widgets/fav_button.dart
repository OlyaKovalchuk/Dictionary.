import 'package:Dictionary/favorite_words/bloc/favorite_words_bloc.dart';
import 'package:Dictionary/favorite_words/bloc/favorite_words_event.dart';
import 'package:Dictionary/favorite_words/model/words_model.dart';
import 'package:Dictionary/favorite_words/service/favorite_words_service.dart';
import 'package:Dictionary/theme/theme_colors.dart';
import 'package:favorite_button/favorite_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class FavoriteWordsButton extends StatelessWidget {
  final WordData word;
  final bool isFavorited;

  FavoriteWordsButton({required this.word, required this.isFavorited});

  final FavWordsBloc _favWordsBloc = FavWordsBloc(FavWordsServiceImpl());

  @override
  Widget build(BuildContext context) {
    return Align(
        alignment: Alignment.centerRight,
        child: BlocBuilder(
            bloc: _favWordsBloc..add(InitialEvent()),
            builder: (context, state) {
              return FavoriteButton(
                  isFavorite: isFavorited,
                  iconSize: 30,
                  iconDisabledColor: redColor,
                  iconColor: redColor,
                  valueChanged: (_isFavorite) {
                    if (_isFavorite) {
                      _favWordsBloc.add(AddToFavWordsEvent(word: word));
                      _favWordsBloc.favWords!.add(word);
                    } else {
                      _favWordsBloc.add(DeleteFavWordsEvent(word: word));
                      _favWordsBloc.favWords!.remove(word);
                    }
                  });
            }));
  }
}
