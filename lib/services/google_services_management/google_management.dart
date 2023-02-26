import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import '../../components/constants/constants.dart';

mixin GoogleServices {
  Future<UserCredential> userAuthWithGoogle() async {
    GoogleSignInAccount? googleSignIn = await GoogleSignIn().signIn();
    GoogleSignInAuthentication? googleAuth = await googleSignIn!.authentication;
    AuthCredential authCredential = GoogleAuthProvider.credential(
      accessToken: googleAuth.accessToken,
      idToken: googleAuth.idToken,
    );
    UserCredential userCredential =
        await firebaseAuth.signInWithCredential(authCredential);

    return userCredential;
  }

  Future<void> googleSignOut() async {
    await GoogleSignIn().signOut();
    await firebaseAuth.signOut();
  }
}
