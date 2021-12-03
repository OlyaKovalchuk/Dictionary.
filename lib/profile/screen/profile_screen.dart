import 'package:Dictionary/authentication/service/firebase_auth_service.dart';
import 'package:Dictionary/profile/bloc/profile_bloc.dart';
import 'package:Dictionary/profile/bloc/profile_event.dart';
import 'package:Dictionary/profile/bloc/profile_state.dart';
import 'package:Dictionary/profile/profile_service.dart';
import 'package:Dictionary/widgets/button_gradient.dart';
import 'package:Dictionary/widgets/cardDecoration/indicator_decoration.dart';
import 'package:Dictionary/widgets/colors/grey_color.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ProfileScreen extends StatefulWidget {
  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  final ProfileBloc _profileBloc = ProfileBloc(ProfileServiceImpl());
  @override
  void initState() {
    super.initState();
    _profileBloc.add(GetUser());
  }
UserRepositoryImpl _userRepositoryImpl = UserRepositoryImpl();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocBuilder(
        bloc: _profileBloc,
        builder: (context, state) {
          if (state is LoadingProfile) {
            return _buildCircularIndicator();
          } else if (state is SuccessProfile) {
            return _buildUserData();
          } else if (state is ErrorProfile) {}
          return Container(
            child: Text('Empty'),
          );
        },
      ),
    );
  }

  _buildCircularIndicator() => Container(
        child: indicatorCircular(),
      );

  _buildUserData() => Padding(
        padding:  EdgeInsets.only(top: 50.0, bottom: MediaQuery.of(context).size.height/6),
        child: Center(
          child: Column(
            children: [
              CircleAvatar(
                radius: 50.0,
                backgroundColor: Colors.transparent,
                backgroundImage:
                    NetworkImage(_profileBloc.user!.photoURL + '?width=9999'),
              ),
              SizedBox(
                height: 50,
              ),
              Text(
                _profileBloc.user!.name,
                style: TextStyle(
                    fontFamily: 'Futura',
                    fontSize: 20,
                    color: greyColor(),
                    fontWeight: FontWeight.bold),
              ),
              Spacer(),
              buildGradientButton(
                  onTap: ()async {
                   _userRepositoryImpl.signOut();
                    print(_profileBloc.user);
                   Navigator.pushNamed(context, '/loginScreen');
                  },
                  title: 'Sing out'),
            ],
          ),
        ),
      );
}
