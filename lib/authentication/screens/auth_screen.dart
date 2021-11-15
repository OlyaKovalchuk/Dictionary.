import 'package:Dictionary/authentication/service/firebase_auth_service.dart';
import 'package:flutter/material.dart';

class AuthScreen extends StatefulWidget {
 final UserRepository userRepository;
   AuthScreen({required this.userRepository});

  @override
  _AuthScreenState createState() => _AuthScreenState();
}

class _AuthScreenState extends State<AuthScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body:
      SafeArea(
        minimum: EdgeInsets.only(top: 30),
        child: Column(children: [
          Text('Login'),
          TextField(
            onSubmitted: (email){

            },
          ),
          TextField()
        ],),

      ),
    );
  }
}
