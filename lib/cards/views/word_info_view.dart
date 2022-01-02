import 'package:Dictionary/cards/model/search_response.dart';
import 'package:Dictionary/theme/theme_colors.dart';
import 'package:flutter/material.dart';

Widget wordInfo(SearchResponse response, [Color? color]) => ListView.builder(
    scrollDirection: Axis.vertical,
    shrinkWrap: true,
    itemCount: response.meanings.length,
    itemBuilder: (BuildContext context, int index) => ListBody(
          children: [
            Column(
              mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start, children: [
              SizedBox(
                height: 10,
              ),
              titleWord(response.meanings[index].partOfSpeech, context, color),
            ]),
            SizedBox(
              height: 10,
            ),
            Padding(
              padding: EdgeInsets.only(left: 20, right: 20),
              child: Text(response.meanings[index].definitions[0].definition,
                  style: Theme.of(context).textTheme.bodyText1),
            )
          ],
        ));

Widget titleWord(String partOfSpeech, BuildContext context, [Color? color])=> Container(
    alignment: Alignment.centerLeft,
    height: 30,
    width: double.infinity,
    color: color ?? greyToWhite,
    child: Padding(
      padding: EdgeInsets.only(left: 20, right: 20),
      child: Text(
        partOfSpeech,
        textAlign: TextAlign.left,
        style: Theme.of(context).textTheme.subtitle2
      ),
    ));