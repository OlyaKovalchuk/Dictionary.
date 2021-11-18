import 'package:Dictionary/authentication/bloc/login_bloc/login_event.dart';
import 'package:Dictionary/authentication/bloc/login_bloc/login_state.dart';
import 'package:Dictionary/authentication/service/firebase_auth_service.dart';
import 'package:Dictionary/authentication/utils/validators.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class LoginBloc extends Bloc<RegEvent, LoginState> {
  final UserRepositoryImpl _userRepository;

  LoginBloc(UserRepositoryImpl userRepository)
      : _userRepository = userRepository,
        super(LoginState.initial());

  Stream<LoginState> mapEventToState(RegEvent event) async* {
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
    } catch (e) {
      print('Error auth: $e');
      yield LoginState.failure();
    }
  }

  Stream<LoginState> _mapLoginWithGoogleToState() async* {
    yield LoginState.loading();
    try {
      await _userRepository.signInWithGoogle();
      yield LoginState.success();
    } catch (e) {
      print('Error auth: $e');
      yield LoginState.failure();
    }
  }

  Stream<LoginState> _mapLoginWithFacebookToState() async* {
    yield LoginState.loading();
    try {
      await _userRepository.signInWithFacebook();
      yield LoginState.success();
    } catch (e) {
      print('Error auth: $e');
      yield LoginState.failure();
    }
  }
}
