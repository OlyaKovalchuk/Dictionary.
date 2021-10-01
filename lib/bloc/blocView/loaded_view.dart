import 'package:Dictionary/bloc/word_bloc.dart';
import 'package:Dictionary/model/search_response.dart';
import 'package:Dictionary/widgets/cardDecoration/card_decoration.dart';
import 'package:Dictionary/widgets/colors/grey_color.dart';
import 'package:Dictionary/widgets/colors/red_color.dart';
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
              front: cardDecoration(
                  child: Padding(
                      padding: EdgeInsets.only(
                          left: 10, right: 10, top: 30, bottom: 30),
                      child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Column(children: [
                              Text(
                                word,
                                style: titleTextStyle(),
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                mainAxisSize: MainAxisSize.max,
                                children: [
                                  IconButton(
                                      onPressed: () {},
                                      icon: Icon(
                                        Icons.volume_up,
                                        size: 20,
                                        color: greyColor(),
                                      )),
                                  Text(
                                    '[ ' + response.phonetics[0].text + ' ]',
                                    style: plainTextStyle(),
                                  ),
                                ],
                              )
                            ]),
                            Visibility(
                              visible:
                                  response.meanings[0].definitions[0].example !=
                                      null,
                              child: Text(
                                response.meanings[0].definitions[0].example ??
                                    '',
                                style: plainTextStyle(),
                              ),
                            ),
                            synonymsView(
                                response.meanings[0].definitions[0].synonyms ??
                                    []),
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
                  ),
                ),
                Expanded(child: infoListBuilder(response))
              ]))),
        ]));

Widget synonymsView(List<String> synonyms) => Visibility(
    visible: synonyms.isNotEmpty,
    child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'synonyms: ',
            style: GoogleFonts.roboto(fontSize: 12, color: redColor()),
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
        side: BorderSide(color: redColor()),
        label: Text(
          synonym,
          style: TextStyle(
            fontSize: 15,
            color: redColor(),
          ),
        )))
    .toList();

// IconButton _isFavoriteButton(bool isFavorite) => IconButton(onPressed: (){
//   Navigator.push(context, MaterialPageRoute(builder: (context)))
// }, icon: icon)
