import 'package:Dictionary/authentication/bloc/auth_bloc/auth_event.dart';
import 'package:Dictionary/authentication/bloc/auth_bloc/auth_state.dart';
import 'package:Dictionary/authentication/service/firebase_auth_service.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final UserRepositoryImpl _userRepository;

  AuthBloc({required UserRepositoryImpl userRepository})
      : _userRepository = userRepository,
        super(AuthInitial());

  @override
  Stream<AuthState> mapEventToState(AuthEvent event) async* {
    if (event is AuthStarted) {
      yield* _mapAuthStarted();
    } else if (event is AuthLoggedIn) {
      yield* _mapAuthLoggedIn();
    }
  }



  Stream<AuthState> _mapAuthLoggedIn() async* {
    yield AuthOnSuccess(user: await _userRepository.getUser());
  }

  Stream<AuthState> _mapAuthStarted() async* {
    final isSignedIn = await _userRepository.isSignedIn();
    if (isSignedIn) {
      final user = await _userRepository.getUser();
      print(user);
      yield AuthOnSuccess(user: user);
    } else {
      yield AuthFailed();
    }
  }
}
