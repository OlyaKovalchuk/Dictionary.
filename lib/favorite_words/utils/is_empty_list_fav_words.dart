import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../bloc/favorite_words_bloc.dart';

bool isEmptyListFavWords(BuildContext context) =>
    BlocProvider.of<FavWordsBloc>(context).favWords!.isEmpty;
