import 'package:dictionary/cards/model/search_response.dart';
import 'package:dictionary/widgets/textDecoration/text_styles.dart';
import 'package:dictionary/widgets/textDecoration/title_text.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

Widget wordInfo(SearchResponse response) => ListView.builder(
    scrollDirection: Axis.vertical,
    shrinkWrap: true,
    itemCount: response.meanings.length,
    itemBuilder: (BuildContext context, int index) => ListBody(
          children: [
            Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              SizedBox(
                height: 10,
              ),
              titleWord(response.meanings[index].partOfSpeech),
            ]),
            SizedBox(
              height: 10,
            ),
            Padding(
              padding: EdgeInsets.only(left: 20, right: 20),
              child: Text(response.meanings[index].definitions[0].definition,
                  style: plainTextStyle()),
            )
          ],
        ));
