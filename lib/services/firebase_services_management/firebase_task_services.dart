import 'package:cloud_firestore/cloud_firestore.dart';
import '../../components/constants/constants.dart';

mixin FirebaseTaskServices {
  final CollectionReference userTasksReference = firebaseFirestore
      .collection('usersInfo')
      .doc(firebaseAuth.currentUser!.uid)
      .collection('userTasks');

  Future<void> setTaskInFirebase(
          {required String dateTime,
          required Map<String, dynamic> map}) async =>
      await userTasksReference.doc(dateTime).set(map);
}
