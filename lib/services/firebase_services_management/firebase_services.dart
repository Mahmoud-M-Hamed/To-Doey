import 'package:cloud_firestore/cloud_firestore.dart';
import '../../components/constants/constants.dart';

mixin FirebaseServices {
  Future<DocumentSnapshot<Map<String, dynamic>>> getDataFromFirebase({
    required String collectionPath,
    required String docId,
  }) async =>
      await firebaseFirestore.collection(collectionPath).doc(docId).get();

  Future<void> setDataInFirebase(
      {required String collectionPath,
      required String docId,
      required Map<String, dynamic> map}) async =>
    await firebaseFirestore.collection(collectionPath).doc(docId).set(map);



  Future<void> updateDataInFirebase(
      {required String collectionPath,
      required String docId,
      required Map<String, dynamic> map}) async =>
    await firebaseFirestore.collection(collectionPath).doc(docId).update(map);


  Future<void> deleteDataFromFirebase(
      {required String collectionPath, required String docId}) async =>
    await firebaseFirestore.collection(collectionPath).doc(docId).delete();


}
