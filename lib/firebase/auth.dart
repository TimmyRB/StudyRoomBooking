// Packages
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/services.dart';

class EmailAuth {
  final FirebaseAuth auth = FirebaseAuth.instance;

  Future<FirebaseUser> signIn(String email, String password) async {
    AuthResult result;

    try {
      result = await auth.signInWithEmailAndPassword(
          email: email, password: password);
    } on PlatformException catch (e) {
			List<String> errors = e.toString().split(',');
      print("Error: " + errors[1]); 
			return null;
		}

    final FirebaseUser user = result.user;

    assert(user != null);
    assert(await user.getIdToken() != null);

    final FirebaseUser currentUser = await auth.currentUser();
    assert(user.uid == currentUser.uid);

    print('signInEmail succeeded: $user');

    return user;
  }
}
