import 'package:Dictionary/authentication/service/firebase_auth_service.dart';
import 'package:flutter/material.dart';

class LoginScreen extends StatefulWidget {
 final UserRepository userRepository;
   LoginScreen({required this.userRepository});

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
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
