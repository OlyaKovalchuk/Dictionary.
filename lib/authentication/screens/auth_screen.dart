import 'package:Dictionary/widgets/button_gradient.dart';
import 'package:Dictionary/widgets/colors/grey_color.dart';
import 'package:Dictionary/widgets/gradientColor/gradient_widget.dart';
import 'package:Dictionary/widgets/textDecoration/text_styles.dart';
import 'package:Dictionary/widgets/titileText.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class IntroductionScreen extends StatefulWidget {
  const IntroductionScreen({Key? key}) : super(key: key);

  @override
  _IntroductionScreenState createState() => _IntroductionScreenState();
}

class _IntroductionScreenState extends State<IntroductionScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(alignment: Alignment.center, children: [
        _buildBackgroundImage(),
        Padding(
          padding: const EdgeInsets.only(top: 70.0, bottom: 50),
          child: Column(
            mainAxisSize: MainAxisSize.max,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              _buildTextHello(),
              _buildIntroductionText(),
              Spacer(),
              _buildCreateAccountButton(),
              _buildLogInButton(),
            ],
          ),
        )
      ]),
    );
  }

  _buildBackgroundImage() => SvgPicture.asset(
        'assets/images/illustration_sign_up.svg',
        fit: BoxFit.cover,
        width: 250,
        height: 250,
      );

  _buildTextHello() => Container(
        alignment: Alignment.topCenter,
        child: buildTitleText(
            text: 'Hello', fontSize: 45, fontWeight: FontWeight.bold),
      );

  _buildIntroductionText() => Text(
      'We are Dictionary,\n here you will learn many interesting\n words, what they mean and how to\n use them in your vocabulary',
      textAlign: TextAlign.center,
      style: plainTextStyle(17));

  _buildCreateAccountButton() => GestureDetector(
      onTap: () => Navigator.of(context).pushNamed(
            '/registerScreen',
          ),
      child: buildGradientButton(onTap: () => Navigator.of(context).pushNamed(
          '/registerScreen'), title:  "Create an account"));


  _buildLogInButton() => GestureDetector(
        onTap: () {
          Navigator.pushNamed(context, '/loginScreen');
        },
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              "already have an account?",
              style: TextStyle(
                  fontFamily: ('Futura'),
                  fontSize: 15,
                  fontWeight: FontWeight.bold,
                  color: greyTextColor()),
            ),
            SizedBox(
              height: 50,
            ),
            Text(
              " Log in",
              style: TextStyle(
                  fontFamily: ('Futura'),
                  fontSize: 17,
                  fontWeight: FontWeight.bold,
                  foreground: Paint()
                    ..shader = gradientColor()
                        .createShader(Rect.fromLTWH(0.0, 0.0, 200.0, 70.0))),
            ),
          ],
        ),
      );
}
