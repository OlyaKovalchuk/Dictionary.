import 'package:dictionary/audio_fun.dart';
import 'package:dictionary/cards/card_bloc/word_card_bloc.dart';
import 'package:dictionary/cards/model/search_response.dart';
import 'package:dictionary/cards/utils/string_utils.dart';
import 'package:dictionary/favorite_words/model/words_model.dart';
import 'package:dictionary/favorite_words/screen/fav_button.dart';
import 'package:dictionary/widgets/cardDecoration/card_decoration.dart';
import 'package:dictionary/widgets/colors/grey_color.dart';
import 'package:dictionary/widgets/colors/red_color.dart';
import 'package:dictionary/widgets/textDecoration/text_styles.dart';
import 'package:flip_card/flip_card.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'word_info_view.dart';

Widget loadedView(SearchResponse response, WordCardBloc wordBloc,
    BuildContext context, bool isFavorited) {
  return Padding(
    padding: EdgeInsets.all(35),
    child: FlipCard(
        direction: FlipDirection.HORIZONTAL,
        front: cardDecoration(
            context: context,
            child: Padding(
              padding:
                  EdgeInsets.only(left: 20, right: 20, top: 20, bottom: 20),
              child: Column(
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
                  _buildWord(response.word),
                  _buildPhonetics(response.phonetics ?? []),
                  SizedBox(
                    height: 30,
                  ),
                  Visibility(
                    visible:
                        response.meanings[0].definitions[0].example != null,
                    child: _buildVisibilityExample(
                        response.meanings[0].definitions[0].example ?? ''),
                  ),
                  Spacer(),
                  synonymsView(
                      wordBloc,
                      response.meanings[0].definitions[0].synonyms ?? [],
                      response),
                ],
              ),
            )),
        back: cardDecoration(
            context: context,
            child: Column(children: [
              Padding(
                padding: EdgeInsets.only(
                  top: 30,
                ),
                child: _buildWord(response.word),
              ),
              Expanded(child: wordInfo(response))
            ]))),
  );
}

Widget synonymsView(WordCardBloc wordBloc, List<String> synonyms,
        SearchResponse response) =>
    Visibility(
        visible: synonyms.isNotEmpty,
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Text(
            'synonyms: ',
            style: GoogleFonts.roboto(
              fontSize: 12,
              color: redColor(),
            ),
          ),
          Wrap(
            spacing: 5.0,
            // runSpacing: 4.0,
            children: synonymChips(wordBloc, response, synonyms),
          )
        ]));

List<Widget> synonymChips(WordCardBloc wordBloc, SearchResponse response,
        List<String> synonyms) =>
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
                  side: BorderSide(color: redColor()),
                  label: Text(
                    synonym,
                    style: TextStyle(
                      fontSize: 15,
                      color: redColor(),
                    ),
                  )),
            ))
        .toList();

Widget _buildWord(String word) => Center(
      child: Text(
        word,
        style: titleTextStyle(),
      ),
    );

Widget _buildPhonetics(List<Phonetics> phonetics) {
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
                color: greyColor(),
              ))),
      Visibility(
          visible: text != null,
          child: Text(
            '[ ' + (text ?? ' ') + ' ]',
            style: TextStyle(fontSize: 15, color: greyColor()),
          ))
    ],
  );
}



_buildVisibilityExample(String? example) => Center(
      child: Text(
        toBeginningOfSentenceCase(example)!,
        style: plainTextStyle(),
      ),
    );
