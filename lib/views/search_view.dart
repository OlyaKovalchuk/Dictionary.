// import 'dart:async';
// import 'package:Dictionary/widgets/gradient_widget.dart';
// import 'package:Dictionary/widgets/icon_gradient.dart';
// import 'package:flutter/material.dart';
// import 'package:Dictionary/service/definition.api.dart';
// import 'package:google_fonts/google_fonts.dart';
//
// class Search_Page extends StatefulWidget {
//   const Search_Page({Key? key}) : super(key: key);
//
//   @override
//   _Search_PageState createState() => _Search_PageState();
// }
//
// class _Search_PageState extends State<Search_Page> {
//   GlobalKey _key = GlobalKey();
//   TextEditingController _controller = TextEditingController();
//   DictionaryApi dictionaryApi = DictionaryApi();
//
//   @override
//   void initState() {
//     super.initState();
//     dictionaryApi.streamController = StreamController();
//     dictionaryApi.stream = dictionaryApi.streamController.stream;
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//         appBar: AppBar(
//             flexibleSpace: GradientLinear(),
//             //centerTitle: true,
//             title: PreferredSize(
//               preferredSize: Size.fromHeight(40.0),
//               child: Container(
//                   decoration: BoxDecoration(
//                     borderRadius: BorderRadius.circular(40),
//                     color: Colors.white,
//                   ),
//                   height: 40,
//                   child: TextField(
//                     decoration: InputDecoration(
//                       focusedBorder: OutlineInputBorder(
//                         borderSide: BorderSide(color: Colors.white),
//                         borderRadius: BorderRadius.circular(40),
//                       ),
//                       contentPadding: EdgeInsets.only(left: 15),
//                       hintText: 'Enter a word',
//                       hintStyle:
//                           TextStyle(color: Color.fromRGBO(223, 223, 223, 1)),
//                       suffixIcon: IconButton(
//                           icon: Icon_Gradient(),
//                           onPressed: () {
//                             dictionaryApi.search(_controller.text);
//                           }),
//                     ),
//                     autocorrect: true,
//                       maxLines: 1,
//                       enableSuggestions: true,
//                     cursorColor: Color.fromRGBO(222, 77, 79, 1),
//                     autofocus: true,
//                     style: TextStyle(
//                       fontSize: 15,
//                       color: Colors.black,
//                     ),
//                     key: _key,
//                     controller: _controller,
//                   )),
//             )),
//         body: StreamBuilder(
//           stream: dictionaryApi.stream,
//           builder: (BuildContext cxt, AsyncSnapshot snapshot) {
//             if (snapshot.data == null) {
//               return Text('');
//             }
//             if (snapshot.data == 'waiting') {
//               return Center(
//                 child: CircularProgressIndicator(color: Color.fromRGBO(223, 78, 80, 1)),
//               );
//             }
//             return Column(children: [
//               Padding(
//                 padding: EdgeInsets.only(
//                   top: 20,
//                 ),
//                 child: Text(
//                   _controller.text,
//                   style: TextStyle(
//                       fontFamily: 'Futura',
//                       fontSize: 35,
//                       color: Color.fromRGBO(91, 91, 91, 1)),
//                   textAlign: TextAlign.center,
//                 ),
//               ),
//               ListView.builder(
//                   scrollDirection: Axis.vertical,
//                   shrinkWrap: true,
//                   itemCount: snapshot.data["definitions"].length,
//                   itemBuilder: (BuildContext context, int index) => ListBody(
//                         children: [
//                           Column(
//                               crossAxisAlignment: CrossAxisAlignment.start,
//                               children: [
//                                 SizedBox(
//                                   height: 10,
//                                 ),
//                                 Container(
//                                     alignment: Alignment.centerLeft,
//                                     height: 30,
//                                     width: double.infinity,
//                                     color: Color.fromRGBO(247, 247, 247, 1),
//                                     child: Padding(
//                                       padding: EdgeInsets.only(left: 20, right: 20),
//                                       child: Text(
//                                         snapshot.data["definitions"][index]
//                                             ["type"],
//                                         textAlign: TextAlign.left,
//                                         style: TextStyle(
//                                           fontFamily: ('Futura'),
//                                           fontSize: 20,
//                                           fontWeight: FontWeight.bold,
//                                           foreground: Paint()
//                                             ..shader = LinearGradient(
//                                               colors: [
//                                                 Color.fromRGBO(223, 78, 80, 1),
//                                                 Color.fromRGBO(234, 117, 92, 1)
//                                               ],
//                                               begin: Alignment.topCenter,
//                                               end: Alignment.bottomCenter,
//                                             ).createShader(Rect.fromLTWH(
//                                                 0.0, 0.0, 200.0, 70.0)),
//                                         ),
//                                       ),
//                                     )),
//                               ]),
//                           SizedBox(
//                             height: 10,
//                           ),
//                           Padding(
//                             padding: EdgeInsets.only(left: 20, right: 20),
//                             child: Text(
//                                 snapshot.data['definitions'][index]
//                                     ["definition"],
//                                 style: GoogleFonts.roboto(
//                                     fontSize: 15,
//                                     color: Color.fromRGBO(91, 91, 91, 1))),
//                           )
//                         ],
//                       ))
//             ]);
//           },
//         ));
//   }
// }
