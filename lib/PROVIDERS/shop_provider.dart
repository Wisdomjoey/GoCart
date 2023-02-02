import 'dart:io';

import 'package:GOCart/CONSTANTS/constants.dart';
import 'package:GOCart/PREFS/preferences.dart';
import 'package:GOCart/PROVIDERS/user_provider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

enum Load { processing, processComplete, processError, uninitialized }

class ShopProvider extends ChangeNotifier {
  ShopProvider(this.context);

  CollectionReference collectionReference =
      FirebaseFirestore.instance.collection(Constants.collectionShops);

  final BuildContext context;
  FirebaseStorage firebaseStorage = FirebaseStorage.instance;
  CollectionReference productCollectionRef =
      FirebaseFirestore.instance.collection(Constants.collectionProducts);

  CollectionReference userCollectionRef =
      FirebaseFirestore.instance.collection(Constants.collectionUsers);

  Load _load = Load.uninitialized;
  List _shops = [];

  Load get load => _load;

  List get shops => _shops;

  Future createShop(
      String shopName,
      String location,
      List<String> tags,
      List<CroppedFile> croppedFiles,
      String userId,
      List<String> category,
      BuildContext context1) async {
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
        Constants.prodCategory: category,
        Constants.imgUrls: newUrls,
        Constants.sales: [],
        Constants.likes: [],
        Constants.userId: userId,
        Constants.createdAt: DateTime.now().millisecondsSinceEpoch.toString(),
        Constants.updatedAt: DateTime.now().millisecondsSinceEpoch.toString(),
      });

      await userDocumentRef.update({Constants.shopId: documentReference.id});

      await documentReference
          .update({Constants.uid: documentReference.id}).then((_) async {
        _load = Load.processComplete;
        notifyListeners();

        await Provider.of<UserProvider>(context1, listen: false).updateUserData(
            {Constants.userIsSeller: true}, userId).then((value) async {
          // Preferences().saveBoolData(Constants.userIsSeller, true);

          await fetchAllShops().then((value) {
            Constants(context).snackBar(
                'Your shop has been registered successfully! ✅',
                Constants.tetiary);
          });
        });
      });

      return true;
    } on FirebaseException catch (e) {
      _load = Load.processError;
      notifyListeners();

      Constants(context).snackBar(e.message!, Colors.red);

      return false;
    }
  }

  Future updateShop(Map<String, dynamic> data, String shopId) async {
    try {
      _load = Load.processing;
      notifyListeners();
      DocumentReference documentReference = collectionReference.doc(shopId);

      await documentReference.update(data).then((_) async {
        await fetchAllShops().then((value) {
          _load = Load.processComplete;
          notifyListeners();

          Constants(context).snackBar(
              'Shop details updated successfully! ✅', Constants.tetiary);
        });
      });

      return true;
    } on FirebaseException catch (e) {
      _load = Load.processError;
      notifyListeners();

      Constants(context).snackBar(e.message!, Colors.red);

      return false;
    }
  }

  Future likeShop(Map<String, dynamic> data, String shopId) async {
    try {
      _load = Load.processing;
      notifyListeners();
      DocumentReference documentReference = collectionReference.doc(shopId);

      await documentReference.update(data).then((_) async {
        await fetchAllShops().then((value) {
          _load = Load.processComplete;
          notifyListeners();
        });
      });

      return true;
    } on FirebaseException catch (e) {
      _load = Load.processError;
      notifyListeners();

      Constants(context).snackBar(e.message!, Colors.red);

      return false;
    }
  }

  Future updateShopSales(String shopId, double amount) async {
    try {
      _load = Load.processing;
      notifyListeners();
      DocumentReference documentReference = collectionReference.doc(shopId);
      DocumentSnapshot documentSnapshot = await documentReference.get();

      List data = documentSnapshot[Constants.sales];
      String month = DateFormat('MMM').format(DateTime.now());

      if (data.isNotEmpty) {
        Map<String, dynamic> map = data[data.length - 1];

        if (map[Constants.month] == month) {
          data[data.length - 1] = {
            Constants.month: map[Constants.month],
            Constants.sales: map[Constants.sales] + amount,
            Constants.prodTotalSales: map[Constants.prodTotalSales] + 1
          };
        } else {
          data.add({
            Constants.month: map[Constants.month],
            Constants.sales: map[Constants.sales] + amount,
            Constants.prodTotalSales: map[Constants.prodTotalSales] + 1
          });
        }
      } else {
        data.add({
          Constants.month: month,
          Constants.sales: amount,
          Constants.prodTotalSales: 1
        });
      }

      await documentReference.update({Constants.sales: data}).then((_) async {
        _load = Load.processComplete;
        notifyListeners();

        await fetchAllShops();
      });

      return true;
    } on FirebaseException catch (e) {
      Constants(context).snackBar(e.message!, Colors.red);

      return false;
    }
  }

  Future addImage(List<CroppedFile> croppedFiles, String userId, String shopId) async {
    try {
      List<String> newUrls = [];
      int counter = 1;
      _load = Load.processing;
      notifyListeners();

      for (var element in croppedFiles) {
        Reference imageReference = firebaseStorage.ref().child(
            "$userId/shops/image$counter${DateTime.now().millisecondsSinceEpoch.toString()}");

        File? newImage = File(element.path);

        UploadTask? uploadTask = imageReference.putFile(newImage);
        TaskSnapshot taskSnapshot = await uploadTask;
        final url = await taskSnapshot.ref.getDownloadURL();

        newUrls.add(url);
        counter++;
      }

      DocumentReference documentReference = collectionReference.doc(shopId);

      await documentReference.update({
        Constants.imgUrls: FieldValue.arrayUnion(newUrls),
        Constants.updatedAt: DateTime.now().millisecondsSinceEpoch.toString(),
      }).then((_) async {
        await fetchAllShops().then((value) {
          _load = Load.processComplete;
          notifyListeners();

          Constants(context)
              .snackBar('Shop image added successfully! ✅', Constants.tetiary);
        });
      });

      return true;
    } on FirebaseException catch (e) {
      _load = Load.processError;
      notifyListeners();

      Constants(context).snackBar(e.message!, Colors.red);

      return false;
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

        await imageReference.delete().then((_) async {
          _load = Load.processComplete;
          notifyListeners();

          await fetchAllShops().then((value) {
            Constants(context).snackBar(
                'Shop image has been deleted successfully! ✅',
                Constants.tetiary);
          });
        });
      });

      return true;
    } on FirebaseException catch (e) {
      _load = Load.processError;
      notifyListeners();

      Constants(context).snackBar(e.message!, Colors.red);

      return false;
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

      await documentReference.delete().then((_) async {
        _load = Load.processComplete;
        notifyListeners();

        await fetchAllShops().then((value) {
          Constants(context).snackBar(
              'Your shop has been closed down successfully! ✅',
              Constants.tetiary);
        });
      });

      return true;
    } on FirebaseException catch (e) {
      _load = Load.processError;
      notifyListeners();

      Constants(context).snackBar(e.message!, Colors.red);

      return false;
    }
  }

  Future getShopData(String shopId) async {
    try {
      _load = Load.processing;
      // notifyListeners();
      DocumentSnapshot documentSnapshot =
          await collectionReference.doc(shopId).get();

      _load = Load.processComplete;
      notifyListeners();

      return documentSnapshot.data();
    } on FirebaseException catch (e) {
      _load = Load.processError;
      notifyListeners();

      Constants(context).snackBar(e.message!, Colors.red);

      return {};
    }
  }

  Future fetchAllShops() async {
    try {
      _load = Load.processing;
      notifyListeners();
      QuerySnapshot querySnapshot = await collectionReference.get();

      _load = Load.processComplete;
      _shops = [];
      for (var element in querySnapshot.docs) {
        _shops.add(element.data());
      }
      notifyListeners();
    } on FirebaseException catch (e) {
      _load = Load.processError;
      _shops = [];
      notifyListeners();

      Constants(context).snackBar(e.message!, Colors.red);
    }
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

      Constants(context).snackBar(e.message!, Colors.red);

      return false;
    }
  }

  Stream<QuerySnapshot> getAllShopProducts(String shopId) {
      return productCollectionRef
          .where(Constants.shopId, isEqualTo: shopId)
          .snapshots(includeMetadataChanges: true);
  }
}
