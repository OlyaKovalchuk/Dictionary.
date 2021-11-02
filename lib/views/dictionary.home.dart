import 'dart:math';

import 'package:Dictionary/bloc/FetchWordEvent.dart';
import 'package:Dictionary/bloc/blocView/empty_view.dart';
import 'package:Dictionary/bloc/word_bloc.dart';
import 'package:Dictionary/bloc/word_states.dart';
import 'package:Dictionary/bloc/blocView/error_view.dart';
import 'package:Dictionary/bloc/blocView/loaded_view.dart';
import 'package:Dictionary/bloc/blocView/loading_view.dart';
import 'package:Dictionary/widgets/gradientColor/gradient_widget.dart';
import 'package:english_words/english_words.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:Dictionary/service/definition.api.dart';
import 'package:simple_gesture_detector/simple_gesture_detector.dart';

class DictionaryHome extends StatefulWidget {
  const DictionaryHome({Key? key}) : super(key: key);

  @override
  _DictionaryHomeState createState() => _DictionaryHomeState();
}

class _DictionaryHomeState extends State<DictionaryHome> {
  late WordBloc _wordBloc;
  var random;
 late int index;

  @override
  void initState() {
    super.initState();
     random = Random();
    index = random.nextInt(nouns.length);
    _wordBloc = WordBloc(repository: Repository());
    _wordBloc.add(FetchWord(word: word));
  }


  late String word = RandomWord(index);


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
          flexibleSpace: gradientLinear(),
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
                return SimpleGestureDetector(

                  onHorizontalSwipe: _onHorizontalSwipe,

                  swipeConfig: SimpleSwipeConfig(
                    verticalThreshold: 40.0,
                    horizontalThreshold: 40.0,
                    swipeDetectionBehavior: SwipeDetectionBehavior.continuousDistinct,
                  ),
                  child: loadedView(state.response, _wordBloc, state.response.word),
                );


              }
              if (state is WordEmpty) {
                return emptyView();
              }
              return errorView();
            }));
  }

  String RandomWord(int ind) {
    String word = nouns[ind].toString();
    return word;
   }

   updateWord(){
    index++;
    return RandomWord(index);
   }
  void _onHorizontalSwipe(SwipeDirection direction) {
    setState(() {
      if (direction == SwipeDirection.left) {
        word = updateWord();
        _wordBloc.add(FetchWord(word: word));

      } else {
        if(index != 0) {
          index--;
          word = RandomWord(index);
          _wordBloc.add(FetchWord(word: word));
        }else if(index <= nouns.length){
          word = RandomWord(index);
          _wordBloc.add(FetchWord(word: word));
        }
    }});
  }
}
