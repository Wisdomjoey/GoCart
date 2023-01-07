import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import '../CONSTANTS/constants.dart';

class UserProvider extends ChangeNotifier {
  CollectionReference userCollectionRef =
      FirebaseFirestore.instance.collection(Constants.collectionUsers);

  Future saveUserData(
      String firstName, String lastName, String email, String uid) async {
    return await userCollectionRef.doc(uid).set({
      Constants.uid: uid,
      Constants.userFirstName: firstName,
      Constants.userLastName: lastName,
      Constants.userIsSeller: false,
      Constants.userIsPhoneVerified: false,
      Constants.userIsEmailVerified: false,
      Constants.userUserName: '',
      Constants.userEmail: email,
      Constants.userPhone: '',
      Constants.shopId: '',
      Constants.userSavedItems: [],
      Constants.userFavourites: [],
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

  Future updateUserData(Map<String, dynamic> data, String userId) async {
    try {
      DocumentReference userDocumentRef = userCollectionRef.doc(userId);

      return await userDocumentRef.update(data);
    } on FirebaseException catch (e) {
      return e.message;
    }
  }

  Future deleteUser(String userId) async {
    DocumentReference documentReference = userCollectionRef.doc(userId);

    await documentReference.delete().then((value) {
      return 'Your account has been closed!';
    }).catchError((e) {
      return e;
    });
  }

  Future addToInbox(
      String userId, String? productId, String message, String subject) async {
    try {
      CollectionReference collectionReference =
          userCollectionRef.doc(userId).collection(Constants.collectionInbox);

      DocumentReference documentReference = await collectionReference.add({
        Constants.uid: '',
        Constants.inboxSubject: subject,
        Constants.inboxMessage: message,
        Constants.productId: productId ?? ''
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

    return querySnapshot;
  }
}
