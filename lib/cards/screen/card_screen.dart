import 'package:Dictionary/cards/card_bloc/word_card_event.dart';
import 'package:Dictionary/cards/card_bloc/word_card_bloc.dart';
import 'package:Dictionary/cards/widgets/cards.dart';
import 'package:Dictionary/favorite_words/service/favorite_words_service.dart';
import 'package:flutter/material.dart';
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

  @override
  void initState() {
    super.initState();
    _controller = SwipableStackController();
    wordBloc.add(InitView());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 30),
          child: buildCards(WordSwipe(), wordBloc, _controller)),
    );
  }
}
