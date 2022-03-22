import 'package:Dictionary/search/utils/error_output.dart';
import 'package:Dictionary/utils/audio_fun.dart';
import 'package:Dictionary/authentication/widgets/text_fields.dart';
import 'package:Dictionary/cards/bloc/card_bloc.dart';
import 'package:Dictionary/cards/bloc/card_event.dart';
import 'package:Dictionary/cards/repository/word_data.dart';
import 'package:Dictionary/cards/widgets/cards.dart';
import 'package:Dictionary/cards/views/error_view.dart';
import 'package:Dictionary/favorite_words/bloc/favorite_words_bloc.dart';
import 'package:Dictionary/favorite_words/bloc/favorite_words_event.dart';
import 'package:Dictionary/favorite_words/bloc/favorite_words_state.dart';
import 'package:Dictionary/favorite_words/model/words_model.dart';
import 'package:Dictionary/favorite_words/service/favorite_words_service.dart';
import 'package:Dictionary/search/bloc/word_search_bloc.dart';
import 'package:Dictionary/search/bloc/word_search_event.dart';
import 'package:Dictionary/search/bloc/word_search_states.dart';
import 'package:Dictionary/theme/theme_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:swipable_stack/swipable_stack.dart';

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
              return _buildCircularIndicator(context);
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

_buildCircularIndicator(BuildContext context) => Container(
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.height,
      alignment: Alignment.center,
      child: CircularProgressIndicator(color: redColor),
    );

bool isEmptyListFavWords(BuildContext context) =>
    BlocProvider.of<FavWordsBloc>(context).favWords!.isEmpty;

class EmptyView extends StatelessWidget {
  const EmptyView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.height,
      alignment: Alignment.center,
      child: Text(
        "You don't have favorite words yet!",
        style: Theme.of(context).textTheme.bodyText2!.copyWith(fontSize: 15),
      ),
    );
  }
}

class ListFavWordsBuilder extends StatelessWidget {
  final SwipableStackController controller;

  const ListFavWordsBuilder({Key? key, required this.controller})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      scrollDirection: Axis.vertical,
      shrinkWrap: true,
      itemCount: BlocProvider.of<FavWordsBloc>(context).favWords!.length,
      itemBuilder: (context, index) {
        return ListTile(
            leading: AudioReproducer(index: index),
            title: ButtonWordToCard(
              index: index,
              controller: controller,
            ),
            trailing: DeleteWord(index: index));
      },
      separatorBuilder: (BuildContext context, int index) {
        return Container(
          height: 1,
          color: redColor.withOpacity(0.2),
        );
      },
    );
  }
}

class AudioReproducer extends StatelessWidget {
  final int index;

  const AudioReproducer({Key? key, required this.index}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
        onTap: () => getAudio(
            BlocProvider.of<FavWordsBloc>(context).favWords![index].audio),
        child: Icon(
          Icons.volume_up_rounded,
          color: greyDarkColor,
          size: 20,
        ));
  }
}

class ButtonWordToCard extends StatelessWidget {
  final WordCardBloc wordBloc = WordCardBloc(
      repository: Repository(), favWordsService: FavWordsServiceImpl());
  final SwipableStackController controller;
  final int index;

  ButtonWordToCard({Key? key, required this.controller, required this.index})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        List<WordData> words = BlocProvider.of<FavWordsBloc>(context).favWords!;
        wordBloc.add(WordSwipeFavWords(words));

        for (int i = 0; i < index; i++) {
          WordData word = WordData(word: words[0].word, audio: words[0].audio);
          words.remove(words[0]);
          words.add(word);
        }
        showDialog<void>(
            barrierColor: Colors.black26,
            context: context,
            builder: (BuildContext context) {
              return ShowDialog(
                  child: CardsBuilder(
                      event: WordSwipeFavWords(words),
                      wordBloc: wordBloc,
                      controller: controller));
            });
      },
      child: Text(
        toBeginningOfSentenceCase(
            BlocProvider.of<FavWordsBloc>(context).favWords![index].word)!,
        style: Theme.of(context).textTheme.bodyText1!.copyWith(fontSize: 17),
      ),
    );
  }
}

class ShowDialog extends StatelessWidget {
  final Widget child;

  const ShowDialog({Key? key, required this.child}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Dialog(
        elevation: 0,
        insetPadding: EdgeInsets.only(
            top: MediaQuery.of(context).size.height / 7, left: 30, right: 30),
        backgroundColor: Colors.transparent,
        child: child);
  }
}

class DeleteWord extends StatelessWidget {
  final int index;

  DeleteWord({Key? key, required this.index}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        BlocProvider.of<FavWordsBloc>(context).add(DeleteFavWordsEvent(
            word: BlocProvider.of<FavWordsBloc>(context).favWords![index]));
        BlocProvider.of<FavWordsBloc>(context)
            .favWords!
            .remove(BlocProvider.of<FavWordsBloc>(context).favWords![index]);
      },
      child: Icon(
        Icons.delete_outlined,
        color: greyDarkColor,
        size: 20,
      ),
    );
  }
}

class ButtonAddWord extends StatelessWidget {
  const ButtonAddWord({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: const EdgeInsets.only(bottom: 85.0),
        child: GestureDetector(
            child: Container(
              width: 50,
              height: 50,
              decoration: BoxDecoration(
                boxShadow: [
                  BoxShadow(
                      spreadRadius: 1,
                      blurRadius: 7,
                      color: Colors.grey,
                      offset: Offset(0, 3)),
                ],
                borderRadius: BorderRadius.circular(30),
                gradient: gradientColor,
              ),
              child: Icon(
                Icons.add,
                color: Colors.white,
              ),
            ),
            onTap: () {
              showDialog(
                barrierDismissible: false,
                barrierColor: Colors.black26,
                context: context,
                builder: (context) {
                  return DialogAddWordBuilder();
                },
              );
            }));
  }
}

class DialogAddWordBuilder extends StatelessWidget {
  DialogAddWordBuilder({Key? key}) : super(key: key);
  final WordSearchBloc _wordSearchBloc =
      WordSearchBloc(repository: Repository());
  final textController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocBuilder(
      bloc: _wordSearchBloc,
      builder: (_, state) {
        return AlertDialog(
          elevation: 0,
          shape: RoundedRectangleBorder(
              borderRadius: const BorderRadius.all(Radius.circular(25.0))),
          title: Text(
            'Add word to list',
            style: Theme.of(context).textTheme.subtitle2,
            textAlign: TextAlign.center,
          ),
          content: TextFieldBuilder(
            validator: (val) {
              if (BlocProvider.of<FavWordsBloc>(context)
                  .favWords!
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
                  style: TextStyle(color: greyColor),
                )),
            TextButton(
                onPressed: () {
                  _wordSearchBloc.add(WordSearch(word: textController.text));
                  if (state is WordSearchLoading) {
                    return _buildCircularIndicator(context);
                  }
                  if (state is WordSearchLoaded) {
                    _checkContainWord(
                        WordData(
                            word: state.response.word,
                            audio: state.response.phonetics?.first.audio),
                        context);
                  }
                  if (state is WordSearchError) {
                    return errorOutput(
                        error: textController.text == ''
                            ? 'Enter a word'
                            : 'There is no such word in the dictionary',
                        context: context);
                  }
                },
                child:
                    Text('ADD', style: Theme.of(context).textTheme.subtitle2)),
          ],
        );
      },
    );
  }
}

_checkContainWord(WordData word, BuildContext context) async {
  var favWords = BlocProvider.of<FavWordsBloc>(context);
  if (!favWords.favWords!.contains(word)) {
    favWords.add(AddToFavWordsEvent(word: word));
    favWords.add(GetFavWordsEvent());
    await _close(context);
  } else if (favWords.favWords!.contains(word)) {
    errorOutput(error: 'This word is already added', context: context);
  }
}

_close(BuildContext context) {
  Navigator.pop(context);
}
