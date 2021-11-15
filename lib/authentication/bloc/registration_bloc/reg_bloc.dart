import 'package:Dictionary/authentication/bloc/registration_bloc/reg_event.dart';
import 'package:Dictionary/authentication/bloc/registration_bloc/reg_states.dart';
import 'package:Dictionary/authentication/model/user_data_model.dart';
import 'package:Dictionary/authentication/repository/user_repository.dart';
import 'package:Dictionary/authentication/service/firebase_auth_service.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class RegBloc extends Bloc<RegEvent, RegState> {
  final UserRepository _userRepository;
  final  _fireUsersDataRepo = FireUsersDataRepo();

  RegBloc(UserRepository userRepository)
      : _userRepository = userRepository,
        super(RegState.initial());

  Stream<RegState> mapEventToState(RegEvent event) async* {
    if (event is RegWithCredentialsPressed) {
      yield* _mapRegWithCredentialsPressedToState(
          password: event.password, email: event.email, userData: event.userData,);
    }
  }

  // Stream<RegState> _mapLoginEmailChangeToState(String email) async* {
  //   yield state.update(isEmailValid: Validators.isValidEmail(email));
  // }
  //
  // Stream<RegState> _mapLoginPasswordChangeToState(String password) async* {
  //   yield state.update(isPasswordValid: Validators.isValidPassword(password));
  // }

  Stream<RegState> _mapRegWithCredentialsPressedToState(
      {required String password, required String email, required UserData userData}) async* {
    yield RegState.loading();
    try {
      await _userRepository.singUp(email, password);
      await _fireUsersDataRepo.setUser(userData);
      yield RegState.success();
    } catch (e) {
      print('Error auth: $e');
      yield RegState.failure();
    }
  }
}
