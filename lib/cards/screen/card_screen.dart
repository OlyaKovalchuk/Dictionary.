import 'package:Dictionary/authentication/service/firebase_auth_service.dart';
import 'package:Dictionary/cards/card_bloc/word_card_event.dart';
import 'package:Dictionary/cards/card_bloc/word_card_bloc.dart';
import 'package:Dictionary/cards/widgets/cards.dart';
import 'package:Dictionary/favorite_words/service/favorite_words_service.dart';
import 'package:Dictionary/widgets/appBar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:Dictionary/cards/repository/word_data.dart';
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
      ),
      body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 35, vertical: 30),
          child: buildCards(WordSwipe(), wordBloc, _controller)),
    );
  }
}
