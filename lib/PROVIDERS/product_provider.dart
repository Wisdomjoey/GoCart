import 'dart:io';

import 'package:GOCart/CONSTANTS/constants.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_cropper/image_cropper.dart';

enum Process { processing, processComplete, processError, uninitialized }

class ProductProvider extends ChangeNotifier {
  Process _process = Process.uninitialized;

  Process get process => _process;

  CollectionReference productCollectionRef =
      FirebaseFirestore.instance.collection(Constants.collectionProducts);

  FirebaseStorage firebaseStorage = FirebaseStorage.instance;

  Future createProduct(
      String shopName,
      String name,
      String? description,
      double? oldPrice,
      double? newPrice,
      double? minPrice,
      double deliveryPrice,
      String category,
      List<CroppedFile> croppedFiles,
      int? totalStock,
      List<String> tags,
      String shopId,
      String userId,
      List<String>? specifications,
      List<String>? keyFeatures) async {
    try {
      List<String> newUrls = [];
      int counter = 1;
      _process = Process.processing;
      notifyListeners();

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

      DocumentReference documentReference = await productCollectionRef.add({
        Constants.uid: '',
        Constants.name: name,
        Constants.prodDescription: description,
        Constants.prodOldPrice: oldPrice,
        Constants.sales: 0,
        Constants.prodTotalSales: 0,
        Constants.userId: userId,
        Constants.prodCategory: category,
        Constants.prodSpecifications: specifications,
        Constants.prodKeyFeatures: keyFeatures,
        Constants.shopName: shopName,
        Constants.shopId: shopId,
        Constants.prodNewPrice: newPrice,
        Constants.prodMinPrice: minPrice,
        Constants.deliveryPrice: deliveryPrice,
        Constants.prodTags: tags,
        Constants.prodTotalStock: totalStock,
        Constants.imgUrls: newUrls,
        Constants.prodRating: 0.0,
        Constants.createdAt: DateTime.now().millisecondsSinceEpoch.toString(),
        Constants.updatedAt: DateTime.now().millisecondsSinceEpoch.toString(),
      });

      await documentReference
          .update({Constants.uid: documentReference.id}).then((_) {
        _process = Process.processComplete;
        notifyListeners();
      });

      return 'Product created successfully! ✅';
    } on FirebaseException catch (e) {
      _process = Process.processError;
      notifyListeners();

      return e.message;
    }
  }

  Future updateProduct(Map<String, dynamic> data, String productId) async {
    _process = Process.processing;
    notifyListeners();
    DocumentReference documentReference = productCollectionRef.doc(productId);

    await documentReference.update(data).then((_) {
      _process = Process.processComplete;
      notifyListeners();

      return 'Product updated successfully! ✅';
    }).catchError((e) {
      _process = Process.processError;
      notifyListeners();

      return e;
    });
  }

  Future addImage(
      CroppedFile croppedFile, String userId, String productId) async {
    try {
      _process = Process.processing;
      notifyListeners();
      Reference imageReference = firebaseStorage.ref().child(
          "$userId/products/image${DateTime.now().millisecondsSinceEpoch.toString()}");

      File? newImage = File(croppedFile.path);

      UploadTask? uploadTask = imageReference.putFile(newImage);
      TaskSnapshot taskSnapshot = await uploadTask;
      final url = await taskSnapshot.ref.getDownloadURL();

      DocumentReference documentReference = productCollectionRef.doc(productId);

      await documentReference.update({
        Constants.imgUrls: FieldValue.arrayUnion([url]),
        Constants.updatedAt: DateTime.now().millisecondsSinceEpoch.toString(),
      }).then((_) {
        _process = Process.processComplete;
        notifyListeners();

        return 'Product image added successfully! ✅';
      });
    } on FirebaseException catch (e) {
      _process = Process.processError;
      notifyListeners();

      return e.message;
    }
  }

  Future deleteImg(String productId, String url) async {
    try {
      _process = Process.processing;
      notifyListeners();
      DocumentReference documentReference = productCollectionRef.doc(productId);

      documentReference.update({
        Constants.imgUrls: FieldValue.arrayRemove([url])
      }).then((_) async {
        Reference imageReference = firebaseStorage.refFromURL(url);

        await imageReference.delete().then((_) {
          _process = Process.processComplete;
          notifyListeners();
        });
      });

      return 'Product image deleted successfully! ✅';
    } on FirebaseException catch (e) {
      _process = Process.processError;
      notifyListeners();

      return e.message;
    }
  }

  Future deleteProduct(String productId, List<String> urls) async {
    _process = Process.processing;
    notifyListeners();
    DocumentReference documentReference = productCollectionRef.doc(productId);

    await documentReference.delete().then((_) async {
      for (var url in urls) {
        Reference imageReference = firebaseStorage.refFromURL(url);

        await imageReference.delete().then((_) {
          _process = Process.processComplete;
          notifyListeners();
        }).catchError((err) {
          _process = Process.processError;
          notifyListeners();

          return err;
        });
      }

      return 'Product deleted successfully! ✅';
    }).catchError((err) {
      _process = Process.processError;
      notifyListeners();

      return err;
    });
  }

  Future getAllShopProducts(String userId) async {
    QuerySnapshot querySnapshot = await productCollectionRef
        .where(Constants.userId, isEqualTo: userId)
        .get();

    return querySnapshot;
  }

  Future getAllProducts() async {
    QuerySnapshot querySnapshot = await productCollectionRef.get();

    return querySnapshot;
  }

  Future searchProducts(String query) async {
    try {
      _process = Process.processing;
      notifyListeners();
      QuerySnapshot querySnapshot = await productCollectionRef.get();
      List<DocumentSnapshot> documentSnapshot = querySnapshot.docs;
      List products = [];
      List<String> queries = query.split(' ');

      for (var i = 0; i < documentSnapshot.length; i++) {
        String name = documentSnapshot[i][Constants.name];

        for (var a = 0; a < queries.length; a++) {
          if (name.contains(queries[a])) {
            products.add(documentSnapshot[i]);
            break;
          }
        }
      }

      for (var i = 0; i < documentSnapshot.length; i++) {
        String description = documentSnapshot[i][Constants.prodDescription];

        for (var a = 0; a < queries.length; a++) {
          if (description.contains(queries[a])) {
            products.add(documentSnapshot[i]);
            break;
          }
        }
      }

      for (var i = 0; i < documentSnapshot.length; i++) {
        String category = documentSnapshot[i][Constants.prodCategory];

        for (var a = 0; a < queries.length; a++) {
          if (category.contains(queries[a])) {
            products.add(documentSnapshot[i]);
            break;
          }
        }
      }

      for (var i = 0; i < documentSnapshot.length; i++) {
        List<String> specifications =
            documentSnapshot[i][Constants.prodSpecifications];

        outer1:
        for (var a = 0; a < queries.length; a++) {
          for (var b = 0; b < specifications.length; b++) {
            if (specifications[b].contains(queries[a])) {
              products.add(documentSnapshot[i]);
              break outer1;
            }
          }
        }
      }

      for (var i = 0; i < documentSnapshot.length; i++) {
        List<String> keyFeatures =
            documentSnapshot[i][Constants.prodKeyFeatures];

        outer2:
        for (var a = 0; a < queries.length; a++) {
          for (var b = 0; b < keyFeatures.length; b++) {
            if (keyFeatures[b].contains(queries[a])) {
              products.add(documentSnapshot[i]);
              break outer2;
            }
          }
        }
      }

      for (var i = 0; i < documentSnapshot.length; i++) {
        String shopName = documentSnapshot[i][Constants.shopName];

        for (var a = 0; a < queries.length; a++) {
          if (shopName.contains(queries[a])) {
            products.add(documentSnapshot[i]);
            break;
          }
        }
      }

      for (var i = 0; i < documentSnapshot.length; i++) {
        List<String> tags = documentSnapshot[i][Constants.prodTags];

        outer3:
        for (var a = 0; a < queries.length; a++) {
          for (var b = 0; b < tags.length; b++) {
            if (tags[b].contains(queries[a])) {
              products.add(documentSnapshot[i]);
              break outer3;
            }
          }
        }
      }

      _process = Process.processComplete;
      notifyListeners();

      return products;
    } on FirebaseException catch (e) {
      _process = Process.processError;
      notifyListeners();

      return e.message;
    }
  }

  Future searchProductByCategory(String categoryQ) async {
    try {
      _process = Process.processing;
      notifyListeners();
      QuerySnapshot querySnapshot = await productCollectionRef.get();
      List<DocumentSnapshot> documentSnapshot = querySnapshot.docs;
      List products = [];

      for (var i = 0; i < documentSnapshot.length; i++) {
        String category = documentSnapshot[i][Constants.prodCategory];

        if (category.contains(categoryQ)) {
          products.add(documentSnapshot[i]);
        }
      }

      _process = Process.processComplete;
      notifyListeners();

      return products;
    } on FirebaseException catch (e) {
      _process = Process.processError;
      notifyListeners();

      return e.message;
    }
  }

  Future getProductData(String productId) async {
    try {
      _process = Process.processing;
      notifyListeners();
      DocumentSnapshot documentSnapshot =
          await productCollectionRef.doc(productId).get();

      _process = Process.processComplete;
      notifyListeners();

      return documentSnapshot;
    } on FirebaseException catch (e) {
      _process = Process.processError;
      notifyListeners();

      return e.message;
    }
  }

  Future uploadRating(String productId, int rateNo) async {
    try {
      _process = Process.processing;
      notifyListeners();
      CollectionReference collectionReference = productCollectionRef
          .doc(productId)
          .collection(Constants.collectionReviews);

      DocumentReference documentReference = await collectionReference.add({
        Constants.uid: '',
        Constants.reviewStarNo: rateNo,
        Constants.name: '',
        Constants.reviewTitle: '',
        Constants.reviewBody: '',
        Constants.createdAt: DateTime.now().millisecondsSinceEpoch.toString(),
        Constants.updatedAt: DateTime.now().millisecondsSinceEpoch.toString(),
      });

      await documentReference
          .update({Constants.uid: documentReference.id}).then((_) {
        _process = Process.processComplete;
        notifyListeners();
      });

      return 'Rating uploaded successfully! ✅';
    } on FirebaseException catch (e) {
      _process = Process.processError;
      notifyListeners();

      return e.message;
    }
  }

  Future uploadReview(String productId, String name, String title, String body,
      String reviewId) async {
    try {
      _process = Process.processing;
      notifyListeners();
      DocumentReference documentReference = productCollectionRef
          .doc(productId)
          .collection(Constants.collectionReviews)
          .doc(reviewId);

      await documentReference.update({
        Constants.name: name,
        Constants.reviewTitle: title,
        Constants.reviewBody: body,
        Constants.updatedAt: DateTime.now().millisecondsSinceEpoch.toString(),
      }).then((value) {
        _process = Process.processComplete;
        notifyListeners();
      });

      return 'Review uploaded successfully! ✅';
    } on FirebaseException catch (e) {
      _process = Process.processError;
      notifyListeners();

      return e.message;
    }
  }

  Future fetchAllReviews(String productId) async {
    QuerySnapshot querySnapshot = await productCollectionRef
        .doc(productId)
        .collection(Constants.collectionReviews)
        .get();

    return querySnapshot;
  }
}
