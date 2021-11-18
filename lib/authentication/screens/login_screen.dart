import 'package:Dictionary/authentication/bloc/login_bloc/login_bloc.dart';
import 'package:Dictionary/authentication/bloc/login_bloc/login_event.dart';
import 'package:Dictionary/authentication/bloc/login_bloc/login_state.dart';
import 'package:Dictionary/authentication/service/firebase_auth_service.dart';
import 'package:Dictionary/authentication/utils/validators.dart';
import 'package:Dictionary/authentication/widgets/auth_widgets.dart';
import 'package:Dictionary/authentication/widgets/textFields.dart';
import 'package:Dictionary/cards/card_screen.dart';
import 'package:Dictionary/widgets/appBar.dart';
import 'package:Dictionary/widgets/titileText.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class LoginScreen extends StatefulWidget {
  final UserRepositoryImpl userRepository;

  LoginScreen({required this.userRepository});

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _controllerEmail = TextEditingController();
  final _controllerPassword = TextEditingController();
  final LoginBloc _loginBloc = LoginBloc(UserRepositoryImpl());
  final _focusNode = FocusNode();
  final _key = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<LoginBloc, LoginState>(
        bloc: _loginBloc,
        builder: (context, state) {
          if (_key.currentState?.validate() != null &&
              _key.currentState!.validate()) {
            if (state.isSuccess == true) {
              return CardScreen();
            }
          }
          return Scaffold(
              resizeToAvoidBottomInset: false,
              appBar: buildAppBar(
                  leading: GestureDetector(
                      onTap: () => Navigator.pop(context),
                      child: Icon(
                        Icons.arrow_back_ios_rounded,
                        color: Colors.white,
                      )),
                  actions: null),
              body: Padding(
                padding:
                    const EdgeInsets.symmetric(vertical: 50, horizontal: 20),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(children: [
                      buildTitleText(
                          text: 'Log in',
                          fontSize: 30,
                          fontWeight: FontWeight.normal),
                      SizedBox(
                        height: 30,
                      ),
                      Form(
                        key: _key,
                        child: Column(
                          children: [
                            buildTextField(
                              focusNode: _focusNode,
                              controller: _controllerEmail,
                              errorText: state.emailErrorText,
                              textInputType: TextInputType.emailAddress,
                              hint: 'Email',
                              onSubmit: (email) {
                                _focusNode.requestFocus();
                                _focusNode.nextFocus();
                              },
                              validator: (String? email) =>
                                  Validators.validEmail(email),
                            ),
                            SizedBox(
                              height: 15,
                            ),
                            buildTextField(
                                validator: (password) =>
                                    Validators.validPassword(password),
                                controller: _controllerPassword,
                                errorText: state.passwordErrorText,
                                textInputType: TextInputType.visiblePassword,
                                hint: 'Password',
                                onSubmit: (password) {
                                  _focusNode.consumeKeyboardToken();
                                }),
                          ],
                        ),
                      ),
                    ]),
                    Align(
                      alignment: Alignment.bottomCenter,
                      child: buildAuthButtons(
                          onTapSign: () {
                            _loginBloc.add(LoginWithCredentialsPressed(
                                password: _controllerPassword.text,
                                email: _controllerEmail.text));
                          },
                          onTapSignWithGoogle: () {
                            _loginBloc.add(LoginWithGoogle());
                          },
                          onTapSignWithFacebook: () {
                            _loginBloc.add(LoginWithFacebook());
                          },
                          isRegistrationOrLogin: false,
                          context: context),
                    )
                  ],
                ),
              ));
        });
  }
}
