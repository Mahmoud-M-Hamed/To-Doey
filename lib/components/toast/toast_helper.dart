import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:todoey/components/constants/constants.dart';

showToast({required String message}) => Fluttertoast.showToast(
    msg: message,
    textColor: Colors.white,
    gravity: ToastGravity.BOTTOM,
    toastLength: Toast.LENGTH_LONG,
    backgroundColor: kAppMainColor);
