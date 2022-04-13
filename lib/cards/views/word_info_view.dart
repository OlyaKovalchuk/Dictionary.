import 'package:Dictionary/cards/model/search_response.dart';
import 'package:Dictionary/theme/theme_colors.dart';
import 'package:flutter/material.dart';

class BackCard extends StatelessWidget {
  final SearchResponse response;
  final Color? color;

  BackCard({Key? key, required this.response, this.color}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
        scrollDirection: Axis.vertical,
        shrinkWrap: true,
        itemCount: response.meanings.length,
        itemBuilder: (BuildContext context, int index) => ListBody(
              children: [
                Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(
                        height: 10,
                      ),
                      TitleWord(color,
                          partOfSpeech: response.meanings[index].partOfSpeech),
                    ]),
                SizedBox(
                  height: 10,
                ),
                Padding(
                  padding: EdgeInsets.only(left: 20, right: 20),
                  child: Text(
                      response.meanings[index].definitions[0].definition,
                      style: Theme.of(context).textTheme.bodyText1),
                )
              ],
            ));
  }
}

class TitleWord extends StatelessWidget {
  final String partOfSpeech;
  final Color? color;

  TitleWord(this.color, {Key? key, required this.partOfSpeech})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
        alignment: Alignment.centerLeft,
        height: 30,
        width: double.infinity,
        color: color ?? greyToWhite,
        child: Padding(
          padding: EdgeInsets.only(left: 20, right: 20),
          child: Text(partOfSpeech,
              textAlign: TextAlign.left,
              style: Theme.of(context).textTheme.subtitle2),
        ));
  }
}
