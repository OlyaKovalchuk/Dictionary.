import 'package:Dictionary/authentication/bloc/auth_bloc/auth_bloc.dart';
import 'package:Dictionary/authentication/bloc/auth_bloc/auth_event.dart';
import 'package:Dictionary/authentication/bloc/auth_bloc/auth_state.dart';
import 'package:Dictionary/authentication/screens/introduction_screen.dart';
import 'package:Dictionary/authentication/service/firebase_auth_service.dart';
import 'package:Dictionary/main_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomeScreen extends StatelessWidget {
  final UserRepository _userRepository;

  HomeScreen({Key? key, required UserRepository userRepository})
      : _userRepository = userRepository,
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AuthBloc, AuthState>(
      bloc: AuthBloc(userRepository: _userRepository)..add(AuthStarted()),
      builder: (context, state) {
        if (state is AuthFailed) {
          return IntroductionScreen();
        }

        if (state is AuthOnSuccess) {
          return MainScreen();
        }

        return Container();
      },
    );
  }
}
