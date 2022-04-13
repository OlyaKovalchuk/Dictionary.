import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:swipable_stack/swipable_stack.dart';

import '../../theme/theme_colors.dart';
import '../bloc/favorite_words_bloc.dart';
import 'audio_reproducer.dart';
import 'build_word_to_card.dart';
import 'show_dialog.dart';

class ListFavWordsBuilder extends StatelessWidget {
  final SwipableStackController controller;

  const ListFavWordsBuilder({Key? key, required this.controller})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      scrollDirection: Axis.vertical,
      shrinkWrap: true,
      itemCount: BlocProvider.of<FavWordsBloc>(context).favWords!.length,
      itemBuilder: (context, index) {
        return ListTile(
            leading: AudioReproducer(index: index),
            title: ButtonWordToCard(
              index: index,
              controller: controller,
            ),
            trailing: DeleteWord(index: index));
      },
      separatorBuilder: (BuildContext context, int index) {
        return Container(
          height: 1,
          color: redColor.withOpacity(0.2),
        );
      },
    );
  }
}
