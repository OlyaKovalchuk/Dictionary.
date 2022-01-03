import 'package:Dictionary/authentication/bloc/login_bloc/login_event.dart';
import 'package:Dictionary/authentication/bloc/login_bloc/login_state.dart';
import 'package:Dictionary/authentication/service/firebase_auth_service.dart';
import 'package:Dictionary/authentication/utils/firebase_exceptions_valid.dart';
import 'package:Dictionary/authentication/utils/validators.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  final UserRepository _userRepository;

  LoginBloc(UserRepository userRepository)
      : _userRepository = userRepository,
        super(LoginState.initial());

  Stream<LoginState> mapEventToState(LoginEvent event) async* {
    if (event is LoginWithCredentialsPressed) {
      yield* _mapLoginWithCredentialsPressedToState(
          password: event.password, email: event.email);
    } else if (event is LoginWithGoogle) {
      yield* _mapLoginWithGoogleToState();
    } else if (event is LoginWithFacebook) {
      yield* _mapLoginWithFacebookToState();
    } else if (event is LoginPasswordChange) {
      yield* _mapLoginPasswordChangeToState(event.password);
    } else if (event is LoginEmailChange) {
      yield* _mapLoginEmailChangeToState(event.email);
    }
  }

  Stream<LoginState> _mapLoginEmailChangeToState(String email) async* {
    yield state.update(isEmailValid: Validators.isValidEmail(email));
  }

  Stream<LoginState> _mapLoginPasswordChangeToState(String password) async* {
    yield state.update(isPasswordValid: Validators.isValidPassword(password));
  }

  Stream<LoginState> _mapLoginWithCredentialsPressedToState(
      {required String password, required String email}) async* {
    yield LoginState.loading();
    try {
      await _userRepository.signInWithCredentials(email, password);
      yield LoginState.success();
    } on FirebaseAuthException catch (e) {
      checkError(e.toString());
      print('Error auth: ${e.code}');
      yield LoginState.failure(checkError(e.code));
    }
  }

  Stream<LoginState> _mapLoginWithGoogleToState() async* {
    yield LoginState.loading();
    try {
      await _userRepository.signInWithGoogle();
      yield LoginState.success();
    } on FirebaseAuthException catch (e) {
      print('Error auth: $e');
      checkError(e.toString());
      yield LoginState.failure(checkError(e.toString()));
    }
  }

  Stream<LoginState> _mapLoginWithFacebookToState() async* {
    yield LoginState.loading();
    try {
      await _userRepository.signInWithFacebook();
      yield LoginState.success();
    } on FirebaseAuthException catch (e) {
      checkError(e.code);
      print('Error auth: $e');
      yield LoginState.failure(checkError(e.toString()));
    } catch (e) {
      yield LoginState.failure(checkError(e.toString()));
    }
  }
}
