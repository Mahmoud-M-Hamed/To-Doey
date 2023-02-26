class UserInfoModel {
  String? userId;
  String? userName;
  String? email;
  String? phoneNumber;
  String? userImage;
  String? signInMethod;

  UserInfoModel(
      {this.userId,
      this.userName,
      this.email,
      this.phoneNumber,
      this.userImage =
          'https://firebasestorage.googleapis.com/v0/b/todoey-77530.appspot.com/'
              'o/assets%2FlocalImage%2FOIP.jpg?'
              'alt=media&token=ee3635e9-e79d-4ac7-a3f2-ca83f7a29acd',
      this.signInMethod});

  UserInfoModel.fromJson(Map<String, dynamic> json) {
    userId = json['userId'];
    userName = json['userName'];
    userImage = json['userImage'];
    email = json['email'];
    phoneNumber = json['phoneNumber'];
    signInMethod = json['signInMethod'];
  }

  Map<String, dynamic> userInfoToMap() => {
        'userId': userId,
        'userName': userName,
        'email': email,
        'phoneNumber': phoneNumber,
        'userImage': userImage,
        'signInMethod': signInMethod,
      };
}
