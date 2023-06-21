import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

/// Create user by email and password in [auth]
/// If have error to return error's message
Future<String?> createUserByEmailPassword(Map<String, String> auth) async {
  try {
    await FirebaseAuth.instance.createUserWithEmailAndPassword(
      email: auth['email']!,
      password: auth['password']!,
    );
  } on FirebaseAuthException catch (e) {
    if (e.code == 'weak-password') {
      return 'The password provided is too weak!!';
    } else if (e.code == 'email-already-in-use') {
      return 'The account already exists for that email!!';
    }
  } catch (e) {
    return 'Have error in sign up!!';
  }
}

/// Login user by email and password in [auth]
/// If have error to return error's message
Future<String?> signInWithEmailAndPassword(Map<String, String> auth) async {
  try {
    await FirebaseAuth.instance.signInWithEmailAndPassword(
      email: auth['email']!,
      password: auth['password']!,
    );
  } on FirebaseAuthException catch (e) {
    if (e.code == 'user-not-found') {
      return 'No user found for that email!!';
    } else if (e.code == 'wrong-password') {
      return 'Wrong password provided for that user!!';
    }
  } catch (e) {
    return 'Have error in sign in!!';
  }
}

Future<String?> signInWithGoogle() async {
  try {
    GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();

    if (googleUser != null) {
      GoogleSignInAuthentication? authentication =
          await googleUser.authentication;

      AuthCredential credential = GoogleAuthProvider.credential(
        accessToken: authentication.accessToken,
        idToken: authentication.idToken,
      );

      UserCredential userCredential =
          await FirebaseAuth.instance.signInWithCredential(credential);
    }
  } catch (e) {
    return 'Error signing in with Google';
  }
}
