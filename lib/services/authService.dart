import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

class AuthProvider {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final GoogleSignIn googleSignIn = GoogleSignIn();

  Future<bool> signInWithGoogle() async {
    GoogleSignInAccount googleSignInAccount = await googleSignIn.signIn();

    if (googleSignInAccount == null) return false;

    GoogleSignInAuthentication googleSignInAuthentication =
    await googleSignInAccount.authentication;

    AuthCredential credential = GoogleAuthProvider.getCredential(
      accessToken: googleSignInAuthentication.accessToken,
      idToken: googleSignInAuthentication.idToken,
    );

    AuthResult authResult = await _auth.signInWithCredential(credential);

    if (authResult.user == null) return false;

    print("signInWithGoogle succeeded");

    return true;
  }

  Future<void> signOutGoogle() async {
    await _auth.signOut();
    print("signOutWithGoogle succeeded");
  }
}
