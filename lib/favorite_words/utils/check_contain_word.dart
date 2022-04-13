import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../search/utils/error_output.dart';
import '../bloc/favorite_words_bloc.dart';
import '../bloc/favorite_words_event.dart';
import '../model/words_model.dart';
import 'close_dialog.dart';

checkContainWord(WordData word, BuildContext context) async {
  var favWords = BlocProvider.of<FavWordsBloc>(context);
  if (!favWords.favWords!.contains(word)) {
    favWords.add(AddToFavWordsEvent(word: word));
    favWords.add(GetFavWordsEvent());
    await close(context);
  } else if (favWords.favWords!.contains(word)) {
    errorOutput(error: 'This word is already added', context: context);
  }
}
