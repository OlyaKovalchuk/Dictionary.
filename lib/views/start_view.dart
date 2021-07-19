import 'dart:async';
import 'package:Dictionary/widgets/gradientColor/gradient_widget.dart';
import 'package:Dictionary/widgets/textDecoration/text_styles.dart';
import 'package:flutter/material.dart';
import 'package:Dictionary/widgets/animation/slide_route.dart';

class Start extends StatefulWidget {
  const Start({Key? key}) : super(key: key);

  @override
  _StartState createState() => _StartState();
}

class _StartState extends State<Start> {
  late Timer _timer;
  int _start = 3;

  void startTimer() {
    const oneSec = const Duration(seconds: 1);
    _timer = new Timer.periodic(
      oneSec,
      (Timer timer) {
        if (_start == 0) {
          setState(() {
            timer.cancel();
          });
          Navigator.push(context, AnimatedRoute(Start_View()));
        } else {
          setState(() {
            _start--;
          });
        }
      },
    );
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    startTimer();
  }

  @override
  void dispose() {
    _timer.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
          width: double.maxFinite,
          height: double.maxFinite,
          decoration: BoxDecoration(gradient: gradientColor()),
          child: Center(
              child: Text('Dictionary.',
                  style: TextStyle(
                      fontFamily: ('Futura'),
                      fontSize: 50,
                      fontWeight: FontWeight.bold,
                      color: Colors.white)))),
    );
  }
}

class Start_View extends StatefulWidget {
  const Start_View({Key? key}) : super(key: key);

  @override
  _Start_ViewState createState() => _Start_ViewState();
}

class _Start_ViewState extends State<Start_View> {
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
                  child: Column(
                      //mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
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
                              borderRadius:
                                  BorderRadius.all(Radius.circular(30.0)),
                            ),
                            child: TextButton(
                              onPressed: () {
                                Navigator.of(context).pushNamed('/dictionary');
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
