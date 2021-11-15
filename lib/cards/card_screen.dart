import 'package:Dictionary/authentication/service/firebase_auth_service.dart';
import 'package:Dictionary/cards/card_bloc/word_card_event.dart';
import 'package:Dictionary/cards/card_bloc/word_card_bloc.dart';
import 'package:Dictionary/cards/card_bloc/word_card_states.dart';
import 'package:Dictionary/cards/views/error_view.dart';
import 'package:Dictionary/cards/views/loaded_view.dart';
import 'package:Dictionary/cards/views/loading_view.dart';
import 'package:Dictionary/widgets/gradientColor/gradient_widget.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:Dictionary/cards/repository/word_data.dart';
import 'package:swipable_stack/swipable_stack.dart';

class CardScreen extends StatefulWidget {
 final User? user;
   CardScreen({Key? key,  this.user}) : super(key: key);

  @override
  _CardScreenState createState() => _CardScreenState();
}

class _CardScreenState extends State<CardScreen> {
  late SwipableStackController _controller;
  WordCardBloc wordBloc = WordCardBloc(repository: Repository());
UserRepository userRepository = UserRepository();
  @override
  void initState() {
    super.initState();
    _controller = SwipableStackController();
    wordBloc.add(InitView());


  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          automaticallyImplyLeading: false,
          centerTitle: true,
          title: Text('Dictionary.',
              style: TextStyle(
                  fontFamily: ('Futura'),
                  fontSize: 25,
                  fontWeight: FontWeight.bold,
                  color: Colors.white)),
          leading:  TextButton(onPressed: (){
            userRepository.signOut();
          }, child: Text('sing out')),
          actions: [
            IconButton(
                onPressed: () {
                  Navigator.of(context).pushNamed('/searchScreen');
                },
                icon: Icon(Icons.search))
          ],
          flexibleSpace: gradientLinear(),
        ),
        body: SwipableStack(
          controller: _controller,
          stackClipBehaviour: Clip.none,
          onSwipeCompleted: (index, direction) {
            wordBloc.add(WordSwipe());
          },
          builder:
              (BuildContext context, int index, BoxConstraints constraints) {
            return BlocBuilder<WordCardBloc, WordCardStackState>(
              bloc: wordBloc,
              builder: (_, wordStackState) {
                if (index >= wordStackState.wordCardStates.length) {
                  return  loadingView(context);
                }
                WordCardState wordState = wordStackState.wordCardStates[index];

                if (wordState is Error) {
                  return errorView();
                }
                if (wordState is Loading) {
                  return loadingView(context);
                }
                if (wordState is Ready) {
                 return loadedView(wordState.word, wordBloc, context);
                }
                return loadingView(context);
              }
            );
          },

        ));
  }
}
