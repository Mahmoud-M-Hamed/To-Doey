import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';

//------------------------<User Data shared-Pref>----------------------------------

dynamic token;
dynamic checkboxValue;

// ----------------------<Firebase Instances>--------------------

final FirebaseAuth firebaseAuth = FirebaseAuth.instance;
final FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;
final FirebaseStorage firebaseStorage = FirebaseStorage.instance;

// --------------------<Titles>-------------------------------

const String kAppMainName = 'Todoey';

// ---------------------<Styles>-------------------------

const String kAppFontFamily = 'Horizon-Personal';
const Color kAppMainColor = Colors.lightBlueAccent;
const Color kScaffoldBackgroundColor = Colors.lightBlueAccent;

const kColorizeColors = [
  Colors.white,
  Colors.cyan,
  Colors.blue,
  Colors.indigoAccent
];

const todoeyColorizeTextStyle = TextStyle(
  fontSize: 40.0,
  fontWeight: FontWeight.bold,
  fontFamily: kAppFontFamily,
);
