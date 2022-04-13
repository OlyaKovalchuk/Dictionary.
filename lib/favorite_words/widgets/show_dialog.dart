import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../theme/theme_colors.dart';
import '../bloc/favorite_words_bloc.dart';
import '../bloc/favorite_words_event.dart';

class ShowDialog extends StatelessWidget {
  final Widget child;

  const ShowDialog({Key? key, required this.child}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Dialog(
        elevation: 0,
        insetPadding: EdgeInsets.only(
            top: MediaQuery.of(context).size.height / 7, left: 30, right: 30),
        backgroundColor: Colors.transparent,
        child: child);
  }
}

class DeleteWord extends StatelessWidget {
  final int index;

  DeleteWord({Key? key, required this.index}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        BlocProvider.of<FavWordsBloc>(context).add(DeleteFavWordsEvent(
            word: BlocProvider.of<FavWordsBloc>(context).favWords![index]));
        BlocProvider.of<FavWordsBloc>(context)
            .favWords!
            .remove(BlocProvider.of<FavWordsBloc>(context).favWords![index]);
      },
      child: Icon(
        Icons.delete_outlined,
        color: greyDarkColor,
        size: 20,
      ),
    );
  }
}
