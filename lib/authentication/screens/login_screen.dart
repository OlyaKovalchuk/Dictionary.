import 'package:Dictionary/widgets/app_bar.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:Dictionary/authentication/bloc/login_bloc/login_bloc.dart';
import '../bloc/login_bloc/login_event.dart';
import '../bloc/login_bloc/login_state.dart';
import 'introduction_screen.dart';
import '../service/firebase_auth_service.dart';
import '../utils/validators.dart';
import '../widgets/auth_widgets.dart';
import '../widgets/text_fields.dart';
import '../../main_screen.dart';
import '../../search/utils/error_output.dart';
import '../widgets/title_text.dart';

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _controllerEmail = TextEditingController();
  final _controllerPassword = TextEditingController();
  final LoginBloc _loginBloc = LoginBloc(UserRepositoryImpl());
  final _key = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return BlocConsumer(
      bloc: _loginBloc,
      listener: (context, LoginState state) {
        if (state.isFailure) {
          return errorOutput(error: state.errorText!, context: context);
        }
      },
      builder: (context, LoginState state) {
        if (state.isSuccess && FirebaseAuth.instance.currentUser != null) {
          return MainScreen();
        }

        return Scaffold(
            resizeToAvoidBottomInset: false,
            appBar: AppBarBuilder(
              leading: GestureDetector(
                  onTap: () => Navigator.pushAndRemoveUntil(
                      context,
                      MaterialPageRoute(
                          builder: (context) => IntroductionScreen()),
                      (route) => false),
                  child: Icon(
                    Icons.arrow_back_ios_rounded,
                    color: Colors.white,
                  )),
            ),
            body: Padding(
              padding: const EdgeInsets.symmetric(vertical: 50, horizontal: 20),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(children: [
                    TextTitleBuilder(
                        text: 'Log in',
                        fontSize: 30,
                        fontWeight: FontWeight.normal),
                    const SizedBox(
                      height: 30,
                    ),
                    EmailAndPasswordForm(
                      globalKey: _key,
                      controllerEmail: _controllerEmail,
                      controllerPassword: _controllerPassword,
                    ),
                  ]),
                  LoginButtons(
                      globalKey: _key,
                      controllerEmail: _controllerEmail,
                      controllerPassword: _controllerPassword,
                      loginBloc: _loginBloc)
                ],
              ),
            ));
      },
    );
  }
}

class EmailAndPasswordForm extends StatelessWidget {
  final TextEditingController controllerEmail;
  final TextEditingController controllerPassword;
  final _focusNode = FocusNode();
  final GlobalKey<FormState> globalKey;

  EmailAndPasswordForm(
      {Key? key,
      required this.globalKey,
      required this.controllerEmail,
      required this.controllerPassword})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Form(
      key: globalKey,
      child: Column(
        children: [
          TextFieldBuilder(
            focusNode: _focusNode,
            controller: controllerEmail,
            textInputType: TextInputType.emailAddress,
            hint: 'Email',
            onSubmit: (email) {
              _focusNode.requestFocus();
              _focusNode.nextFocus();
            },
            validator: (String? email) => Validators.validEmail(email),
          ),
          const SizedBox(
            height: 15,
          ),
          TextFieldBuilder(
              validator: (password) => Validators.validPassword(password),
              controller: controllerPassword,
              textInputType: TextInputType.visiblePassword,
              hint: 'Password',
              onSubmit: (password) {
                _focusNode.consumeKeyboardToken();
              }),
        ],
      ),
    );
  }
}

class LoginButtons extends StatelessWidget {
  final TextEditingController controllerEmail;
  final TextEditingController controllerPassword;
  final GlobalKey<FormState> globalKey;
  final LoginBloc loginBloc;

  LoginButtons(
      {Key? key,
      required this.globalKey,
      required this.controllerEmail,
      required this.controllerPassword,
      required this.loginBloc})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.bottomCenter,
      child: AuthButtons(
        onTapSign: () {
          if (globalKey.currentState!.validate()) {
            loginBloc.add(LoginWithCredentialsPressed(
                password: controllerPassword.text,
                email: controllerEmail.text));
          }
        },
        onTapSignWithGoogle: () {
          loginBloc.add(LoginWithGoogle());
        },
        onTapSignWithFacebook: () {
          loginBloc.add(LoginWithFacebook());
        },
        isRegistrationOrLogin: false,
      ),
    );
  }
}
