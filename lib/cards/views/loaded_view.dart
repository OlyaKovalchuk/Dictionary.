import 'package:Dictionary/cards/widgets/cardDecoration/card_decoration.dart';
import 'package:Dictionary/utils/audio_fun.dart';
import 'package:Dictionary/cards/model/search_response.dart';
import 'package:Dictionary/cards/utils/string_utils.dart';
import 'package:Dictionary/favorite_words/model/words_model.dart';
import 'package:Dictionary/favorite_words/widgets/fav_button.dart';
import 'package:Dictionary/theme/theme_colors.dart';
import 'package:flip_card/flip_card.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'word_info_view.dart';

Widget loadedView(
    SearchResponse response, BuildContext context, bool isFavorited) {
  return FlipCard(
    direction: FlipDirection.HORIZONTAL,
    front: cardDecoration(
        context: context,
        child: Padding(
          padding: EdgeInsets.all(20),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Align(
                  alignment: Alignment.centerRight,
                  child: FavoriteWordsButton(
                    word: WordData(
                        word: response.word,
                        audio: response.phonetics?[0].audio ?? ''),
                    isFavorited: isFavorited,
                  )),
              _buildWord(response.word, context),
              _buildPhonetics(response.phonetics ?? [], context),
              SizedBox(
                height: 30,
              ),
              Visibility(
                visible: response.meanings[0].definitions[0].example != null,
                child: _buildVisibilityExample(
                    response.meanings[0].definitions[0].example ?? '', context),
              ),
              SizedBox(
                height: 60,
              ),
              _synonymsView(response.meanings[0].definitions[0].synonyms ?? [],
                  response, context),
            ],
          ),
        )),
    back: cardDecoration(
        context: context,
        child: Column(mainAxisSize: MainAxisSize.min, children: [
          Padding(
            padding: EdgeInsets.only(
              top: 30,
            ),
            child: _buildWord(response.word, context),
          ),
          wordInfo(response),
        ])),
  );
}

Widget _synonymsView(
        List<String> synonyms, SearchResponse response, BuildContext context) =>
    Visibility(
        visible: synonyms.isNotEmpty,
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Text(
            'synonyms: ',
            style: Theme.of(context)
                .textTheme
                .bodyText1!
                .copyWith(fontSize: 12, color: redColor),
          ),
          Wrap(
            spacing: 5.0,
            // runSpacing: 4.0,
            children: _synonymChips(response, synonyms, context),
          )
        ]));

List<Widget> _synonymChips(
        SearchResponse response, List<String> synonyms, BuildContext context) =>
    synonyms
        .take(4)
        .map((synonym) => GestureDetector(
              onTap: () {
                if (isSingleWord(synonym)) {
                  //   wordBloc.add(SynonymTapped(synonym: synonym));
                }
              },
              child: Chip(
                  backgroundColor: Colors.white,
                  side: BorderSide(color: redColor),
                  label: Text(synonym,
                      style: Theme.of(context)
                          .textTheme
                          .bodyText1!
                          .copyWith(color: redColor))),
            ))
        .toList();

Widget _buildWord(String word, BuildContext context) => Center(
      child: Text(
        word,
        style: Theme.of(context).textTheme.subtitle1,
      ),
    );

Widget _buildPhonetics(List<Phonetics> phonetics, BuildContext context) {
  String? audio;
  String? text;

  if (phonetics.isNotEmpty) {
    audio = phonetics.first.audio;
    text = phonetics.first.text;
  }

  return Row(
    mainAxisAlignment: MainAxisAlignment.center,
    mainAxisSize: MainAxisSize.max,
    children: [
      Visibility(
          visible: audio != null,
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
          visible: text != null,
          child: Text(
            '[ ' + (text ?? ' ') + ' ]',
            style: Theme.of(context).textTheme.bodyText1,
          ))
    ],
  );
}

_buildVisibilityExample(String? example, BuildContext context) => Center(
      child: Text(
        toBeginningOfSentenceCase(example)!,
        style: Theme.of(context).textTheme.bodyText1,
      ),
    );
