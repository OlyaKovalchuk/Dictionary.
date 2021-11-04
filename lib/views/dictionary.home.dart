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
import 'package:Dictionary/service/definition.api.dart';
import 'package:swipable_stack/swipable_stack.dart';

class DictionaryHome extends StatefulWidget {
  const DictionaryHome({Key? key}) : super(key: key);

  @override
  _DictionaryHomeState createState() => _DictionaryHomeState();
}

class _DictionaryHomeState extends State<DictionaryHome> {
  late SwipableStackController _controller;
  WordBloc wordBloc = WordBloc(repository: Repository());

  @override
  void initState() {
    super.initState();
    _controller = SwipableStackController();
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
                  Navigator.of(context).pushNamed('/search');
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
            print('1');
            return BlocBuilder<WordBloc, WordState>(
              bloc: wordBloc,
              builder: (_, wordState) {
                if (wordState is WordError) {
                  return errorView();
                }
                if (wordState is WordLoading) {
                  return loadingView();
                }
                if (wordState is WordLoaded) {
                  if (index >= wordState.response.length) {
                    return loadingView();
                  } else {
                    return loadedView(wordState.response[index], wordBloc);
                  }
                }
                if (wordState is WordEmpty) {
                  return emptyView();
                }
                return loadingView();
              },
            );
          },
        ));
  }
}
