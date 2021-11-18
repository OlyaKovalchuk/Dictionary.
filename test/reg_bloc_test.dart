import 'package:Dictionary/authentication/bloc/registration_bloc/reg_states.dart';
import 'package:Dictionary/authentication/bloc/registration_bloc/reg_bloc.dart';
import 'package:Dictionary/authentication/bloc/registration_bloc/reg_event.dart';
import 'package:flutter_test/flutter_test.dart';
import 'UserRepositoryFake.dart';

void main() {
  test("Correct state is returned for invalid email", () {
    final UserRepositoryFake userRepositoryFake = UserRepositoryFake();
    userRepositoryFake.shouldSignUpFail = false;


    final regBloc = RegBloc(userRepositoryFake);

    final loadingState = RegState.loading();
    final expectedState = RegState.success();
    final event = RegWithCredentialsPressed(
      name: '',
        email: "",
        password: "",);

    expect(regBloc.mapEventToState(event), emitsInAnyOrder([loadingState, expectedState]));
  });
}
