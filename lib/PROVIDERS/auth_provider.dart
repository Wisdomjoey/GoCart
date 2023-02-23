import 'package:GOCart/CONSTANTS/constants.dart';
import 'package:GOCart/PREFS/preferences.dart';
import 'package:GOCart/PROVIDERS/user_provider.dart';
import 'package:GOCart/UI/utils/firebase_actions.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:local_auth/local_auth.dart';
import 'package:provider/provider.dart';

import '../UI/routes/route_helper.dart';

enum Status {
  uninitialized,
  authenticated,
  authenticating,
  authenticateError,
}

class AuthProvider extends ChangeNotifier {
  FirebaseAuth firebaseAuth = FirebaseAuth.instance;
  FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;
  GoogleSignIn googleSignIn = GoogleSignIn();

  Status _status = Status.uninitialized;
  Status get status => _status;

  // bool? _isSigned = false;
  // bool? get isSigned => _isSigned;

  bool _isPhoneVerified = false;
  bool get isPhoneVerified => _isPhoneVerified;

  String _verId = '';
  String get verId => _verId;

  initialize(Status statusState) async {
    _status = statusState;
    // _isSigned = await Preferences().getBoolData(Constants.prefsUserSigned);
    notifyListeners();
  }

  Future loginWithEmailAndPass(
      String email, String password, BuildContext context) async {
    try {
      _status = Status.authenticating;
      notifyListeners();

      User? user = (await firebaseAuth.signInWithEmailAndPassword(
              email: email, password: password))
          .user;

      if (user != null) {
        _status = Status.authenticated;
        notifyListeners();

        // print('true');
        return true;
      } else {
        _status = Status.authenticateError;
        notifyListeners();
        signOut();

        // print('false');
        return false;
      }
    } on FirebaseException catch (e) {
      _status = Status.authenticateError;
      notifyListeners();
      signOut();

      return e.message;
    }
  }

  Future registerWithEmailAndPass(String firstName, String lastName,
      String email, String password, BuildContext context) async {
    try {
      _status = Status.authenticating;
      notifyListeners();

      await firebaseAuth
          .createUserWithEmailAndPassword(email: email, password: password)
          .then((value) async {
        await Provider.of<UserProvider>(context, listen: false)
            .saveUserData(firstName, lastName, email, value.user!.uid)
            .then((value) async {
          await Preferences()
              .saveBoolData(Constants.prefsUserIsRegistered, true)
              .whenComplete(() => initToken(context));
        });
      });

      _status = Status.authenticated;
      notifyListeners();

      return true;
    } on FirebaseAuthException catch (e) {
      _status = Status.authenticateError;
      notifyListeners();
      signOut();

      return e.message;
    }
  }

  Future googleSignin() async {
    try {
      _status = Status.authenticating;
      notifyListeners();

      GoogleSignInAccount? googleUser = await googleSignIn.signIn();

      if (googleUser != null) {
        GoogleSignInAuthentication? googleAuth =
            await googleUser.authentication;
        AuthCredential credential = GoogleAuthProvider.credential(
            accessToken: googleAuth.accessToken, idToken: googleAuth.idToken);

        User? user =
            (await firebaseAuth.currentUser!.linkWithCredential(credential))
                .user;

        if (user != null) {
          QuerySnapshot userSnapshot = await firebaseFirestore
              .collection(Constants.collectionUsers)
              .where(Constants.uid, isEqualTo: user.uid)
              .get();

          List<DocumentSnapshot> documentSnapshots = userSnapshot.docs;

          if (documentSnapshots.isEmpty) {
            _status = Status.authenticateError;
            notifyListeners();
            signOut();

            // return false;
            return 'User does not exist';
          } else {
            DocumentSnapshot documentSnapshot = documentSnapshots[0];

            // Preferences().saveListData(Constants.prefsUserFullName, [
            //   documentSnapshot[Constants.userFirstName],
            //   documentSnapshot[Constants.userLastName]
            // ]);
            // Preferences().saveStringData(Constants.prefsUserEmail,
            //     documentSnapshot[Constants.userEmail]);
            // Preferences().saveStringData(Constants.prefsUserFirstName,
            //     documentSnapshot[Constants.userFirstName]);
            // Preferences().saveStringData(Constants.prefsUserLastName,
            //     documentSnapshot[Constants.userLastName]);
            // Preferences().saveBoolData(Constants.prefsUserIsSeller,
            //     documentSnapshot[Constants.userIsSeller]);
            // Preferences().saveBoolData(Constants.prefsUserIsSeller, true);

            _status = Status.authenticated;
            // _isSigned = true;
            notifyListeners();

            return true;
          }
        } else {
          _status = Status.authenticateError;
          notifyListeners();

          return false;
        }
      } else {
        _status = Status.authenticateError;
        notifyListeners();

        return 'Sign In Cancelled';
      }
    } on FirebaseException catch (e) {
      _status = Status.authenticateError;
      notifyListeners();

      return e.message!;
    }
  }

  Future googleSignin1() async {
    try {
      _status = Status.authenticating;
      notifyListeners();

      GoogleSignInAccount? googleUser = await googleSignIn.signIn();

      if (googleUser != null) {
        GoogleSignInAuthentication? googleAuth =
            await googleUser.authentication;
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
            signOut();

            // return false;
            return 'User does not exist';
          } else {
            DocumentSnapshot documentSnapshot = documentSnapshots[0];

            // Preferences().saveListData(Constants.prefsUserFullName, [
            //   documentSnapshot[Constants.userFirstName],
            //   documentSnapshot[Constants.userLastName]
            // ]);
            // Preferences().saveStringData(Constants.prefsUserEmail,
            //     documentSnapshot[Constants.userEmail]);
            // Preferences().saveStringData(Constants.prefsUserFirstName,
            //     documentSnapshot[Constants.userFirstName]);
            // Preferences().saveStringData(Constants.prefsUserLastName,
            //     documentSnapshot[Constants.userLastName]);
            // Preferences().saveBoolData(Constants.prefsUserSigned,
            //     documentSnapshot[Constants.userIsSeller]);

            _status = Status.authenticated;
            notifyListeners();

            return true;
          }
        } else {
          _status = Status.authenticateError;
          notifyListeners();

          return false;
        }
      } else {
        _status = Status.authenticateError;
        notifyListeners();

        return 'Sign In Cancelled';
      }
    } on FirebaseException catch (e) {
      _status = Status.authenticateError;
      notifyListeners();

      return e.message!;
    }
  }

  Future signOut() async {
    try {
      if (googleSignIn.currentUser != null) {
        await googleSignIn.signOut();
        await googleSignIn.disconnect();
        await firebaseAuth.signOut();
      }
      // if (firebaseAuth.currentUser != null) {
      await firebaseAuth.signOut();
      // }

      // Preferences().saveListData(Constants.prefsUserFullName, ['', '']);
      // Preferences().saveStringData(Constants.prefsUserEmail, '');
      // Preferences().saveStringData(Constants.prefsUserFirstName, '');
      // Preferences().saveStringData(Constants.prefsUserLastName, '');
      // Preferences().saveBoolData(Constants.prefsUserIsSeller, false);
    } on FirebaseException catch (e) {
      return e.message;
    }
  }

  verifyPhoneNumber(BuildContext context, String phone) async {
    await FirebaseAuth.instance.verifyPhoneNumber(
        phoneNumber: '+234$phone',
        verificationCompleted: ((phoneAuthCredential) {
          Constants(context).snackBar(
              'Phone Number Verified Successfully!', Constants.primary);
        }),
        verificationFailed: ((error) {
          Constants(context).snackBar(error.message!, Colors.red);
        }),
        codeSent: ((verificationId, forceResendingToken) {
          _verId = verificationId;
          notifyListeners();

          Constants(context).snackBar(
              'Verification Code Sent Successfully!', Constants.primary);
        }),
        codeAutoRetrievalTimeout: ((verificationId) {}));
  }

  Future submitOtp(BuildContext context, String otp, String phone) async {
    try {
      AuthCredential credential =
          PhoneAuthProvider.credential(verificationId: verId, smsCode: otp);

      await firebaseAuth.currentUser
          ?.linkWithCredential(credential)
          .then((value) async {
        if (value.user != null) {
          await Provider.of<UserProvider>(context, listen: false)
              .updateUserData({
            Constants.userIsPhoneVerified: true,
            Constants.userPhone: '+234$phone'
          }, FirebaseAuth.instance.currentUser!.uid).then((value) async {
            Constants(context).snackBar(
                'Phone Number Verified Successfully!', Constants.tetiary);

            _isPhoneVerified = true;
            // Preferences().saveBoolData(Constants.prefsUserPhoneVerified, true);

            await Provider.of<UserProvider>(context, listen: false)
                .initializeUserData(firebaseAuth.currentUser!.uid)
                .then((value) {
              Get.offAllNamed(RouteHelper.getRoutePage(), arguments: 0);
            });
          });
        } else {
          Constants(context).snackBar('Code is wrong', Colors.red);
        }
      });
      // User? user =
      //     (await firebaseAuth.currentUser?.linkWithCredential(credential))!
      //         .user;

    } on FirebaseException catch (e) {
      if (e.code == 'provider-already-linked') {
        PhoneAuthCredential credential =
            PhoneAuthProvider.credential(verificationId: verId, smsCode: otp);

        await firebaseAuth.currentUser
            ?.updatePhoneNumber(credential)
            .then((value) async {
          await Provider.of<UserProvider>(context, listen: false)
              .updateUserData({
            Constants.userIsPhoneVerified: true,
            Constants.userPhone: '+234$phone'
          }, FirebaseAuth.instance.currentUser!.uid).then((value) async {
            Constants(context).snackBar(
                'Phone Number Verified Successfully!', Constants.tetiary);

            _isPhoneVerified = true;
            // Preferences().saveBoolData(Constants.prefsUserPhoneVerified, true);

            await Provider.of<UserProvider>(context, listen: false)
                .initializeUserData(firebaseAuth.currentUser!.uid)
                .then((value) {
              Get.offAllNamed(RouteHelper.getRoutePage(), arguments: 0);
            });
          });
        });
      } else if (e.message!.contains(
          'The sms verification code used to create the phone auth credential is invalid')) {
        Constants(context).snackBar('Code entered is wrong', Colors.red);
      } else if (e.message!.contains('The sms code has expired')) {
        Constants(context).snackBar(
            'Code has expired please retry the verification', Colors.red);
      } else {
        Constants(context).snackBar(e.message!, Colors.red);
      }
    }
  }

  Future authenticate() async {
    LocalAuthentication authentication = LocalAuthentication();

    final bool isBiometricsAvailable = await authentication.isDeviceSupported();

    if (!isBiometricsAvailable) return false;

    try {
      return await authentication.authenticate(
          localizedReason: 'Scan Fingerprint',
          options: const AuthenticationOptions(
              // biometricOnly: true,
              useErrorDialogs: true,
              stickyAuth: true));
    } on PlatformException catch (e) {
      // Constants(context).snackBar(e.message!, Colors.red);

      return e.message;
    }
  }

  Future reauthenticate(
      BuildContext context, String email, String password) async {
    try {
      AuthCredential credential =
          EmailAuthProvider.credential(email: email, password: password);

      User? user = (await firebaseAuth.currentUser!
              .reauthenticateWithCredential(credential))
          .user;

      if (user != null) {
        return true;
      }
    } on FirebaseException catch (e) {
      Constants(context).snackBar(e.message!, Colors.red);

      return false;
    }
  }
}
