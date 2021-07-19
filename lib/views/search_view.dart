import 'package:Dictionary/bloc/FetchWordEvent.dart';
import 'package:Dictionary/bloc/word_bloc.dart';
import 'package:Dictionary/bloc/word_states.dart';
import 'package:Dictionary/bloc/blocView/empty_view.dart';
import 'package:Dictionary/bloc/blocView/error_view.dart';
import 'package:Dictionary/bloc/blocView/listBuilder_info.dart';
import 'package:Dictionary/widgets/cardDecoration/indicator_decoration.dart';
import 'package:Dictionary/widgets/gradientColor/gradient_widget.dart';
import 'package:Dictionary/widgets/gradientColor/icon_gradient.dart';
import 'package:flutter/material.dart';
import 'package:Dictionary/service/definition.api.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class Search_Page extends StatefulWidget {
  const Search_Page({Key? key}) : super(key: key);

  @override
  _Search_PageState createState() => _Search_PageState();
}

class _Search_PageState extends State<Search_Page> {
  GlobalKey _key = GlobalKey();
  TextEditingController _controller = TextEditingController();
  late WordBloc _wordBloc = WordBloc(dictionaryApi: DictionaryApi());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
            flexibleSpace: GradientLinear(),
            //centerTitle: true,
            title: PreferredSize(
              preferredSize: Size.fromHeight(40.0),
              child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(40),
                    color: Colors.white,
                  ),
                  height: 40,
                  child: TextField(
                    decoration: InputDecoration(
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                          color: Colors.white,
                        ),
                        borderRadius: BorderRadius.circular(40),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(40),
                        borderSide: BorderSide(
                          color: Colors.white,
                        ),
                      ),
                      contentPadding: EdgeInsets.only(left: 15),
                      hintText: 'Enter a word',
                      hintStyle:
                          TextStyle(color: Color.fromRGBO(223, 223, 223, 1)),
                      suffixIcon: IconButton(
                          icon: Icon_Gradient(),
                          onPressed: () {
                            _wordBloc.add(FetchWord(word: _controller.text));
                          }),
                    ),
                    autocorrect: true,
                    maxLines: 1,
                    enableSuggestions: true,
                    cursorColor: Color.fromRGBO(222, 77, 79, 1),
                    autofocus: true,
                    style: TextStyle(
                      fontSize: 15,
                      color: Colors.black,
                    ),
                    key: _key,
                    controller: _controller,
                  )),
            )),
        body: BlocBuilder(
            bloc: _wordBloc,
            builder: (_, WordState state) {
              if (state is WordError) {
                return errorView();
              }
              if (state is WordLoading) {
                return indicatorCircular();
              }
              if (state is WordLoaded) {
                return Column(children: [
                  Padding(
                    padding: EdgeInsets.only(
                      top: 20,
                      bottom: 20,
                    ),
                    child: Text(
                      _controller.text,
                      style: TextStyle(
                          fontFamily: 'Futura',
                          fontSize: 35,
                          color: Color.fromRGBO(91, 91, 91, 1)),
                      textAlign: TextAlign.center,
                    ),
                  ),
                  Expanded(
                    child: infoListBuilder(state.response),
                  ),
                ]);
              }
              if (state is WordEmpty) {
                return emptyView();
              }
              return errorView();
            }));
  }
}
