import 'package:dictionary/authentication/bloc/registration_bloc/reg_bloc.dart';
import 'package:dictionary/authentication/bloc/registration_bloc/reg_event.dart';
import 'package:dictionary/authentication/bloc/registration_bloc/reg_states.dart';
import 'package:dictionary/authentication/service/firebase_auth_service.dart';
import 'package:dictionary/authentication/utils/validators.dart';
import 'package:dictionary/authentication/widgets/auth_widgets.dart';
import 'package:dictionary/cards/screen/card_screen.dart';
import 'package:dictionary/widgets/appBar.dart';
import 'package:dictionary/authentication/widgets/textFields.dart';
import 'package:dictionary/widgets/titileText.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({Key? key}) : super(key: key);

  @override
  _RegisterScreenState createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  RegBloc _regBloc = RegBloc(UserRepositoryImpl());
  final _key = GlobalKey<FormState>();
  final _controllerName = TextEditingController();
  final _controllerPassword = TextEditingController();
  final _controllerEmail = TextEditingController();
  final _focusNode = FocusNode();

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<RegBloc, RegState>(
      bloc: _regBloc,
      builder: (context, state) {
        if (_key.currentState?.validate() != null &&
            _key.currentState!.validate()) {
          if (state.isSuccess == true) {
            return CardScreen();
          }
        }
        if (state.isFailure == true) {
          if (state.passwordErrorText != null) {
            return SnackBar(content: Text(state.passwordErrorText!));
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
            padding: const EdgeInsets.symmetric(vertical: 50, horizontal: 20),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                buildTitleText(text: 'Create a new account', fontSize: 30),
                Form(
                  key: _key,
                  child: Column(
                    children: [
                      buildTextField(
                        controller: _controllerName,
                        textInputType: TextInputType.text,
                        hint: 'Name',
                        onSubmit: (name) {
                          _focusNode.requestFocus();
                        },
                        validator: (String? name) => Validators.validName(name),
                      ),
                      SizedBox(
                        height: 15,
                      ),
                      buildTextField(
                        focusNode: _focusNode,
                        controller: _controllerPassword,
                        errorText: state.passwordErrorText,
                        textInputType: TextInputType.visiblePassword,
                        hint: 'Password',
                        onSubmit: (password) {
                          _focusNode.requestFocus();
                          _focusNode.nextFocus();
                        },
                        validator: (String? password) =>
                            Validators.validPassword(password),
                      ),
                      SizedBox(
                        height: 15,
                      ),
                      buildTextField(
                        controller: _controllerEmail,
                        errorText: state.emailErrorText,
                        textInputType: TextInputType.emailAddress,
                        hint: 'Email',
                        onSubmit: (email) {
                          _focusNode.consumeKeyboardToken();
                        },
                        validator: (String? email) =>
                            Validators.validEmail(email),
                      )
                    ],
                  ),
                ),
                Align(
                  alignment: Alignment.bottomCenter,
                  child: buildAuthButtons(
                      onTapSign: () {
                        _regBloc.add(RegWithCredentialsPressed(
                            name: _controllerName.text,
                            email: _controllerEmail.text,
                            password: _controllerPassword.text));
                      },
                      onTapSignWithGoogle: () {
                        _regBloc.add(RegWithGoogle());
                      },
                      onTapSignWithFacebook: () {
                        _regBloc.add(RegWithFacebook());
                      },
                      isRegistrationOrLogin: true,
                      context: context),
                )
              ],
            ),
          ),
        );
      },
    );
  }
}
