import 'package:Dictionary/cards/bloc/card_bloc.dart';
import 'package:Dictionary/cards/bloc/card_event.dart';
import 'package:Dictionary/cards/bloc/card_states.dart';
import 'package:Dictionary/cards/views/empty_view.dart';
import 'package:Dictionary/cards/views/error_view.dart';
import 'package:Dictionary/cards/views/loaded_view.dart';
import 'package:Dictionary/cards/views/loading_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:swipable_stack/swipable_stack.dart';

class CardsBuilder extends StatelessWidget {
  final WordEvent event;
  final WordCardBloc wordBloc;
  final SwipableStackController controller;

  CardsBuilder(
      {Key? key,
      required this.event,
      required this.wordBloc,
      required this.controller})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<WordCardBloc, WordCardStackState>(
        bloc: wordBloc,
        builder: (context, wordStackState) {
          return SwipableStack(
              controller: controller,
              stackClipBehaviour: Clip.none,
              onSwipeCompleted: (index, direction) {
                wordBloc.add(event);
              },
              builder: (BuildContext context, int index,
                  BoxConstraints constraints) {
                if (index >= wordStackState.wordCardStates.length) {
                  return LoadingView();
                }
                WordCardState wordState = wordStackState.wordCardStates[index];

                if (wordState is Error) {
                  return ErrorView();
                }
                if (wordState is Loading) {
                  return LoadingView();
                }
                if (wordState is Ready) {
                  return LoadedView(
                      response: wordState.word,
                      isFavorite: wordState.isFavorited);
                }
                return EmptyView();
              });
        });
  }
}
