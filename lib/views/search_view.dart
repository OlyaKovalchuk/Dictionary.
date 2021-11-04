import 'package:Dictionary/bloc/FetchWordEvent.dart';
import 'package:Dictionary/bloc/word_bloc.dart';
import 'package:Dictionary/bloc/word_states.dart';
import 'package:Dictionary/bloc/blocView/empty_view.dart';
import 'package:Dictionary/bloc/blocView/error_view.dart';
import 'package:Dictionary/bloc/blocView/listBuilder_info.dart';
import 'package:Dictionary/widgets/border/border_radius.dart';
import 'package:Dictionary/widgets/cardDecoration/indicator_decoration.dart';
import 'package:Dictionary/widgets/colors/grey_color.dart';
import 'package:Dictionary/widgets/colors/grey_light_color.dart';
import 'package:Dictionary/widgets/colors/red_color.dart';
import 'package:Dictionary/widgets/gradientColor/gradient_widget.dart';
import 'package:Dictionary/widgets/gradientColor/icon_gradient.dart';
import 'package:flutter/material.dart';
import 'package:Dictionary/service/definition.api.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SearchPage extends StatefulWidget {
  const SearchPage({Key? key}) : super(key: key);

  @override
  _SearchPageState createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  GlobalKey _key = GlobalKey();
  TextEditingController _controller = TextEditingController();
  late WordBloc _wordBloc = WordBloc(repository: Repository());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
            flexibleSpace: gradientLinear(),
            //centerTitle: true,
            title: PreferredSize(
              preferredSize: Size.fromHeight(40.0),
              child: Container(
                  decoration: BoxDecoration(
                    borderRadius: borderRadius(),
                    color: Colors.white,
                  ),
                  height: 40,
                  child: TextField(
                    decoration: InputDecoration(
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                          color: Colors.white,
                        ),
                        borderRadius: borderRadius(),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: borderRadius(),
                        borderSide: BorderSide(
                          color: Colors.white,
                        ),
                      ),
                      contentPadding: EdgeInsets.only(left: 15),
                      hintText: 'Enter a word',
                      hintStyle: TextStyle(color: greyLightColor()),
                      suffixIcon: IconButton(
                          icon: iconGradient(),
                          onPressed: () {
                            _wordBloc.add(RequestWord(word: _controller.text));
                          }),
                    ),
                    autocorrect: true,
                    maxLines: 1,
                    enableSuggestions: true,
                    cursorColor: redColor(),
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
                          color: greyColor()),
                      textAlign: TextAlign.center,
                    ),
                  ),
                  Expanded(
                    child: infoListBuilder(state.response[0]),
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
