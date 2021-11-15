import 'package:Dictionary/widgets/colors/grey_color.dart';
import 'package:Dictionary/widgets/gradientColor/gradient_widget.dart';
import 'package:Dictionary/widgets/textDecoration/text_styles.dart';
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
        body: Container(
            alignment: Alignment.center,
            padding: EdgeInsets.symmetric(
              vertical: 50,
            ),
            width: double.maxFinite,
            height: double.maxFinite,
            decoration: BoxDecoration(),
            child: Stack(
              alignment: Alignment.center,
              children: [
                SvgPicture.asset('assets/images/illustration_sign_up.svg'),
                Container(
                    padding: EdgeInsets.symmetric(vertical: 50),
                    width: double.maxFinite,
                    height: double.maxFinite,
                    child: Column(children: [
                      Text("Hello!",
                          style: TextStyle(
                              fontFamily: ('Futura'),
                              fontSize: 45,
                              fontWeight: FontWeight.w900,
                              foreground: Paint()
                                ..shader = gradientColor().createShader(
                                    Rect.fromLTWH(0.0, 0.0, 200.0, 70.0)))),
                      SizedBox(
                        height: 10,
                      ),
                      Text(
                          'We are Dictionary,\n here you will learn many interesting\n words, what they mean and how to\n use them in your vocabulary',
                          textAlign: TextAlign.center,
                          style: plainTextStyle(17)),
                      Spacer(),
                      GestureDetector(
                          onTap: () => Navigator.of(context).pushNamed(
                                '/registerScreen',
                              ),
                          child: Container(
                            alignment: Alignment.center,
                            height: 60,
                            width: 200,
                            decoration: BoxDecoration(
                              gradient: gradientColor(),
                              borderRadius:
                                  BorderRadius.all(Radius.circular(30.0)),
                            ),
                            child: Text(
                              "Create an account",
                              style: TextStyle(
                                  fontFamily: ('Futura'),
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white),
                            ),
                          )),
                      GestureDetector(
                        onTap: () {},
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
                              " Sign in",
                              style: TextStyle(
                                  fontFamily: ('Futura'),
                                  fontSize: 17,
                                  fontWeight: FontWeight.bold,
                                  foreground: Paint()
                                    ..shader = gradientColor().createShader(
                                        Rect.fromLTWH(0.0, 0.0, 200.0, 70.0))),
                            ),
                          ],
                        ),
                      )
                    ])),
              ],
            )));
  }
}
