import 'package:Dictionary/theme/theme_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

String _isRegistrationOrLogin(bool isRegistrationOrLogin) =>
    isRegistrationOrLogin ? 'Sign up' : 'Log in';

class AuthButtons extends StatelessWidget {
  final void Function() onTapSign;
  final void Function() onTapSignWithGoogle;
  final void Function() onTapSignWithFacebook;
  final bool isRegistrationOrLogin;

  AuthButtons(
      {Key? key,
      required this.onTapSign,
      required this.onTapSignWithGoogle,
      required this.onTapSignWithFacebook,
      required this.isRegistrationOrLogin})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.bottomCenter,
      child: Align(
        alignment: Alignment.bottomCenter,
        child: Column(
          children: [
            ButtonSign(
                onTap: onTapSign,
                textOfButton: _isRegistrationOrLogin(isRegistrationOrLogin)),
            const SizedBox(
              height: 15,
            ),
            LineOr(),
            const SizedBox(
              height: 15,
            ),
            ButtonSignWithGoogleOrFacebook(
              onTap: onTapSignWithGoogle,
              textOfButton:
                  _isRegistrationOrLogin(isRegistrationOrLogin) + ' Google',
              image: Image.asset(
                'assets/icons/icon_google.png',
                width: 20,
                height: 20,
              ),
            ),
            const SizedBox(
              height: 15,
            ),
            ButtonSignWithGoogleOrFacebook(
              onTap: onTapSignWithFacebook,
              textOfButton:
                  _isRegistrationOrLogin(isRegistrationOrLogin) + ' Facebook',
              image: SvgPicture.asset(
                'assets/icons/icon_facebook.svg',
                width: 25,
                height: 25,
              ),
            )
          ],
        ),
      ),
    );
  }
}

class ButtonSign extends StatelessWidget {
  final void Function() onTap;
  final String textOfButton;

  const ButtonSign({Key? key, required this.onTap, required this.textOfButton})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
        onTap: onTap,
        child: Container(
          alignment: Alignment.center,
          height: 56,
          width: 236,
          decoration: BoxDecoration(
            gradient: gradientColor,
            borderRadius: BorderRadius.all(Radius.circular(30.0)),
          ),
          child: Text(textOfButton, style: Theme.of(context).textTheme.button),
        ));
  }
}

class ButtonSignWithGoogleOrFacebook extends StatelessWidget {
  final void Function() onTap;
  final String textOfButton;
  final Widget image;

  ButtonSignWithGoogleOrFacebook(
      {Key? key,
      required this.onTap,
      required this.textOfButton,
      required this.image})
      : super();

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
        onTap: onTap,
        child: Container(
          alignment: Alignment.center,
          height: 56,
          width: 236,
          decoration: BoxDecoration(
            border: Border.all(color: greyColor),
            borderRadius: BorderRadius.all(Radius.circular(30.0)),
          ),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisSize: MainAxisSize.min,
            children: [
              image,
              SizedBox(
                width: 10,
              ),
              Text(
                textOfButton,
                style: Theme.of(context)
                    .textTheme
                    .button!
                    .copyWith(color: greyDarkColor, fontSize: 17),
              ),
            ],
          ),
        ));
  }
}

class DividerBuild extends StatelessWidget {
  const DividerBuild({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
        height: 1,
        width: MediaQuery.of(context).size.width / 2.5,
        color: greyColor);
  }
}

class LineOr extends StatelessWidget {
  const LineOr({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      width: double.infinity,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisSize: MainAxisSize.max,
        children: [
          DividerBuild(),
          Text(
            'OR',
            style: TextStyle(
              fontSize: 15,
              fontWeight: FontWeight.w400,
              foreground: gradientTextColor,
            ),
          ),
          DividerBuild(),
        ],
      ),
    );
  }
}
