import 'package:Dictionary/blocs/auth_bloc/auth_bloc.dart';
import 'package:Dictionary/blocs/auth_bloc/auth_event.dart';
import 'package:Dictionary/blocs/auth_bloc/auth_state.dart';
import 'package:Dictionary/screens/auth_screen.dart';
import 'package:Dictionary/service/firebase_auth_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'card_screen.dart';

class HomeScreen extends StatelessWidget {
  final UserRepository _userRepository;

  HomeScreen({Key? key, required UserRepository userRepository})
      : _userRepository = userRepository,
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return   BlocBuilder<AuthBloc, AuthState>(
                bloc: AuthBloc(userRepository: _userRepository)
                  ..add(AuthStarted()),
                builder: (context, state) {
                  if (state is AuthFailed) {
                    print('failed');
                    return AuthScreen();
                  }

                  if (state is AuthOnSuccess) {
                    print('success');
                    return CardScreen(
                      user: state.user,
                    );
                  }

                  return Container();
                },
          );
  }
}
