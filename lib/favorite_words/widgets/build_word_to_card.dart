import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:swipable_stack/swipable_stack.dart';

import '../../cards/bloc/card_bloc.dart';
import '../../cards/bloc/card_event.dart';
import '../../cards/repository/word_data.dart';
import '../../cards/widgets/cards.dart';
import '../bloc/favorite_words_bloc.dart';
import '../model/words_model.dart';
import '../service/favorite_words_service.dart';
import 'show_dialog.dart';

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
