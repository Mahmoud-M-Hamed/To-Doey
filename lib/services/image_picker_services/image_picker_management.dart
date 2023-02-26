import 'dart:io';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:image_picker/image_picker.dart';
import '../../components/constants/constants.dart';

mixin ImagePickerServices {
  File? profilePictureGallery;
  File? profilePictureCamera;

  Future<void> imagePicker(
      {required ImageSource imageSource,
      required Function(File?) callback}) async {
    ImagePicker picker = ImagePicker();
    final pickedFile = await picker.pickImage(
      source: imageSource,
      imageQuality: 50,
      maxWidth: 300,
      maxHeight: 300,
    );
    if (pickedFile != null) {
      callback(File(pickedFile.path));
    } else {
      callback(null);
    }
  }

  Future<String> uploadImageHandler({required File file}) async {
    Reference reference = firebaseStorage.ref().child('users/profile/'
        '${firebaseAuth.currentUser!.uid}/${Uri.file(file.path).pathSegments.last}');
    (await reference.putFile(file));
    var url = await reference.getDownloadURL();
    return url;
  }
}
