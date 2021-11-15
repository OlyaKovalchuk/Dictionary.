import 'package:Dictionary/authentication/bloc/login_bloc/login_event.dart';
import 'package:Dictionary/authentication/bloc/login_bloc/login_state.dart';
import 'package:Dictionary/authentication/service/firebase_auth_service.dart';
import 'package:Dictionary/utils/validators.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class LoginBloc extends Bloc<RegEvent, RegState> {
  final UserRepository _userRepository;

  LoginBloc(UserRepository userRepository)
      : _userRepository = userRepository,
        super(RegState.initial());

  Stream<RegState> mapEventToState(RegEvent event) async* {
    if (event is LoginEmailChange) {
      yield* _mapLoginEmailChangeToState(event.email);
    } else if (event is LoginPasswordChange) {
      yield* _mapLoginPasswordChangeToState(event.password);
    } else if (event is LoginWithCredentialsPressed) {
      yield* _mapLoginWithCredentialsPressedToState(
          password: event.password, email: event.email);
    }
  }

  Stream<RegState> _mapLoginEmailChangeToState(String email) async* {
    yield state.update(isEmailValid: Validators.isValidEmail(email));
  }

  Stream<RegState> _mapLoginPasswordChangeToState(String password) async* {
    yield state.update(isPasswordValid: Validators.isValidPassword(password));
  }

  Stream<RegState> _mapLoginWithCredentialsPressedToState(
      {required String password, required String email}) async* {
    yield RegState.loading();
    try {
      await _userRepository.signInWithCredentials(email, password);
      yield RegState.success();
    } catch (e) {
      print('Error auth: $e');
      yield RegState.failure();
    }
  }
}
