import 'dart:async';
import 'package:Dictionary/bloc/FetchWordEvent.dart';
import 'package:Dictionary/bloc/word_bloc.dart';
import 'package:Dictionary/bloc/word_states.dart';
import 'package:Dictionary/model/search_response.dart';
import 'package:Dictionary/widgets/boxDecoration_Container.dart';
import 'package:Dictionary/widgets/gradient_widget.dart';
import 'package:flip_card/flip_card.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:random_words/random_words.dart';
import 'package:swipedetector/swipedetector.dart';
import 'package:Dictionary/service/definition.api.dart';
import 'package:bloc/bloc.dart';

class DictionaryHome extends StatefulWidget {
  const DictionaryHome({Key? key}) : super(key: key);

  @override
  _DictionaryHomeState createState() => _DictionaryHomeState();
}

class _DictionaryHomeState extends State<DictionaryHome> {
  late WordBloc _wordBloc;

  @override
  void initState() {
    super.initState();
    _wordBloc = WordBloc(dictionaryApi: DictionaryApi());
    _wordBloc.add(FetchWord(word: word));
  }

  late String word = RandomWord();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          automaticallyImplyLeading: false,
          centerTitle: true,
          title: Text('Dictionary.',
              style: TextStyle(
                  fontFamily: ('Futura'),
                  fontSize: 25,
                  fontWeight: FontWeight.bold,
                  color: Colors.white)),
          actions: [
            IconButton(
                onPressed: () {
                  Navigator.of(context).pushNamed('/search');
                },
                icon: Icon(Icons.search))
          ],
          flexibleSpace: GradientLinear(),
        ),
        body: BlocBuilder(
            bloc: _wordBloc,
            builder: (_, WordState state) {
              if (state is WordError) {
                return errorView();
              }
              if (state is WordLoading) {
                return loadingView();
              }
              if (state is WordLoaded) {
                return loadedView(state.response, _wordBloc);
              }
              if (state is WordEmpty) {
                return errorView();
                // TODO: add empty view
              }
              return errorView();
            }));
  }

  Widget errorView() => Center(
        child: Text('Error'),
      );

  Widget loadingView() => Padding(
      padding: EdgeInsets.all(35),
      child: Container(
          width: double.maxFinite,
          height: 400,
          decoration: BoxDecoration_Container(),
          child: Container(
              child: Center(
                  child: CircularProgressIndicator(
            color: Color.fromRGBO(223, 78, 80, 1),
          )))));

  Widget loadedView(SearchResponse response, WordBloc wordBloc) => SafeArea(
          child: SwipeDetector(
        child: Padding(
            padding: EdgeInsets.all(35),
            child: Column(children: [
              FlipCard(
                  direction: FlipDirection.HORIZONTAL,
                  // default
                  front: Container(
                      padding: EdgeInsets.only(left: 20, right: 15, top: 50),
                      width: double.maxFinite,
                      height: 400,
                      decoration: BoxDecoration_Container(),
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
                              style: GoogleFonts.roboto(
                                  fontSize: 15,
                                  color: Color.fromRGBO(91, 91, 91, 1)),
                            ),
                            SizedBox(
                              height: 50,
                            ),
                            Text(
                              response.meanings[0].definitions[0].example,
                              style: GoogleFonts.roboto(
                                  fontSize: 15,
                                  color: Color.fromRGBO(91, 91, 91, 1)),
                            ),
                          ])),
                  back: Container(
                      // padding: EdgeInsets.all(20),
                      width: double.maxFinite,
                      height: 400,
                      decoration: BoxDecoration_Container(),
                      child: Column(children: [
                        Padding(
                          padding: EdgeInsets.only(
                            top: 20,
                          ),
                          child: Text(
                            word,
                            style: TextStyle(
                                fontFamily: 'Futura',
                                fontSize: 35,
                                color: Color.fromRGBO(91, 91, 91, 1)),
                            textAlign: TextAlign.center,
                          ),
                        ),
                        Expanded(
                            child: ListView.builder(
                                scrollDirection: Axis.vertical,
                                shrinkWrap: true,
                                itemCount: response.meanings.length,
                                itemBuilder: (BuildContext context,
                                        int index) =>
                                    ListBody(
                                      children: [
                                        Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              SizedBox(
                                                height: 10,
                                              ),
                                              Container(
                                                  alignment:
                                                      Alignment.centerLeft,
                                                  height: 30,
                                                  width: double.infinity,
                                                  color: Color.fromRGBO(
                                                      247, 247, 247, 1),
                                                  child: Padding(
                                                    padding: EdgeInsets.only(
                                                        left: 20, right: 20),
                                                    child: Text(
                                                      response.meanings[index]
                                                          .partOfSpeech,
                                                      textAlign: TextAlign.left,
                                                      style: TextStyle(
                                                        fontFamily: ('Futura'),
                                                        fontSize: 20,
                                                        fontWeight:
                                                            FontWeight.bold,
                                                        foreground: Paint()
                                                          ..shader =
                                                              LinearGradient(
                                                            colors: [
                                                              Color.fromRGBO(
                                                                  223,
                                                                  78,
                                                                  80,
                                                                  1),
                                                              Color.fromRGBO(
                                                                  234,
                                                                  117,
                                                                  92,
                                                                  1)
                                                            ],
                                                            begin: Alignment
                                                                .topCenter,
                                                            end: Alignment
                                                                .bottomCenter,
                                                          ).createShader(
                                                                  Rect.fromLTWH(
                                                                      0.0,
                                                                      0.0,
                                                                      200.0,
                                                                      70.0)),
                                                      ),
                                                    ),
                                                  )),
                                            ]),
                                        SizedBox(
                                          height: 10,
                                        ),
                                        Padding(
                                          padding: EdgeInsets.only(
                                              left: 20, right: 20),
                                          child: Text(
                                              response.meanings[index]
                                                  .definitions[0].definition,
                                              style: GoogleFonts.roboto(
                                                  fontSize: 15,
                                                  color: Color.fromRGBO(
                                                      91, 91, 91, 1))),
                                        )
                                      ],
                                    )))
                      ]))),
            ])),
        onSwipeLeft: () {
          setState(() {
            word = RandomWord();
            wordBloc.add(FetchWord(word: word));
          });
        },
        onSwipeRight: () {
          setState(() {
            word = RandomWord();
            wordBloc.add(FetchWord(word: word));
          });
        },
      ));

  String RandomWord() {
    String w = generateNoun().take(1).join('()').toString();
    return w;
  }
}
