import 'package:Dictionary/model/search_response.dart';
import 'package:Dictionary/widgets/gradientColor/gradient_widget.dart';
import 'package:Dictionary/widgets/textDecoration/text_styles.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

Widget infoListBuilder(SearchResponse response) => ListView.builder(
    scrollDirection: Axis.vertical,
    shrinkWrap: true,
    itemCount: response.meanings.length,
    itemBuilder: (BuildContext context, int index) => ListBody(
          children: [
            Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              SizedBox(
                height: 10,
              ),
              Container(
                  alignment: Alignment.centerLeft,
                  height: 30,
                  width: double.infinity,
                  color: Color.fromRGBO(247, 247, 247, 1),
                  child: Padding(
                    padding: EdgeInsets.only(left: 20, right: 20),
                    child: Text(
                      response.meanings[index].partOfSpeech,
                      textAlign: TextAlign.left,
                      style: TextStyle(
                        fontFamily: ('Futura'),
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        foreground: Paint()
                          ..shader = gradientColor().createShader(
                              Rect.fromLTWH(0.0, 0.0, 200.0, 70.0)),
                      ),
                    ),
                  )),
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
