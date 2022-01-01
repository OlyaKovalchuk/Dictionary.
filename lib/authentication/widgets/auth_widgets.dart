import 'package:Dictionary/widgets/colors/grey_color.dart';
import 'package:Dictionary/widgets/gradientColor/gradient_widget.dart';
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
}) =>
    GestureDetector(
        onTap: onTap,
        child: Container(
          alignment: Alignment.center,
          height: 56,
          width: 236,
          decoration: BoxDecoration(
            gradient: gradientColor(),
            borderRadius: BorderRadius.all(Radius.circular(30.0)),
          ),
          child: Text(
            textOfButton,
            style: TextStyle(
                fontFamily: ('Futura'),
                fontSize: 20,
                fontWeight: FontWeight.normal,
                color: Colors.white),
          ),
        ));

_buttonSignWithGoogleOrFacebook(
        {required void onTap()?,
        required String textOfButton,
        required Widget image}) =>
    GestureDetector(
        onTap: onTap,
        child: Container(
          alignment: Alignment.center,
          height: 56,
          width: 236,
          decoration: BoxDecoration(
            border: Border.all(color: greyTextColor()),
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
                style: TextStyle(
                    fontFamily: ('Futura'), fontSize: 17, color: greyColor()),
              ),
            ],
          ),
        ));

_divider(BuildContext context) => Container(
    height: 1,
    width: MediaQuery.of(context).size.width / 2.5,
    color: greyTextColor());

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
                ..shader = gradientColor()
                    .createShader(Rect.fromLTWH(0.0, 0.0, 200.0, 70.0)),
            ),
          ),
          _divider(context),
        ],
      ),
    );
