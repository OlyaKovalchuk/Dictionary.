import 'package:Dictionary/bloc/word_bloc.dart';
import 'package:Dictionary/model/search_response.dart';
import 'package:Dictionary/widgets/cardDecoration/card_decoration.dart';
import 'package:Dictionary/widgets/textDecoration/text_styles.dart';
import 'package:flip_card/flip_card.dart';
import 'package:flutter/material.dart';

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
                      padding: EdgeInsets.only(top: 30, bottom: 20),
                      child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
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
                            Text(
                              '[ ' + response.phonetics[0].text + ' ]',
                              style: plainTextStyle(),
                            ),
                            SizedBox(
                              height: 50,
                            ),
                            Text(
                              response.meanings[0].definitions[0].example,
                              style: plainTextStyle(),
                              textAlign: TextAlign.left,
                            ),
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
