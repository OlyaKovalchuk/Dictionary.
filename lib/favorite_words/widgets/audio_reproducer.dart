import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../theme/theme_colors.dart';
import '../../utils/audio_fun.dart';
import '../bloc/favorite_words_bloc.dart';

class AudioReproducer extends StatelessWidget {
  final int index;

  const AudioReproducer({Key? key, required this.index}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
        onTap: () => getAudio(
            BlocProvider.of<FavWordsBloc>(context).favWords![index].audio),
        child: Icon(
          Icons.volume_up_rounded,
          color: greyDarkColor,
          size: 20,
        ));
  }
}
