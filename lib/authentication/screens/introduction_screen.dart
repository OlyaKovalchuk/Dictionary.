import 'package:Dictionary/authentication/widgets/button_gradient.dart';
import 'package:Dictionary/authentication/widgets/title_text.dart';
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
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              HelloText(),
              IntroductionText(),
              const Spacer(),
              CreateAccountButton(),
              LogInButton(),
            ],
          ),
        )
      ]),
    );
  }

  // TODO: add constant for images
  _buildBackgroundImage() => SvgPicture.asset(
        'assets/images/illustration_sign_up.svg',
        fit: BoxFit.cover,
        width: 250,
        height: 250,
      );
}

class HelloText extends StatelessWidget {
  const HelloText({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.topCenter,
      child: TextTitleBuilder(
        text: 'Hello',
        fontSize: 45,
        fontWeight: FontWeight.bold,
      ),
    );
  }
}

class IntroductionText extends StatelessWidget {
  const IntroductionText({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text(
        'We are Dictionary,\n here you will learn many interesting\n words, what they mean and how to\n use them in your vocabulary',
        textAlign: TextAlign.center,
        style: Theme.of(context).textTheme.bodyText1!.copyWith(fontSize: 17));
  }
}

class CreateAccountButton extends StatelessWidget {
  const CreateAccountButton({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
        onTap: () => Navigator.of(context).pushNamed(
              '/registerScreen',
            ),
        child: GradientButtonBuilder(
            onTap: () => Navigator.of(context).pushNamed('/registerScreen'),
            title: "Create an account"));
  }
}

class LogInButton extends StatelessWidget {
  const LogInButton({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.pushNamed(context, '/loginScreen');
      },
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text("already have an account?",
              style: Theme.of(context).textTheme.bodyText2),
          const SizedBox(
            height: 50,
          ),
          Text(" Log in",
              style: Theme.of(context)
                  .textTheme
                  .subtitle2!
                  .copyWith(fontSize: 17)),
        ],
      ),
    );
  }
}
