import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../authentication/widgets/text_fields.dart';
import '../../cards/repository/word_data.dart';
import '../../search/bloc/word_search_bloc.dart';
import '../../search/bloc/word_search_event.dart';
import '../../search/bloc/word_search_states.dart';
import '../../search/utils/error_output.dart';
import '../../theme/theme_colors.dart';
import '../bloc/favorite_words_bloc.dart';
import '../model/words_model.dart';
import '../utils/check_contain_word.dart';
import 'build_circular_indicator.dart';

class DialogAddWordBuilder extends StatelessWidget {
  DialogAddWordBuilder({Key? key}) : super(key: key);
  final WordSearchBloc _wordSearchBloc =
      WordSearchBloc(repository: Repository());
  final textController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocBuilder(
      bloc: _wordSearchBloc,
      builder: (_, state) {
        return AlertDialog(
          elevation: 0,
          shape: RoundedRectangleBorder(
              borderRadius: const BorderRadius.all(Radius.circular(25.0))),
          title: Text(
            'Add word to list',
            style: Theme.of(context).textTheme.subtitle2,
            textAlign: TextAlign.center,
          ),
          content: TextFieldBuilder(
            validator: (val) {
              if (BlocProvider.of<FavWordsBloc>(context)
                  .favWords!
                  .map((e) => e.word)
                  .toList()
                  .contains(textController.text)) {
                return 'List contains this word';
              }
              return null;
            },
            controller: textController,
            textInputType: TextInputType.text,
            hint: 'word',
          ),
          actions: [
            TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: Text(
                  'Cancel',
                  style: TextStyle(color: greyColor),
                )),
            TextButton(
                onPressed: () {
                  _wordSearchBloc.add(WordSearch(word: textController.text));
                  if (state is WordSearchLoading) {
                    BuildCircularIndicator();
                  }
                  if (state is WordSearchLoaded) {
                    checkContainWord(
                        WordData(
                            word: state.response.word,
                            audio: state.response.phonetics?.first.audio),
                        context);
                  }
                  if (state is WordSearchError) {
                    return errorOutput(
                        error: textController.text == ''
                            ? 'Enter a word'
                            : 'There is no such word in the dictionary',
                        context: context);
                  }
                },
                child:
                    Text('ADD', style: Theme.of(context).textTheme.subtitle2)),
          ],
        );
      },
    );
  }
}
