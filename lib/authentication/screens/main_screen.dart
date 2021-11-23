import 'package:dictionary/authentication/bloc/auth_bloc/auth_bloc.dart';
import 'package:dictionary/authentication/bloc/auth_bloc/auth_event.dart';
import 'package:dictionary/authentication/bloc/auth_bloc/auth_state.dart';
import 'package:dictionary/authentication/screens/auth_screen.dart';
import 'package:dictionary/authentication/service/firebase_auth_service.dart';
import 'package:dictionary/main_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomeScreen extends StatelessWidget {
  final UserRepositoryImpl _userRepository;

  HomeScreen({Key? key, required UserRepositoryImpl userRepository})
      : _userRepository = userRepository,
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AuthBloc, AuthState>(
      bloc: AuthBloc(userRepository: _userRepository)..add(AuthStarted()),
      builder: (context, state) {
        if (state is AuthFailed) {
          print('failed');
          return IntroductionScreen();
        }

        if (state is AuthOnSuccess) {
          print('success');
          return MainScreen();
        }

        return Container();
      },
    );
  }
}
