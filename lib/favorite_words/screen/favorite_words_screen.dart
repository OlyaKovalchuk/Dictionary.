import 'package:Dictionary/audio_fun.dart';
import 'package:Dictionary/cards/card_bloc/word_card_bloc.dart';
import 'package:Dictionary/cards/card_bloc/word_card_event.dart';
import 'package:Dictionary/cards/card_bloc/word_card_states.dart';
import 'package:Dictionary/cards/repository/word_data.dart';
import 'package:Dictionary/cards/views/error_view.dart';
import 'package:Dictionary/cards/views/loaded_view.dart';
import 'package:Dictionary/cards/views/loading_view.dart';
import 'package:Dictionary/favorite_words/bloc/favorite_words_bloc.dart';
import 'package:Dictionary/favorite_words/bloc/favorite_words_event.dart';
import 'package:Dictionary/favorite_words/bloc/favorite_words_state.dart';
import 'package:Dictionary/favorite_words/model/words_model.dart';
import 'package:Dictionary/favorite_words/service/favorite_words_service.dart';
import 'package:Dictionary/widgets/appBar.dart';
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
    return Scaffold(
        appBar: buildAppBar(title: 'Favorite Words', actions: [
          _buildWordsToCard(context),
        ]),
        body: BlocBuilder(
            bloc: _favWordsBloc..add(GetFavWordsEvent()),
            builder: (BuildContext context, state) {
              if (state is LoadingState) {
                return _buildCircularIndicator();
              } else if (state is SuccessState) {
                if (_favWordsBloc.favWords == null) {
                  return Container(
                    child: Center(
                      child: Text(
                        "You don't have favorite words yet!",
                        style: TextStyle(color: greyColor()),
                      ),
                    ),
                  );
                }
                return _buildListOfFavWords(_favWordsBloc.favWords!);
              }
              return errorView();
            }));
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
                _favWordsBloc.favWords!.remove(words[index]);
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

  _buildWordsToCard(BuildContext context) => Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10.0),
        child: GestureDetector(
          onTap: () {
            wordBloc.add(WordSwipeFavWords(_favWordsBloc.favWords));
            _buildDialog(_buildCards());
          },
          child: Icon(
            Icons.content_copy_outlined,
            color: Colors.white,
          ),
        ),
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
            child: child);
      });

  _buildCards() => Container(
        width: double.infinity,
        height: MediaQuery.of(context).size.height / 1.7,
        child: BlocBuilder<WordCardBloc, WordCardStackState>(
          bloc: wordBloc,
          builder: (context, wordStackState) {
            return SwipableStack(
                controller: _controller,
                stackClipBehaviour: Clip.none,
                onSwipeCompleted: (index, direction) {
                  wordBloc.add(WordSwipeFavWords(_favWordsBloc.favWords));
                },
                builder: (BuildContext context, int index,
                    BoxConstraints constraints) {
                  if (index >= wordStackState.wordCardStates.length) {
                    return loadingView(context);
                  }
                  WordCardState wordState =
                      wordStackState.wordCardStates[index];

                  if (wordState is Error) {
                    return errorView();
                  }
                  if (wordState is Loading) {
                    return loadingView(context);
                  }
                  if (wordState is Ready) {
                    return loadedView(
                        wordState.word, context, wordState.isFavorited);
                  }
                  return loadingView(context);
                });
          },
        ),
      );
}
