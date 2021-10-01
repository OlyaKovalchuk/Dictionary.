// import 'package:dictionary/firestore_cloud.dart';
// import 'package:flutter/material.dart';
//
// class FavoriteWordsPage extends StatefulWidget {
//   const FavoriteWordsPage({Key? key}) : super(key: key);
//
//   @override
//   _FavoriteWordsPageState createState() => _FavoriteWordsPageState();
// }
//
// class _FavoriteWordsPageState extends State<FavoriteWordsPage> {
//   FirestoreCloud _firestoreCloud = FirestoreCloud();
//   @override
//   Widget build(BuildContext context) {
//     return StreamBuilder(
//       stream: _firestoreCloud.userRef.snapshots(),
//         builder: (context, snapshot) => ListTile(
//           title: _firestoreCloud.getFavoriteWords()[snapshot],
//         )
//     );
//   }
// }
