import 'package:Dictionary/widgets/gradientColor/gradient_widget.dart';
import 'package:Dictionary/widgets/textDecoration/text_styles.dart';
import 'package:flutter/material.dart';

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
            //  alignment: Alignment.center,
            padding: EdgeInsets.only(
              bottom: 50,
            ),
            width: double.maxFinite,
            height: double.maxFinite,
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage("assets/images/background_onbording.png"),
                fit: BoxFit.cover,
              ),
            ),
            child: Center(
              child: Container(
                  margin: EdgeInsets.only(
                      top: MediaQuery.of(context).size.height / 2),
                  width: double.maxFinite,
                  height: double.maxFinite,
                  child: Column(children: [
                    Text("Hello",
                        style: TextStyle(
                            fontFamily: ('Futura'),
                            fontSize: 40,
                            fontWeight: FontWeight.bold,
                            foreground: Paint()
                              ..shader = gradientColor().createShader(
                                  Rect.fromLTWH(0.0, 0.0, 200.0, 70.0)))),
                    SizedBox(
                      height: 10,
                    ),
                    Text(
                        'We are Dictionary,\n here you will learn many interesting\n words, what they mean and how to\n use them in your vocabulary',
                        textAlign: TextAlign.center,
                        style: plainTextStyle()),
                    Spacer(),
                    Text(
                      'Good Luck!',
                      textAlign: TextAlign.center,
                      style: plainTextStyle(),
                    ),
                    Spacer(),
                    Container(
                        height: 50,
                        width: 160,
                        decoration: BoxDecoration(
                          gradient: gradientColor(),
                          borderRadius: BorderRadius.all(Radius.circular(30.0)),
                        ),
                        child: TextButton(
                          onPressed: () {
                            Navigator.of(context).pushNamedAndRemoveUntil('/cardScreen', (Route<dynamic> route) => false);
                          },
                          child: Text(
                            "Let's start",
                            style: TextStyle(
                                fontFamily: ('Futura'),
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                                color: Colors.white),
                          ),
                        ))
                  ])),
            )));
  }
}
