import 'package:Dictionary/theme/theme_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

String _isRegistrationOrLogin(bool isRegistrationOrLogin) =>
    isRegistrationOrLogin ? 'Sign up' : 'Log in';

Widget buildAuthButtons(
        {required void onTapSign()?,
        required void onTapSignWithGoogle()?,
        required void onTapSignWithFacebook()?,
        required bool isRegistrationOrLogin,
        required BuildContext context}) =>
    Container(
      //height:  MediaQuery.of(context).size.height,
      alignment: Alignment.bottomCenter,
      child: Align(
        alignment: Alignment.bottomCenter,
        child: Column(
          children: [
            _buttonSign(
                context: context,
                onTap: onTapSign,
                textOfButton: _isRegistrationOrLogin(isRegistrationOrLogin)),
            SizedBox(
              height: 15,
            ),
            _lineOr(context),
            SizedBox(
              height: 15,
            ),
            Column(
              children: [
                _buttonSignWithGoogleOrFacebook(
                  context: context,
                  onTap: onTapSignWithGoogle,
                  textOfButton:
                      _isRegistrationOrLogin(isRegistrationOrLogin) + ' Google',
                  image: Image.asset(
                    'assets/icons/icon_google.png',
                    width: 20,
                    height: 20,
                  ),
                ),
                SizedBox(
                  height: 15,
                ),
                _buttonSignWithGoogleOrFacebook(
                  context: context,
                  onTap: onTapSignWithFacebook,
                  textOfButton: _isRegistrationOrLogin(isRegistrationOrLogin) +
                      ' Facebook',
                  image: SvgPicture.asset(
                    'assets/icons/icon_facebook.svg',
                    width: 25,
                    height: 25,
                  ),
                )
              ],
            ),
          ],
        ),
      ),
    );

_buttonSign({
  required void onTap()?,
  required String textOfButton,
  required BuildContext context
}) =>
    GestureDetector(
        onTap: onTap,
        child: Container(
          alignment: Alignment.center,
          height: 56,
          width: 236,
          decoration: BoxDecoration(
            gradient: gradientColor,
            borderRadius: BorderRadius.all(Radius.circular(30.0)),
          ),
          child: Text(
            textOfButton,
            style: Theme.of(context).textTheme.button
          ),
        ));

_buttonSignWithGoogleOrFacebook(
        {required void onTap()?,
        required String textOfButton,
        required Widget image, required BuildContext context}) =>
    GestureDetector(
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
                style: Theme.of(context).textTheme.button!.copyWith(color: greyDarkColor, fontSize: 17),
              ),
            ],
          ),
        ));

_divider(BuildContext context) => Container(
    height: 1,
    width: MediaQuery.of(context).size.width / 2.5,
    color: greyColor);

_lineOr(BuildContext context) => Container(
      alignment: Alignment.center,
      width: double.infinity,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisSize: MainAxisSize.max,
        children: [
          _divider(context),
          Text(
            'OR',
            style: TextStyle(
              fontSize: 15,
              fontWeight: FontWeight.w400,
              foreground: Paint()
                ..shader = gradientColor
                    .createShader(Rect.fromLTWH(0.0, 0.0, 200.0, 70.0)),
            ),
          ),
          _divider(context),
        ],
      ),
    );
