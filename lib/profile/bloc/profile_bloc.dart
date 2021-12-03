import 'package:Dictionary/authentication/model/user_data_model.dart';
import 'package:Dictionary/profile/bloc/profile_event.dart';
import 'package:Dictionary/profile/bloc/profile_state.dart';
import 'package:Dictionary/profile/profile_service.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ProfileBloc extends Bloc<ProfileEvent, ProfileState> {
  ProfileBloc(this.profileService) : super(EmptyProfile());
  UserData? user;
  final ProfileService profileService;

  Stream<ProfileState> mapEventToState(ProfileEvent event) async* {
    if (event is GetUser) {
      yield* getUserEventToState();
    } else if (event is SingOut) {
      yield* singOutEventToState();
    }
    LoadingProfile();
  }

  Stream<ProfileState> getUserEventToState() async* {
    try {
      user = await profileService.getUserData();
      print(user);
      yield SuccessProfile();
    } on FirebaseException catch (error) {
      print(error);
      yield ErrorProfile();
    }
  }

  Stream<ProfileState> singOutEventToState() async* {
    try {
      await profileService.singOut();
      yield SuccessProfile();
    } on FirebaseException catch (e) {
      print(e);
      yield ErrorProfile();
    }
  }
}
