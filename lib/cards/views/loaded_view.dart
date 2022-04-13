import 'package:Dictionary/cards/widgets/card_decoration/card_decoration.dart';
import 'package:Dictionary/utils/audio_fun.dart';
import 'package:Dictionary/cards/model/search_response.dart';
import 'package:Dictionary/favorite_words/model/words_model.dart';
import 'package:Dictionary/favorite_words/widgets/fav_button.dart';
import 'package:Dictionary/theme/theme_colors.dart';
import 'package:flip_card/flip_card.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'word_info_view.dart';

class LoadedView extends StatelessWidget {
  final SearchResponse response;
  final bool isFavorite;

  LoadedView({Key? key, required this.response, required this.isFavorite})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FlipCard(
      alignment: Alignment.topLeft,
      direction: FlipDirection.HORIZONTAL,
      front: CardsFrame(
        child: FrontCards(
          response: response,
          isFavorite: isFavorite,
        ),
      ),
      back: CardsFrame(
          child: Column(mainAxisSize: MainAxisSize.min, children: [
        WordWidget(
          word: response.word,
        ),
        BackCard(
          response: response,
        ),
      ])),
    );
  }
}

class FrontCards extends StatelessWidget {
  final SearchResponse response;
  final bool isFavorite;

  FrontCards({Key? key, required this.response, required this.isFavorite})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: EdgeInsets.all(20),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            FavoriteWordsButton(
              word: WordData(
                  word: response.word,
                  audio: response.phonetics?[0].audio ?? ''),
              isFavorited: isFavorite,
            ),
            WordWidget(word: response.word),
            TranscriptionAndAudio(
              phonetics: response.phonetics ?? [],
            ),
            const SizedBox(
              height: 30,
            ),
            ExampleText(
                example:
                    response.meanings.first.definitions.first.example ?? ''),
            const SizedBox(
              height: 60,
            ),
            SynonymsChips(
                synonyms:
                    response.meanings.first.definitions.first.synonyms ?? []),
          ],
        ));
  }
}

class WordWidget extends StatelessWidget {
  final String word;

  const WordWidget({
    Key? key,
    required this.word,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: const EdgeInsets.only(
          top: 30,
        ),
        child: Center(
          child: Text(
            word,
            style: Theme.of(context).textTheme.subtitle1,
          ),
        ));
  }
}

class TranscriptionAndAudio extends StatelessWidget {
  final List<Phonetics> phonetics;

  TranscriptionAndAudio({Key? key, required this.phonetics}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    String? audio;
    String? text;
    if (phonetics.isNotEmpty) {
      audio = phonetics.first.audio ?? '';
      text = phonetics.first.text ?? '';
    }
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      mainAxisSize: MainAxisSize.max,
      children: [
        Visibility(
            visible: audio!.isNotEmpty,
            child: IconButton(
                onPressed: () {
                  getAudio(audio);
                },
                icon: Icon(
                  Icons.volume_up,
                  size: 20,
                  color: greyDarkColor,
                ))),
        Visibility(
            visible: text!.isNotEmpty,
            child: Text(
              '[ ' + (text) + ' ]',
              style: Theme.of(context).textTheme.bodyText1,
            ))
      ],
    );
  }
}

class ExampleText extends StatelessWidget {
  final String example;

  ExampleText({Key? key, required this.example}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Visibility(
        visible: example.isNotEmpty,
        child: Center(
          child: Text(
            toBeginningOfSentenceCase(example)!,
            style: Theme.of(context).textTheme.bodyText1,
          ),
        ));
  }
}

class SynonymsChips extends StatelessWidget {
  final List<String> synonyms;

  SynonymsChips({Key? key, required this.synonyms}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Align(
        alignment: Alignment.topLeft,
        child: Visibility(
            visible: synonyms.isNotEmpty,
            child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Text(
                    'synonyms: ',
                    style: Theme.of(context)
                        .textTheme
                        .bodyText1!
                        .copyWith(fontSize: 12, color: redColor),
                  ),
                  Wrap(
                    spacing: 5.0,
                    children: synonyms
                        .take(4)
                        .map(
                          (synonym) => Chip(
                              backgroundColor: Colors.white,
                              side: BorderSide(color: redColor),
                              label: Text(synonym,
                                  style: Theme.of(context)
                                      .textTheme
                                      .bodyText1!
                                      .copyWith(color: redColor))),
                        )
                        .toList(),
                  )
                ])));
  }
}
