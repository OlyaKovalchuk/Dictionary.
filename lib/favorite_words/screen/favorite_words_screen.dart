import 'package:Dictionary/audio_fun.dart';
import 'package:Dictionary/cards/card_bloc/word_card_bloc.dart';
import 'package:Dictionary/cards/card_bloc/word_card_event.dart';
import 'package:Dictionary/cards/repository/word_data.dart';
import 'package:Dictionary/cards/widgets/cards.dart';
import 'package:Dictionary/cards/views/error_view.dart';
import 'package:Dictionary/favorite_words/bloc/favorite_words_bloc.dart';
import 'package:Dictionary/favorite_words/bloc/favorite_words_event.dart';
import 'package:Dictionary/favorite_words/bloc/favorite_words_state.dart';
import 'package:Dictionary/favorite_words/model/words_model.dart';
import 'package:Dictionary/favorite_words/service/favorite_words_service.dart';
import 'package:Dictionary/widgets/cardDecoration/indicator_decoration.dart';
import 'package:Dictionary/widgets/colors/grey_color.dart';
import 'package:Dictionary/widgets/colors/red_color.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:swipable_stack/swipable_stack.dart';

class FavoriteWordsScreen extends StatefulWidget {
  @override
  State<FavoriteWordsScreen> createState() => _FavoriteWordsScreenState();
}

class _FavoriteWordsScreenState extends State<FavoriteWordsScreen> {
  final FavWordsBloc _favWordsBloc = FavWordsBloc(FavWordsServiceImpl());

  WordCardBloc wordBloc = WordCardBloc(
      repository: Repository(), favWordsService: FavWordsServiceImpl());

  late SwipableStackController _controller;

  @override
  void initState() {
    super.initState();
    _controller = SwipableStackController();
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: BlocBuilder(
          bloc: _favWordsBloc..add(GetFavWordsEvent()),
          builder: (BuildContext context, state) {
            if (state is LoadingState) {
              return _buildCircularIndicator();
            } else if (state is SuccessState) {
              if (_favWordsBloc.favWords!.isEmpty) {
                return Container(
                  width: double.infinity,
                  height: double.infinity,
                  child: Center(
                    child: Text(
                      "You don't have favorite words yet!",
                      style: TextStyle(color: greyColor()),
                    ),
                  ),
                );
              } else {
                return _buildListOfFavWords(_favWordsBloc.favWords!);
              }
            }
            return errorView();
          }),
    );
  }

  _buildCircularIndicator() => Container(
        child: indicatorCircular(),
      );

  _buildListOfFavWords(s) => ListView.separated(
        scrollDirection: Axis.vertical,
        shrinkWrap: true,
        physics: NeverScrollableScrollPhysics(),
        itemCount: _favWordsBloc.favWords!.length,
        itemBuilder: (context, index) {
          return ListTile(
            leading: GestureDetector(
                onTap: () => getAudio(_favWordsBloc.favWords![index].audio),
                child: Icon(
                  Icons.volume_up_rounded,
                  color: greyColor(),
                  size: 20,
                )),
            title: GestureDetector(
              onTap: () {
                wordBloc.add(WordSwipeFavWords(_favWordsBloc.favWords!));
                int ind = _favWordsBloc.favWords!
                    .indexOf(_favWordsBloc.favWords![index]);
                print(ind);

                for (int i = 0; i < ind; i++) {
                  WordData word = WordData(
                      word: _favWordsBloc.favWords![0].word,
                      audio: _favWordsBloc.favWords![0].audio);
                  _favWordsBloc.favWords!.remove(_favWordsBloc.favWords![0]);
                  _favWordsBloc.favWords!.add(word);
                }
                _buildDialog(buildCards(
                    WordSwipeFavWords(_favWordsBloc.favWords!),
                    wordBloc,
                    _controller));
              },
              child: Text(
                toBeginningOfSentenceCase(_favWordsBloc.favWords![index].word)!,
              ),
            ),
            trailing: GestureDetector(
              onTap: () {
                _favWordsBloc.add(
                    DeleteFavWordsEvent(word: _favWordsBloc.favWords![index]));
                _favWordsBloc.favWords!.remove(_favWordsBloc.favWords![index]);
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

  _buildDialog(Widget child) => showDialog<void>(
      barrierColor: Colors.black26,
      context: context,
      barrierDismissible: true,
      builder: (BuildContext context) {
        return Dialog(
            insetPadding: EdgeInsets.only(
                bottom: MediaQuery.of(context).size.height / 5,
                left: 30,
                right: 30),
            backgroundColor: Colors.transparent,
            child: Container(
                width: double.infinity,
                height: MediaQuery.of(context).size.height / 1.7,
                child: child));
      });
}
