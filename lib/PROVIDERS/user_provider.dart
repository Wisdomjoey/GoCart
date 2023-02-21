import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import '../CONSTANTS/constants.dart';

class UserProvider extends ChangeNotifier {
  final BuildContext context;

  UserProvider(this.context);

  Map<String, dynamic> _userData = {};
  Map<String, dynamic> get userData => _userData;

  CollectionReference userCollectionRef =
      FirebaseFirestore.instance.collection(Constants.collectionUsers);

  Future initializeUserData(String userId) async {
    DocumentSnapshot snapshot = await userCollectionRef.doc(userId).get();

    _userData = snapshot.data() as Map<String, dynamic>;
    notifyListeners();
  }

  Future saveUserData(
      String firstName, String lastName, String email, String uid) async {
    return await userCollectionRef.doc(uid).set({
      Constants.uid: uid,
      Constants.userFirstName: firstName,
      Constants.userLastName: lastName,
      Constants.userIsSeller: false,
      Constants.userIsPhoneVerified: false,
      Constants.userIsEmailVerified: false,
      Constants.userPinIsSet: false,
      Constants.userUserName: '',
      Constants.userEmail: email,
      Constants.userPhone: '',
      Constants.shopId: '',
      Constants.userSavedItems: [],
      Constants.userFavourites: [],
      Constants.userPin: [],
      Constants.userFCMToken: '',
      Constants.createdAt: DateTime.now().millisecondsSinceEpoch.toString(),
      Constants.updatedAt: DateTime.now().millisecondsSinceEpoch.toString(),
    });
  }

  Future getUserData(String email) async {
    QuerySnapshot snapshot = await userCollectionRef
        .where(Constants.userEmail, isEqualTo: email)
        .get();

    return snapshot;
  }

  Future getUserById(String userId) async {
    DocumentSnapshot snapshot = await userCollectionRef.doc(userId).get();

    return snapshot.data();
  }

  // Future getUserDataById(String uid) async {
  //   DocumentSnapshot snapshot = await userCollectionRef.doc(uid).get();

  //   return snapshot;
  // }

  Future updateUserData(Map<String, dynamic> data, String userId) async {
    try {
      DocumentReference userDocumentRef = userCollectionRef.doc(userId);

      await userDocumentRef.update(data);

      initializeUserData(userId);

      return true;
    } on FirebaseException catch (e) {
      Constants(context).snackBar(e.message!, Colors.red);

      return false;
    }
  }

  Future deleteUser(String userId) async {
    try {
      DocumentReference documentReference = userCollectionRef.doc(userId);

      await documentReference.delete().then((value) {
        return Constants(context).snackBar(
            'Your account has been closed successfully!', Constants.tetiary);
      });
    } on FirebaseException catch (e) {
      Constants(context).snackBar(e.message!, Colors.red);
    }
  }

  Future addToInbox(
      String userId, String imgUrl, String message, String subject) async {
    try {
      CollectionReference collectionReference =
          userCollectionRef.doc(userId).collection(Constants.collectionInbox);

      DocumentReference documentReference = await collectionReference.add({
        Constants.uid: '',
        Constants.inboxSubject: subject,
        Constants.inboxMessage: message,
        'date': DateTime.now().toString(),
        Constants.imgUrl: imgUrl
      });

      await documentReference.update({Constants.uid: documentReference.id});

      return true;
    } on FirebaseException catch (e) {
      return e.message;
    }
  }

  Future deleteInbox(String userId, String inboxId) async {
    DocumentReference documentReference = userCollectionRef
        .doc(userId)
        .collection(Constants.collectionInbox)
        .doc(inboxId);

    await documentReference.delete().then((_) {
      return 'Successfully deleted inbox! ✅';
    }).catchError((e) {
      return e;
    });
  }

  Future fetchAllInbox(String userId) async {
    QuerySnapshot querySnapshot = await userCollectionRef
        .doc(userId)
        .collection(Constants.collectionInbox)
        .get();

    List data = [];

    for (var element in querySnapshot.docs) {
      data.add(element.data());
    }

    return data;
  }
}
