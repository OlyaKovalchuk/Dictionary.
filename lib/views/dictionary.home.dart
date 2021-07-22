import 'package:Dictionary/bloc/FetchWordEvent.dart';
import 'package:Dictionary/bloc/blocView/empty_view.dart';
import 'package:Dictionary/bloc/word_bloc.dart';
import 'package:Dictionary/bloc/word_states.dart';
import 'package:Dictionary/bloc/blocView/error_view.dart';
import 'package:Dictionary/bloc/blocView/loaded_view.dart';
import 'package:Dictionary/bloc/blocView/loading_view.dart';
import 'package:Dictionary/widgets/gradientColor/gradient_widget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:random_words/random_words.dart';
import 'package:swipedetector/swipedetector.dart';
import 'package:Dictionary/service/definition.api.dart';

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
                return SwipeDetector(
                  child: loadedView(
                    state.response,
                    _wordBloc,
                    word,
                  ),
                  onSwipeLeft: () {
                    setState(() {
                      word = RandomWord();
                      _wordBloc.add(FetchWord(word: word));
                    });
                  },
                  onSwipeRight: () {
                    setState(() {
                      word = RandomWord();
                      _wordBloc.add(FetchWord(word: word));
                    });
                  },
                );
              }
              if (state is WordEmpty) {
                return emptyView();
              }
              return errorView();
            }));
  }

  String RandomWord() {
    String word = generateNoun().take(1).join('()').toString();
    return word;
  }
}
