import 'package:Dictionary/utils/audio_fun.dart';
import 'package:Dictionary/authentication/widgets/textFields.dart';
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
import 'package:Dictionary/search/search_bloc/word_search_bloc.dart';
import 'package:Dictionary/search/search_bloc/word_search_event.dart';
import 'package:Dictionary/search/search_bloc/word_search_states.dart';
import 'package:Dictionary/widgets/cardDecoration/indicator_decoration.dart';
import 'package:Dictionary/widgets/colors/grey_color.dart';
import 'package:Dictionary/widgets/colors/red_color.dart';
import 'package:Dictionary/widgets/gradientColor/gradient_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:swipable_stack/swipable_stack.dart';

class FavoriteWordsScreen extends StatefulWidget {
  @override
  State<FavoriteWordsScreen> createState() => _FavoriteWordsScreenState();
}

class _FavoriteWordsScreenState extends State<FavoriteWordsScreen> {
  WordCardBloc wordBloc = WordCardBloc(
      repository: Repository(), favWordsService: FavWordsServiceImpl());
  WordSearchBloc _wordSearchBloc = WordSearchBloc(repository: Repository());
  late SwipableStackController _controller;

  @override
  void initState() {
    super.initState();
    _controller = SwipableStackController();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: _addWordButton(),
      body: SingleChildScrollView(
        child: BlocBuilder(
            bloc: BlocProvider.of<FavWordsBloc>(context)..add(GetFavWordsEvent()),
            builder: (BuildContext context, state) {
              if (state is LoadingState) {
                return _buildCircularIndicator();
              } else if (state is SuccessState) {
                if (BlocProvider.of<FavWordsBloc>(context).favWords!.isEmpty) {
                  return Container(
                    width: MediaQuery.of(context).size.width,
                    height: MediaQuery.of(context).size.height,
                    child: Center(
                      child: Text(
                        "You don't have favorite words yet!",
                        style: TextStyle(color: greyColor()),
                      ),
                    ),
                  );
                } else {
                  return _buildListOfFavWords(BlocProvider.of<FavWordsBloc>(context).favWords!);
                }
              }
              return errorView();
            }),
      ),
    );
  }

  _buildCircularIndicator() => Container(
        child: indicatorCircular(),
      );

  _buildListOfFavWords(s) => ListView.separated(
        scrollDirection: Axis.vertical,
        shrinkWrap: true,
        physics: NeverScrollableScrollPhysics(),
        itemCount: BlocProvider.of<FavWordsBloc>(context).favWords!.length,
        itemBuilder: (context, index) {
          return ListTile(
            leading: GestureDetector(
                onTap: () => getAudio(BlocProvider.of<FavWordsBloc>(context).favWords![index].audio),
                child: Icon(
                  Icons.volume_up_rounded,
                  color: greyColor(),
                  size: 20,
                )),
            title: GestureDetector(
              onTap: () {
                List<WordData> words = BlocProvider.of<FavWordsBloc>(context).favWords!;
                wordBloc.add(WordSwipeFavWords(BlocProvider.of<FavWordsBloc>(context).favWords!));
                int ind = BlocProvider.of<FavWordsBloc>(context).favWords!
                    .indexOf(BlocProvider.of<FavWordsBloc>(context).favWords![index]);

                for (int i = 0; i < ind; i++) {
                  WordData word = WordData(
                      word: BlocProvider.of<FavWordsBloc>(context).favWords![0].word,
                      audio: BlocProvider.of<FavWordsBloc>(context).favWords![0].audio);
                  words.remove(BlocProvider.of<FavWordsBloc>(context).favWords![0]);
                  words.add(word);
                }
                _buildDialog(buildCards(
                    WordSwipeFavWords(words), wordBloc, _controller));
              },
              child: Text(
                toBeginningOfSentenceCase(BlocProvider.of<FavWordsBloc>(context).favWords![index].word)!,
              ),
            ),
            trailing: GestureDetector(
              onTap: () {
                BlocProvider.of<FavWordsBloc>(context).add(
                    DeleteFavWordsEvent(word: BlocProvider.of<FavWordsBloc>(context).favWords![index]));
                BlocProvider.of<FavWordsBloc>(context).favWords!.remove(BlocProvider.of<FavWordsBloc>(context).favWords![index]);
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
      builder: (BuildContext context) {
        return Dialog(
            insetPadding: EdgeInsets.only(
                top: MediaQuery.of(context).size.height / 7,
                left: 30,
                right: 30),
            backgroundColor: Colors.transparent,
            child: child);
      });

  _addWordButton() => Padding(
        padding: const EdgeInsets.only(bottom: 85.0),
        child: GestureDetector(
          child: Container(
            width: 50,
            height: 50,
            decoration: BoxDecoration(
              boxShadow: [BoxShadow(spreadRadius: 1, blurRadius: 7, color: Colors.grey, offset: Offset(0,3)),],
              borderRadius: BorderRadius.circular(30),
              gradient: gradientColor(),
            ),
            child: Icon(
              Icons.add,
              color: Colors.white,
            ),
          ),
          onTap: () {
            _buildDialogAddWord();
          },
        ),
      );

  _buildDialogAddWord() => showDialog(
      barrierDismissible: false,
      context: context,
      builder: (context) {
        final textController = TextEditingController();
        return BlocBuilder(
          bloc: _wordSearchBloc,
          builder: (_, state) {
            return AlertDialog(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(Radius.circular(25.0))),
              title: Text(
                'Add word to list',
                style: TextStyle(
                    fontFamily: ('Futura'),
                    fontWeight: FontWeight.bold,
                    foreground: Paint()
                      ..shader = gradientColor()
                          .createShader(Rect.fromLTWH(0.0, 0.0, 200.0, 70.0))),
                textAlign: TextAlign.center,
              ),
              content: buildTextField(
                validator: (val) {
                  if (BlocProvider.of<FavWordsBloc>(context).favWords!
                      .map((e) => e.word)
                      .toList()
                      .contains(textController.text)) {
                    return 'List contains this word';
                  }
                },
                controller: textController,
                textInputType: TextInputType.text,
                hint: 'word',
              ),
              actions: [
                TextButton(
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                    child: Text(
                      'Cancel',
                      style: TextStyle(color: greyTextColor()),
                    )),
                TextButton(
                    onPressed: () {
                      _wordSearchBloc
                          .add(WordSearch(word: textController.text));
                      if (state is WordSearchLoading) {
                        return _buildCircularIndicator();
                      } else if (state is WordSearchLoaded) {
                        WordData word = WordData(
                            word: state.response.word,
                            audio: state.response.phonetics?.first.audio);
                        if (!BlocProvider.of<FavWordsBloc>(context).favWords!.contains(word)) {
                          BlocProvider.of<FavWordsBloc>(context).add(AddToFavWordsEvent(word: word));
                          BlocProvider.of<FavWordsBloc>(context).add(GetFavWordsEvent());
                          return Navigator.of(context).pop();
                        }
                      }
                    },
                    child: Text(
                      'ADD',
                      style: TextStyle(color: redColor()),
                    )),
              ],
            );
          },
        );
      });
}
