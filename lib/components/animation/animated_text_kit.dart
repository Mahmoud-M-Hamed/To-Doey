import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flutter/material.dart';

Widget singleAnimatedText({
  required String kAnimatedText,
  required TextStyle textStyle,
  required List<Color> colors,
  bool repeatedForever = false,
  bool isRepeatingAnimation = true,
  bool displayFullTextOnTap = false,
  int totalRepeatCount = 5,
  int pauseMillisecondsDuration = 1500,
  VoidCallback? onTap,
}) =>
    AnimatedTextKit(
      animatedTexts: <AnimatedText>[
        ColorizeAnimatedText(kAnimatedText,
            textStyle: textStyle, colors: colors),
      ],
      repeatForever: repeatedForever,
      isRepeatingAnimation: isRepeatingAnimation,
      displayFullTextOnTap: displayFullTextOnTap,
      onTap: onTap,
      totalRepeatCount: totalRepeatCount,
      pause: Duration(milliseconds: pauseMillisecondsDuration),
    );
