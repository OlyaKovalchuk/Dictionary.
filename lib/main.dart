import 'package:flutter/material.dart';
import 'package:Dictionary/views/dictionary.home.dart';
import 'package:Dictionary/views/search_view.dart';
import 'package:Dictionary/views/start_view.dart';

void main() {
  runApp(MaterialApp(
      debugShowCheckedModeBanner: false,
      routes: <String, WidgetBuilder>{
       // '/search': (BuildContext context) => new Search_Page(),
        '/dictionary': (BuildContext context)  => DictionaryHome(),
        '/start': (BuildContext context) => Start_View(),
      },
      home:Start()));
}