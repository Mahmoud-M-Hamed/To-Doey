class UnityLocalImagesModel {
  String? signInImage;
  String? signUpImage;
  String? defaultProfileImage;

  UnityLocalImagesModel(
      {this.signInImage, this.signUpImage, this.defaultProfileImage});

  UnityLocalImagesModel.fromJson(Map<String, dynamic> json) {
    signInImage = json['signInImage'];
    signUpImage = json['signUpImage'];
    defaultProfileImage = json['defaultProfileImage'];
  }
}
