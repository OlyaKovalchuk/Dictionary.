import 'package:Dictionary/authentication/bloc/registration_bloc/reg_event.dart';
import 'package:Dictionary/authentication/bloc/registration_bloc/reg_states.dart';
import 'package:Dictionary/authentication/service/firebase_auth_service.dart';
import 'package:Dictionary/authentication/utils/firebase_exceptions_valid.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class RegBloc extends Bloc<RegEvent, RegState> {
  final UserRepository _userRepository;

  RegBloc(UserRepository userRepository)
      : _userRepository = userRepository,
        super(RegState.initial());

  Stream<RegState> mapEventToState(RegEvent event) async* {
    if (event is RegWithCredentialsPressed) {
      yield* _mapRegWithCredentialsPressedToState(
        password: event.password,
        email: event.email,
        name: event.name,
      );
    } else if (event is RegWithGoogle) {
      yield* _mapRegWithGoogleToState();
    } else if (event is RegWithFacebook) {
      yield* _mapRegWithFacebookToState();
    }
  }

  Stream<RegState> _mapRegWithCredentialsPressedToState(
      {required String password,
      required String email,
      required String name}) async* {
    yield RegState.loading();
    try {
      await _userRepository.singUp(email: email,password:  password, name: name);

      yield RegState.success();
    } on FirebaseAuthException catch (e) {
      print(e.code);
      checkError(e.code);
      yield RegState.failure().copyWith(passwordErrorText: e.code);
    }
  }

  Stream<RegState> _mapRegWithGoogleToState() async* {
    yield RegState.loading();
    try {
      await _userRepository.signInWithGoogle();
      yield RegState.success();
    } on FirebaseAuthException catch (e) {
      checkError(e.code);
      yield RegState.failure().copyWith(passwordErrorText: e.code);
    }
  }

  Stream<RegState> _mapRegWithFacebookToState() async* {
    yield RegState.loading();
    try {
      await _userRepository.signInWithFacebook();
      yield RegState.success();
    } on FirebaseAuthException catch (e) {
      checkError(e.code);
      yield RegState.failure().copyWith(passwordErrorText: e.code);
    }
  }
}
