import 'dart:io';

import 'package:GOCart/CONSTANTS/constants.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:intl/intl.dart';

enum Load { processing, processComplete, processError, uninitialized }

class ShopProvider extends ChangeNotifier {
  Load _load = Load.uninitialized;

  Load get load => _load;

  CollectionReference collectionReference =
      FirebaseFirestore.instance.collection(Constants.collectionShops);
  CollectionReference userCollectionRef =
      FirebaseFirestore.instance.collection(Constants.collectionUsers);
  CollectionReference productCollectionRef =
      FirebaseFirestore.instance.collection(Constants.collectionProducts);
  FirebaseStorage firebaseStorage = FirebaseStorage.instance;

  Future createShop(String shopName, String location, List<String> tags,
      List<CroppedFile> croppedFiles, String userId) async {
    try {
      _load = Load.processing;
      notifyListeners();
      List<String> newUrls = [];
      int counter = 1;
      DocumentReference userDocumentRef = userCollectionRef.doc(userId);

      for (var element in croppedFiles) {
        Reference imageReference = firebaseStorage.ref().child(
            "$userId/products/image$counter${DateTime.now().millisecondsSinceEpoch.toString()}");

        File? newImage = File(element.path);

        UploadTask? uploadTask = imageReference.putFile(newImage);
        TaskSnapshot taskSnapshot = await uploadTask;
        final url = await taskSnapshot.ref.getDownloadURL();

        newUrls.add(url);
        counter++;
      }

      DocumentReference documentReference = await collectionReference.add({
        Constants.uid: '',
        Constants.shopName: shopName,
        Constants.shopAddress: location,
        Constants.shopTags: tags,
        Constants.imgUrls: newUrls,
        Constants.sales: [],
        Constants.userId: userId,
        Constants.createdAt: DateTime.now().millisecondsSinceEpoch.toString(),
        Constants.updatedAt: DateTime.now().millisecondsSinceEpoch.toString(),
      });

      await userDocumentRef.update({Constants.shopId: documentReference.id});

      await documentReference
          .update({Constants.uid: documentReference.id}).then((_) {
        _load = Load.processComplete;
        notifyListeners();

        return true;
      });
    } on FirebaseException catch (e) {
      _load = Load.processError;
      notifyListeners();

      return e.message;
    }
  }

  Future updateShop(Map<String, dynamic> data, String shopId) async {
    try {
      _load = Load.processing;
      notifyListeners();
      DocumentReference documentReference = collectionReference.doc(shopId);

      await documentReference.update(data).then((_) {
        _load = Load.processComplete;
        notifyListeners();
      });

      return 'Shop details updated successfully! ✅';
    } on FirebaseException catch (e) {
      _load = Load.processError;
      notifyListeners();

      return e.message;
    }
  }

  Future updateShopSales(String shopId, double amount) async {
    _load = Load.processing;
    notifyListeners();
    DocumentReference documentReference = collectionReference.doc(shopId);
    DocumentSnapshot documentSnapshot = await documentReference.get();

    List data = documentSnapshot[Constants.sales];
    String month = DateFormat('MMM').format(DateTime.now());

    if (data.isNotEmpty) {
      Map<String, dynamic> map = data[data.length - 1];

      if (map['month'] == month) {
        data[data.length - 1] = {
          'month': map['month'],
          'sales': map['sales'] + amount
        };
      } else {
        data.add({'month': map['month'], 'sales': map['sales'] + amount});
      }
    } else {
      data.add({'month': month, 'sales': amount});
    }

    await documentReference.update({Constants.sales: data}).then((_) {
      _load = Load.processComplete;
      notifyListeners();

      return 'Shop details updated successfully! ✅';
    });
  }

  Future addImage(CroppedFile croppedFile, String userId, String shopId) async {
    try {
      _load = Load.processing;
      notifyListeners();
      Reference imageReference = firebaseStorage.ref().child(
          "$userId/shops/image${DateTime.now().millisecondsSinceEpoch.toString()}");

      File? newImage = File(croppedFile.path);

      UploadTask? uploadTask = imageReference.putFile(newImage);
      TaskSnapshot taskSnapshot = await uploadTask;
      final url = await taskSnapshot.ref.getDownloadURL();

      DocumentReference documentReference = collectionReference.doc(shopId);

      await documentReference.update({
        Constants.imgUrls: FieldValue.arrayUnion([url]),
        Constants.updatedAt: DateTime.now().millisecondsSinceEpoch.toString(),
      }).then((_) {
        _load = Load.processComplete;
        notifyListeners();
      });

      return 'Shop image added successfully! ✅';
    } on FirebaseException catch (e) {
      _load = Load.processError;
      notifyListeners();

      return e.message;
    }
  }

  Future deleteImg(String shopId, String url) async {
    try {
      _load = Load.processing;
      notifyListeners();
      DocumentReference documentReference = collectionReference.doc(shopId);

      documentReference.update({
        Constants.imgUrls: FieldValue.arrayRemove([url])
      }).then((_) async {
        Reference imageReference = firebaseStorage.refFromURL(url);

        await imageReference.delete().then((_) {
          _load = Load.processComplete;
          notifyListeners();
        });
      });

      return 'Shop image deleted successfully! ✅';
    } on FirebaseException catch (e) {
      _load = Load.processError;
      notifyListeners();

      return e.message;
    }
  }

  Future deleteShop(String shopId, String userId) async {
    try {
      _load = Load.processing;
      notifyListeners();
      DocumentReference documentReference = collectionReference.doc(shopId);
      DocumentReference userDocumentRef = userCollectionRef.doc(userId);
      QuerySnapshot querySnapshot = await productCollectionRef
          .where(Constants.shopId, isEqualTo: shopId)
          .get();

      await userDocumentRef.update({Constants.shopId: ''});

      for (var doc in querySnapshot.docs) {
        await doc.reference.delete();
      }

      await documentReference.delete().then((_) {
        _load = Load.processComplete;
        notifyListeners();

        return 'Your shop has been successfully deleted ✅';
      });
    } on FirebaseException catch (e) {
      _load = Load.processError;
      notifyListeners();

      return e.message;
    }
  }

  Future getShopData(String shopId) async {
    _load = Load.processing;
    notifyListeners();
    DocumentSnapshot documentSnapshot =
        await collectionReference.doc(shopId).get();

    _load = Load.processComplete;
    notifyListeners();

    return documentSnapshot;
  }

  Future fetchAllShops() async {
    _load = Load.processing;
    notifyListeners();
    QuerySnapshot querySnapshot = await collectionReference.get();

    _load = Load.processComplete;
    notifyListeners();

    return querySnapshot;
  }

  Future searchShops(String query) async {
    try {
      _load = Load.processing;
      notifyListeners();
      QuerySnapshot querySnapshot = await collectionReference.get();
      List<DocumentSnapshot> documentSnapshot = querySnapshot.docs;
      List shops = [];
      List<String> queries = query.split(' ');

      if (documentSnapshot.isNotEmpty) {
        for (var i = 0; i < documentSnapshot.length; i++) {
          String name = documentSnapshot[i][Constants.shopName];

          for (var a = 0; a < queries.length; a++) {
            if (name.contains(queries[a])) {
              shops.add(documentSnapshot[i]);
              break;
            }
          }
        }

        for (var i = 0; i < documentSnapshot.length; i++) {
          String category = documentSnapshot[i][Constants.shopAddress];

          for (var a = 0; a < queries.length; a++) {
            if (category.contains(queries[a])) {
              shops.add(documentSnapshot[i]);
              break;
            }
          }
        }

        for (var i = 0; i < documentSnapshot.length; i++) {
          String shopName = documentSnapshot[i][Constants.shopName];

          for (var a = 0; a < queries.length; a++) {
            if (shopName.contains(queries[a])) {
              shops.add(documentSnapshot[i]);
              break;
            }
          }
        }

        for (var i = 0; i < documentSnapshot.length; i++) {
          List<String> tags = documentSnapshot[i][Constants.shopTags];

          outer3:
          for (var a = 0; a < queries.length; a++) {
            for (var b = 0; b < tags.length; b++) {
              if (tags[b].contains(queries[a])) {
                shops.add(documentSnapshot[i]);
                break outer3;
              }
            }
          }
        }

        _load = Load.processComplete;
        notifyListeners();

        return shops;
      } else {
        _load = Load.processComplete;
        notifyListeners();

        return shops;
      }
    } on FirebaseException catch (e) {
      _load = Load.processError;
      notifyListeners();

      return e.message;
    }
  }
}
