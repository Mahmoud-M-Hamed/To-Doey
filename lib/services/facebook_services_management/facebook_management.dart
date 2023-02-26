import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';
import 'package:todoey/components/constants/constants.dart';

mixin FacebookServices {
  Future<UserCredential> userAuthWithFacebook() async {
    final LoginResult loginResult = await FacebookAuth.instance
        .login(permissions: ['public_profile', 'email']);
    final OAuthCredential facebookCredential =
        FacebookAuthProvider.credential(loginResult.accessToken!.token);
    final UserCredential userCredential =
        await firebaseAuth.signInWithCredential(facebookCredential);
    return userCredential;
  }

  Future<void> facebookSignOut() async {
    await FacebookAuth.instance.logOut();
    await firebaseAuth.signOut();
  }
}
