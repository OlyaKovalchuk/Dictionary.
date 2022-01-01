import 'package:Dictionary/authentication/screens/login_screen.dart';
import 'package:Dictionary/profile/bloc/profile_bloc.dart';
import 'package:Dictionary/profile/bloc/profile_event.dart';
import 'package:Dictionary/profile/bloc/profile_state.dart';
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
  @override
  Widget build(BuildContext context) {
    return BlocBuilder(
      bloc: BlocProvider.of<ProfileBloc>(context)..add(GetUser()),
      builder: (context, state) {
        if (state is LoadingProfile) {
          return _buildCircularIndicator();
        } else if (state is SuccessProfile) {
          return _buildUserData(state);
        } else if (state is ErrorProfile) {}

        return _buildCircularIndicator();
      },
    );
  }

  _buildCircularIndicator() => Container(
        child: indicatorCircular(),
      );

  _buildUserData(ProfileState state) => Padding(
        padding: EdgeInsets.only(
            top: 50.0, bottom: MediaQuery.of(context).size.height / 6),
        child: Center(
          child: Column(
            children: [
              CircleAvatar(
                radius: 50.0,
                backgroundColor: Colors.transparent,
                backgroundImage: NetworkImage(
                    BlocProvider.of<ProfileBloc>(context).userData!.photoURL +
                        '?width=9999'),
              ),
              SizedBox(
                height: 50,
              ),
              Text(
                BlocProvider.of<ProfileBloc>(context).userData!.name,
                style: TextStyle(
                    fontFamily: 'Futura',
                    fontSize: 20,
                    color: greyColor(),
                    fontWeight: FontWeight.bold),
              ),
              Spacer(),
              buildGradientButton(
                  onTap: () async {
                    BlocProvider.of<ProfileBloc>(context).add(SingOut());
                    Navigator.pushAndRemoveUntil(
                        context,
                        MaterialPageRoute(builder: (context) => LoginScreen()),
                        (route) => false);
                  },
                  title: 'Sing out'),
            ],
          ),
        ),
      );
}
