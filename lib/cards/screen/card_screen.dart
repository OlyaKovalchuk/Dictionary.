import 'package:dictionary/authentication/service/firebase_auth_service.dart';
import 'package:dictionary/cards/card_bloc/word_card_event.dart';
import 'package:dictionary/cards/card_bloc/word_card_bloc.dart';
import 'package:dictionary/cards/card_bloc/word_card_states.dart';
import 'package:dictionary/cards/views/error_view.dart';
import 'package:dictionary/cards/views/loaded_view.dart';
import 'package:dictionary/cards/views/loading_view.dart';
import 'package:dictionary/favorite_words/service/favorite_words_service.dart';
import 'package:dictionary/widgets/appBar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:dictionary/cards/repository/word_data.dart';
import 'package:swipable_stack/swipable_stack.dart';

class CardScreen extends StatefulWidget {
  @override
  _CardScreenState createState() => _CardScreenState();
}

class _CardScreenState extends State<CardScreen> {
  late SwipableStackController _controller;
  WordCardBloc wordBloc = WordCardBloc(
      repository: Repository(), favWordsService: FavWordsServiceImpl());
  UserRepositoryImpl userRepository = UserRepositoryImpl();

  @override
  void initState() {
    super.initState();
    _controller = SwipableStackController();
    wordBloc.add(InitView());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: buildAppBar(
        leading: TextButton(
            onPressed: () async {
              await userRepository.signOut();
              Navigator.pushNamed(context, '/loginScreen');
            },
            child: Text('sing out')),
        actions: [
          IconButton(
              onPressed: () {
                Navigator.of(context).pushNamed('/searchScreen');
              },
              icon: Icon(Icons.search))
        ],
      ),
      body:BlocBuilder<WordCardBloc, WordCardStackState>(
        bloc: wordBloc,
        builder: (_, wordStackState) {
       return   SwipableStack(
        controller: _controller,
        stackClipBehaviour: Clip.none,
        onSwipeCompleted: (index, direction) {
          wordBloc.add(WordSwipe());
        },
        builder: (BuildContext context, int index, BoxConstraints constraints) {
                if (index >= wordStackState.wordCardStates.length) {
                  return loadingView(context);
                }
                WordCardState wordState = wordStackState.wordCardStates[index];

                if (wordState is Error) {
                  return errorView();
                }
                if (wordState is Loading) {
                  return loadingView(context);
                }
                if (wordState is Ready) {
                  return loadedView(
                      wordState.word, wordBloc, context, wordState.isFavorited);
                }
                return loadingView(context);
              });
        },
      ),
    );
  }
}
