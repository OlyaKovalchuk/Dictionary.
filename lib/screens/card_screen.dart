import 'package:Dictionary/bloc/request_word.dart';
import 'package:Dictionary/bloc/card_bloc/word_card_bloc.dart';
import 'package:Dictionary/bloc/card_bloc/word_card_states.dart';
import 'package:Dictionary/views/empty_view.dart';
import 'package:Dictionary/views/error_view.dart';
import 'package:Dictionary/views/loaded_view.dart';
import 'package:Dictionary/views/loading_view.dart';
import 'package:Dictionary/widgets/gradientColor/gradient_widget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:Dictionary/service/definition.api.dart';
import 'package:swipable_stack/swipable_stack.dart';

class CardScreen extends StatefulWidget {
  const CardScreen({Key? key}) : super(key: key);

  @override
  _CardScreenState createState() => _CardScreenState();
}

class _CardScreenState extends State<CardScreen> {
  late SwipableStackController _controller;
  WordCardBloc wordBloc = WordCardBloc(repository: Repository());

  @override
  void initState() {
    super.initState();
    _controller = SwipableStackController();
    wordBloc.add(RequestWord());
    wordBloc.add(RequestWord());
  }

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
                  Navigator.of(context).pushNamed('/searchScreen');
                },
                icon: Icon(Icons.search))
          ],
          flexibleSpace: gradientLinear(),
        ),
        body: SwipableStack(
          controller: _controller,
          stackClipBehaviour: Clip.none,
          onSwipeCompleted: (index, direction) {
            wordBloc.add(RequestWord());
          },
          builder:
              (BuildContext context, int index, BoxConstraints constraints) {
            return BlocBuilder<WordCardBloc, WordCardState>(
              bloc: wordBloc,
              builder: (_, wordState) {
                if (wordState is WordCardError) {
                  return errorView();
                }
                if (wordState is WordCardLoading) {
                  return loadingView();
                }
                if (wordState is WordCardLoaded) {
                  if (index >= wordState.wordList.length) {
                    return loadingView();
                  } else {
                    return loadedView(wordState.wordList[index], wordBloc);
                  }
                }
                if (wordState is WordCardEmpty) {
                  return emptyView();
                }
                return loadingView();
              },
            );

          },
        ));
  }
}