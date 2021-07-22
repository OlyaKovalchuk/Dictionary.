import 'dart:ui';
import 'package:Dictionary/bloc/word_bloc.dart';
import 'package:Dictionary/model/search_response.dart';
import 'package:Dictionary/widgets/cardDecoration/card_decoration.dart';
import 'package:Dictionary/widgets/textDecoration/text_styles.dart';
import 'package:flip_card/flip_card.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'listBuilder_info.dart';

Widget loadedView(SearchResponse response, WordBloc wordBloc, String word) =>
    Padding(
        padding: EdgeInsets.all(35),
        child: Column(children: [
          FlipCard(
              direction: FlipDirection.HORIZONTAL,
              // default
              front: cardDecoration(
                  child: Padding(
                      padding: EdgeInsets.only(top: 30, bottom: 10),
                      child: Column(children: [
                        Text(
                          word,
                          style: TextStyle(
                              fontFamily: 'Futura',
                              fontSize: 35,
                              color: Color.fromRGBO(91, 91, 91, 1)),
                          textAlign: TextAlign.center,
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            IconButton(
                                onPressed: () {},
                                icon: Icon(
                                  Icons.volume_up,
                                  size: 20,
                                  color: Color.fromRGBO(91, 91, 91, 1),
                                )),
                            Text(
                              '[ ' + response.phonetics[0].text + ' ]',
                              style: plainTextStyle(),
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 50,
                        ),
                        Padding(
                          padding: EdgeInsets.all(15),
                          child: Visibility(
                            visible:
                                response.meanings[0].definitions[0].example !=
                                    null,
                            child: Text(
                              response.meanings[0].definitions[0].example ?? '',
                              style: plainTextStyle(),
                              textAlign: TextAlign.left,
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        synonymsView(
                            response.meanings[0].definitions[0].synonyms ?? []),
                      ]))),
              back: cardDecoration(
                  child: Column(children: [
                Padding(
                  padding: EdgeInsets.only(
                    top: 30,
                  ),
                  child: Text(
                    word,
                    style: titleTextStyle(),
                    textAlign: TextAlign.center,
                  ),
                ),
                Expanded(child: infoListBuilder(response))
              ]))),
        ]));

Widget synonymsView(List<String> synonyms) => Visibility(
    visible: synonyms.isNotEmpty,
    child: Column(children: [
      Text(
        'synonyms: ',
        style: GoogleFonts.roboto(
            fontSize: 12, color: Color.fromRGBO(223, 78, 80, 1)),
        textAlign: TextAlign.left,
      ),
      Wrap(
        spacing: 8.0,
        runSpacing: 4.0,
        children: synonymChips(synonyms),
      )
    ]));

List<Widget> synonymChips(List<String> synonyms) => synonyms
    .take(5)
    .map((synonym) => Chip(
        backgroundColor: Colors.white,
        side: BorderSide(color: Color.fromRGBO(223, 78, 80, 1)),
        label: Text(
          synonym,
          style: TextStyle(
            fontSize: 15,
            color: Color.fromRGBO(223, 78, 80, 1),
          ),
        )))
    .toList();
