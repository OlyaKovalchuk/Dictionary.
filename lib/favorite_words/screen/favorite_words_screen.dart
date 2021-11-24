import 'package:dictionary/favorite_words/bloc/favorite_words_bloc.dart';
import 'package:dictionary/favorite_words/bloc/favorite_words_event.dart';
import 'package:dictionary/favorite_words/service/favorite_words_service.dart';
import 'package:dictionary/widgets/appBar.dart';
import 'package:dictionary/widgets/colors/red_color.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';



class FavoriteWordsScreen extends StatelessWidget {
  final FavWordsBloc _favWordsBloc = FavWordsBloc(FavWordsServiceImpl());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: buildAppBar(title: 'Favorite Words'),
        body: BlocBuilder(
          bloc: _favWordsBloc..add(InitialEvent()),
          builder: (BuildContext context, state) {
            List? _favWords = _favWordsBloc.favWords;
            if (_favWords != null) {
              return ListView.separated(
                  itemCount: _favWords.length,
                  itemBuilder: (context, index) {
                    return  ListTile(
                            leading: Container(
                              padding: EdgeInsets.all(5),
                              decoration: BoxDecoration(
                                  border: Border.all(color: redColor()),
                                  shape: BoxShape.circle),
                              child: Text(
                                (index + 1).toString(),
                                style: TextStyle(color: redColor(),
                                fontSize: 12),
                              ),
                            ),
                            title: Text(
                              toBeginningOfSentenceCase(_favWords[index])!,
                            )
                    );
                  }, separatorBuilder: (BuildContext context, int index) {
                    return Container(
                      height: 1,
                      color: redColor().withOpacity(0.2),);
              },);
            }
            return Container();
          },
        ));
  }
}
