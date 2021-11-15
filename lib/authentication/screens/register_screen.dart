import 'package:Dictionary/authentication/bloc/registration_bloc/reg_bloc.dart';
import 'package:Dictionary/authentication/bloc/registration_bloc/reg_event.dart';
import 'package:Dictionary/authentication/bloc/registration_bloc/reg_states.dart';
import 'package:Dictionary/authentication/model/user_data_model.dart';
import 'package:Dictionary/authentication/service/firebase_auth_service.dart';
import 'package:Dictionary/widgets/border/border_radius.dart';
import 'package:Dictionary/widgets/colors/grey_light_color.dart';
import 'package:Dictionary/widgets/colors/red_color.dart';
import 'package:Dictionary/widgets/gradientColor/gradient_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({Key? key}) : super(key: key);

  @override
  _RegisterScreenState createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  RegBloc _regBloc = RegBloc(UserRepository());
  final _key = GlobalKey<FormState>();
  final _controllerName = TextEditingController();
  final _controllerPassword = TextEditingController();
  final _controllerEmail = TextEditingController();
  final _focusNode = FocusNode();

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
          flexibleSpace: gradientLinear(),
          leading: GestureDetector(
            onTap: () => Navigator.pop(context),
            child: Icon(
              Icons.arrow_back_ios_rounded,
              color: Colors.white,
            ),
          ),
        ),
        body: BlocBuilder<RegBloc, RegState>(
          bloc: _regBloc,
          builder: (_, state) {
            return Padding(
              padding: const EdgeInsets.symmetric(vertical: 30, horizontal: 20),
              child: Align(
                alignment: Alignment.topCenter,
                child: Column(
                  mainAxisSize: MainAxisSize.max,
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(
                      'Create a new account',
                      style: TextStyle(
                        fontFamily: ('Futura'),
                        fontSize: 30,
                        fontWeight: FontWeight.normal,
                        foreground: Paint()
                          ..shader = gradientColor().createShader(
                              Rect.fromLTWH(0.0, 0.0, 200.0, 70.0)),
                      ),
                    ),
                    Form(
                      key: _key,
                      child: Column(
                        children: [
                          _textFieldName(),
                          SizedBox(
                            height: 10,
                          ),
                          _textFieldPassword(),
                          SizedBox(
                            height: 10,
                          ),
                          textFieldEmail(isValid: state.isEmailValid, errorText: state.emailErrorText),
                        ],
                      ),
                    ),
                    Align(
                        alignment: Alignment.bottomCenter,
                        child: GestureDetector(
                            onTap: () {
                              _regBloc.add(RegWithCredentialsPressed(
                                  email: _controllerEmail.text,
                                  password: _controllerPassword.text,
                                  userData: UserData(
                                      email: _controllerEmail.text,
                                      name: _controllerName.text,
                                      favoriteWord: null)));
                              // Navigator.pushNamedAndRemoveUntil(context,
                              //     '/cardScreen', ModalRoute.withName('/'));
                              //
                            },
                            child: BlocBuilder(
                              bloc: _regBloc,
                              builder: (context, state) {
                                return _buttonCreate();
                              },
                            )))
                  ],
                ),
              ),
            );
          },
        ));
  }

  OutlineInputBorder outlineInputDecor(Color color) {
    return OutlineInputBorder(
      borderSide: BorderSide(color: color),
      borderRadius: borderRadius(),
    );
  }

  _buttonCreate() => Container(
        alignment: Alignment.center,
        height: 60,
        width: 200,
        decoration: BoxDecoration(
          gradient: gradientColor(),
          borderRadius: BorderRadius.all(Radius.circular(30.0)),
        ),
        child: Text(
          "Create an account",
          style: TextStyle(
              fontFamily: ('Futura'),
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: Colors.white),
        ),
      );

  _textFieldName() => TextField(
        autofocus: true,
        onSubmitted: (name) {
          print('hi');
          _focusNode.requestFocus();
        },
        decoration: InputDecoration(
          focusedBorder: outlineInputDecor(redColor()),
          enabledBorder: outlineInputDecor(greyLightColor()),
          contentPadding: EdgeInsets.only(left: 15),
          hintText: 'Name',
          hintStyle: TextStyle(color: greyLightColor()),
        ),
        autocorrect: true,
        maxLines: 1,
        enableSuggestions: true,
        cursorColor: redColor(),
        style: TextStyle(
          fontSize: 15,
          color: Colors.black,
        ),
        keyboardType: TextInputType.name,
        controller: _controllerName,
      );

  _textFieldPassword() => TextField(
        focusNode: _focusNode,
        onSubmitted: (password) {
          _focusNode.requestFocus();
          _focusNode.nextFocus();
        },
        decoration: InputDecoration(
          focusedBorder: outlineInputDecor(redColor()),
          enabledBorder: outlineInputDecor(greyLightColor()),
          contentPadding: EdgeInsets.only(left: 15),
          hintText: 'Password',
          hintStyle: TextStyle(color: greyLightColor()),
        ),
        autocorrect: true,
        maxLines: 1,
        enableSuggestions: true,
        cursorColor: redColor(),
        style: TextStyle(
          fontSize: 15,
          color: Colors.black,
        ),
        keyboardType: TextInputType.visiblePassword,
        controller: _controllerPassword,
      );

  textFieldEmail({required bool isValid,  String? errorText}) =>
      TextField(
        onSubmitted: (email) {
          _focusNode.consumeKeyboardToken();
          // _regBloc.add(RegWithCredentialsPressed(
          //     email: _controllerEmail.text,
          //     password: _controllerPassword.text,
          //     userData: UserData(
          //         email: _controllerEmail.text,
          //         name: _controllerName.text,
          //         favoriteWord: null)));
        },
        decoration: InputDecoration(
          focusedBorder: outlineInputDecor(redColor()),
          enabledBorder:
              outlineInputDecor(isValid ? greyLightColor() : Colors.red),
          contentPadding: EdgeInsets.only(left: 15),
          hintText: 'Email',
          hintStyle: TextStyle(color: greyLightColor()),
          focusedErrorBorder:  outlineInputDecor(isValid ? greyLightColor() : Colors.red),
          errorBorder:  outlineInputDecor(isValid ? greyLightColor() : Colors.red),
          errorText: errorText
        ),
        autocorrect: true,
        maxLines: 1,
        enableSuggestions: true,
        cursorColor: redColor(),
        style: TextStyle(
          fontSize: 15,
          color: Colors.black,
        ),
        keyboardType: TextInputType.emailAddress,
        controller: _controllerEmail,
      );
}
