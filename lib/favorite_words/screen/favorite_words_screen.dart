import 'package:dictionary/audio_fun.dart';
import 'package:dictionary/favorite_words/bloc/favorite_words_bloc.dart';
import 'package:dictionary/favorite_words/bloc/favorite_words_event.dart';
import 'package:dictionary/favorite_words/bloc/favorite_words_state.dart';
import 'package:dictionary/favorite_words/model/words_model.dart';
import 'package:dictionary/favorite_words/service/favorite_words_service.dart';
import 'package:dictionary/widgets/appBar.dart';
import 'package:dictionary/widgets/cardDecoration/indicator_decoration.dart';
import 'package:dictionary/widgets/colors/grey_color.dart';
import 'package:dictionary/widgets/colors/red_color.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';

class FavoriteWordsScreen extends StatelessWidget {
  final FavWordsBloc _favWordsBloc = FavWordsBloc(FavWordsServiceImpl());
  List<WordData>? _favWords;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: buildAppBar(title: 'Favorite Words'),
        body: BlocBuilder(
          bloc: _favWordsBloc..add(GetFavWordsEvent()),
          builder: (BuildContext context, state) {
            _favWords = _favWordsBloc.favWords;
            if (state is LoadingState) {
              return _buildCircularIndicator();
            } else if (state is SuccessState &&
                _favWordsBloc.favWords != null) {
              return _buildListOfFavWords(_favWordsBloc.favWords!);
            }
            return Container();
          },
        ));
  }

  _buildCircularIndicator() => Container(
        child: indicatorCircular(),
      );

  _buildListOfFavWords(List<WordData> words) => ListView.separated(
        itemCount: words.length,
        itemBuilder: (context, index) {
          return ListTile(
            leading: GestureDetector(
                onTap: () => getAudio(words[index].audio),
                child: Icon(
                  Icons.volume_up_rounded,
                  color: greyColor(),
                  size: 20,
                )),
            title: Text(
              toBeginningOfSentenceCase(words[index].word)!,
            ),
            trailing: GestureDetector(
              onTap: () {
                _favWordsBloc.add(DeleteFavWordsEvent(word: words[index]));
                _favWords!.remove(words[index]);
              },
              child: Icon(
                Icons.delete_outlined,
                color: greyColor(),
                size: 20,
              ),
            ),
          );
        },
        separatorBuilder: (BuildContext context, int index) {
          return Container(
            height: 1,
            color: redColor().withOpacity(0.2),
          );
        },
      );
}
