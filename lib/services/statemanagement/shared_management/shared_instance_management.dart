import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:todoey/components/constants/constants.dart';

mixin GetLocalImagesFromFireBase {
  Future<DocumentSnapshot<Map<String, dynamic>>>
      get getLocalImagesFromFirebase async =>
          await firebaseFirestore.collection('assets').doc('localImage').get();
}
