import 'package:GOCart/CONSTANTS/constants.dart';
import 'package:GOCart/PREFS/preferences.dart';
import 'package:GOCart/PROVIDERS/user_provider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:provider/provider.dart';

enum Status {
  uninitialized,
  authenticated,
  authenticating,
  authenticateError,
}

class AuthProvider extends ChangeNotifier {
  FirebaseAuth firebaseAuth = FirebaseAuth.instance;
  FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;

  Status _status = Status.uninitialized;

  Status get status => _status;

  initialize(Status statusState) {
    _status = statusState;
    notifyListeners();
  }

  Future<bool> loginWithEmailAndPass(String email, String password) async {
    _status = Status.authenticating;
    notifyListeners();

    User? user = (await firebaseAuth.signInWithEmailAndPassword(
            email: email, password: password))
        .user;

    if (user != null) {
      _status = Status.authenticated;
      notifyListeners();

      return true;
    } else {
      _status = Status.authenticateError;
      notifyListeners();

      return false;
    }
  }

  Future registerWithEmailAndPass(String firstName, String lastName,
      String email, String password, BuildContext context) async {
    try {
      _status = Status.authenticating;
      notifyListeners();

      (await firebaseAuth
          .createUserWithEmailAndPassword(email: email, password: password)
          .then((value) async {
        await Provider.of<UserProvider>(context)
            .saveUserData(firstName, lastName, email, value.user!.uid)
            .then((_) {
          Preferences()
              .saveListData(Constants.prefsUserFullName, [firstName, lastName]);
          Preferences().saveStringData(Constants.prefsUserEmail, email);

          _status = Status.authenticated;
          notifyListeners();
        });
      }));

      return true;
    } on FirebaseAuthException catch (e) {
      _status = Status.authenticateError;
      notifyListeners();

      return e.message;
    }
  }

  Future googleSignin() async {
    _status = Status.authenticating;
    notifyListeners();

    GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();

    if (googleUser != null) {
      GoogleSignInAuthentication? googleAuth = await googleUser.authentication;
      AuthCredential credential = GoogleAuthProvider.credential(
          accessToken: googleAuth.accessToken, idToken: googleAuth.idToken);

      User? user = (await firebaseAuth.signInWithCredential(credential)).user;

      if (user != null) {
        QuerySnapshot userSnapshot = await firebaseFirestore
            .collection(Constants.collectionUsers)
            .where(Constants.uid, isEqualTo: user.uid)
            .get();

        List<DocumentSnapshot> documentSnapshots = userSnapshot.docs;

        if (documentSnapshots.isEmpty) {
          _status = Status.authenticateError;
          notifyListeners();

          // return false;
          return 'User does not exist';
        } else {
          DocumentSnapshot documentSnapshot = documentSnapshots[0];

          Preferences().saveListData(Constants.prefsUserFullName, [
            documentSnapshot[Constants.userFirstName],
            documentSnapshot[Constants.userLastName]
          ]);
          Preferences().saveStringData(
              Constants.prefsUserEmail, documentSnapshot[Constants.userEmail]);

          _status = Status.authenticated;
          notifyListeners();

          return true;
        }
      } else {
        _status = Status.authenticateError;
        notifyListeners();

        return false;
      }
    }
  }

  Future signOut() async {
    return await firebaseAuth.signOut();
  }
}
