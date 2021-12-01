import 'package:Dictionary/cards/card_bloc/word_card_bloc.dart';
import 'package:Dictionary/cards/card_bloc/word_card_event.dart';
import 'package:Dictionary/cards/card_bloc/word_card_states.dart';
import 'package:Dictionary/cards/views/error_view.dart';
import 'package:Dictionary/cards/views/loaded_view.dart';
import 'package:Dictionary/cards/views/loading_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:swipable_stack/swipable_stack.dart';

buildCards(WordEvent event, WordCardBloc wordBloc,
        SwipableStackController controller) =>
    BlocBuilder<WordCardBloc, WordCardStackState>(
      bloc: wordBloc,
      builder: (context, wordStackState) {
        return SwipableStack(
            controller: controller,
            stackClipBehaviour: Clip.none,
            onSwipeCompleted: (index, direction) {
              wordBloc.add(event);
            },
            builder:
                (BuildContext context, int index, BoxConstraints constraints) {
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
                    wordState.word, context, wordState.isFavorited);
              }
              return loadingView(context);
            });
      },
    );
