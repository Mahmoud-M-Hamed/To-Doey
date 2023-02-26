import 'package:flutter/material.dart';
import 'package:todoey/components/constants/constants.dart';
import 'package:todoey/styles/icons/broken_icons.dart';

showAlertDialog(
        {required BuildContext context,
        required bool barrierDismissible,
        required String title,
        required Widget content,
        required List<Widget> actions}) =>
    showDialog(
      context: context,
      barrierDismissible: barrierDismissible,
      builder: (context) => AlertDialog(
        icon: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: const [
            Icon(
              BrokenIcons.tasks,
              size: 18,
            ),
            SizedBox(
              width: 10,
            ),
            Text(
              kAppMainName,
              style:
                  TextStyle(color: kAppMainColor, fontWeight: FontWeight.bold),
            ),
          ],
        ),
        iconColor: kAppMainColor,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15),
        ),
        actions: actions,
        title: Text(
          title,
          style: const TextStyle(fontWeight: FontWeight.bold),
        ),
        content: content,
      ),
    );
