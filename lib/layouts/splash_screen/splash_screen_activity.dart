import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flutter/material.dart';
import 'package:todoey/layouts/unity/sign_in/signin_activity.dart';
import 'package:todoey/services/statemanagement/shared_management/shared_instance_management.dart';
import 'package:todoey/styles/icons/broken_icons.dart';
import '../../components/constants/constants.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with GetLocalImagesFromFireBase {
  final List<String> introTitles = [
    'Organize your life',
    'complete tasks',
    'more reliably',
    'by using the right',
    'Todoey App',
  ];

  Future<void> _splashDelay() async {
    await Future.delayed(
        const Duration(
          seconds: 20,
        ),
        () => Navigator.of(context).pushReplacement(
              MaterialPageRoute(builder: (context) => SignInActivity()),
            ));
  }

  @override
  void initState() {
    super.initState();
    _splashDelay();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        height: double.infinity,
        width: double.infinity,
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [Colors.blue, Colors.lightBlueAccent],
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.all(15.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const CircleAvatar(
                    radius: 30,
                    backgroundColor: Colors.white,
                    child: Icon(
                      BrokenIcons.tasks,
                      color: kAppMainColor,
                      size: 32,
                    ),
                  ),
                  const SizedBox(
                    width: 10,
                  ),
                  AnimatedTextKit(
                    animatedTexts: [
                      WavyAnimatedText(kAppMainName,
                          textStyle: const TextStyle(
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                              fontSize: 40,
                              fontFamily: kAppFontFamily)),
                    ],
                    repeatForever: true,
                  ),
                ],
              ),
              const SizedBox(
                height: 50,
              ),
              SizedBox(
                height: 150,
                child: AnimatedTextKit(
                  totalRepeatCount: 1,
                  pause: const Duration(milliseconds: 1500),
                  animatedTexts: List.generate(
                      introTitles.length,
                      (index) => FadeAnimatedText(
                            introTitles[index].toString(),
                            textStyle: const TextStyle(
                              fontSize: 32.0,
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                            ),
                          )),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
