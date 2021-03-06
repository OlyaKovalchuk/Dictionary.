import 'package:Dictionary/authentication/model/user_data_model.dart';
import 'package:Dictionary/authentication/screens/login_screen.dart';
import 'package:Dictionary/cards/views/error_view.dart';
import 'package:Dictionary/cards/widgets/card_decoration/indicator_decoration.dart';
import 'package:Dictionary/profile/bloc/profile_bloc.dart';
import 'package:Dictionary/profile/bloc/profile_event.dart';
import 'package:Dictionary/profile/bloc/profile_state.dart';
import 'package:Dictionary/authentication/widgets/button_gradient.dart';
import 'package:Dictionary/theme/theme_colors.dart';
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
          return IndicatorCircular();
        } else if (state is SuccessProfile) {
          return UserInfoBuilder();
        } else if (state is ErrorProfile) {
          return ErrorView();
        }

        return IndicatorCircular();
      },
    );
  }
}

class UserInfoBuilder extends StatelessWidget {
  const UserInfoBuilder({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    UserData _userData = BlocProvider.of<ProfileBloc>(context).userData!;
    return Padding(
      padding: EdgeInsets.only(
          top: 50.0, bottom: MediaQuery.of(context).size.height / 6),
      child: Center(
        child: Column(
          children: [
            CircleAvatar(
              radius: 50.0,
              backgroundColor: Colors.transparent,
              backgroundImage: NetworkImage(_userData.photoURL + '?width=9999'),
            ),
            const SizedBox(
              height: 50,
            ),
            Text(
              _userData.name,
              style: Theme.of(context)
                  .textTheme
                  .bodyText2!
                  .copyWith(fontSize: 20, color: greyDarkColor),
            ),
            const Spacer(),
            GradientButtonBuilder(
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
}
