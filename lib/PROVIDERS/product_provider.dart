import 'dart:io';

import 'package:GOCart/CONSTANTS/constants.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_cropper/image_cropper.dart';

enum Process { processing, processComplete, processError, uninitialized }

class ProductProvider extends ChangeNotifier {
  final BuildContext context;

  ProductProvider(this.context);

  Process _process = Process.uninitialized;
  Process get process => _process;

  CollectionReference productCollectionRef =
      FirebaseFirestore.instance.collection(Constants.collectionProducts);

  FirebaseStorage firebaseStorage = FirebaseStorage.instance;

  Future createProduct(
      String shopName,
      String name,
      String description,
      double oldPrice,
      double newPrice,
      double minPrice,
      double deliveryPrice,
      String category,
      List<CroppedFile> croppedFiles,
      int totalStock,
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

        Constants(context).snackBar(
            'Product has been created successfully! ✅', Constants.tetiary);
      });

      return true;
    } on FirebaseException catch (e) {
      _process = Process.processError;
      notifyListeners();

      Constants(context).snackBar(e.message!, Colors.red);

      return false;
    }
  }

  Future updateProduct(Map<String, dynamic> data, String productId) async {
    try {
      _process = Process.processing;
      notifyListeners();
      DocumentReference documentReference = productCollectionRef.doc(productId);

      await documentReference.update(data).then((_) {
        _process = Process.processComplete;
        notifyListeners();

        Constants(context).snackBar(
            'Product has been updated successfully! ✅', Constants.tetiary);
      });

      return true;
    } on FirebaseException catch (e) {
      _process = Process.processError;
      notifyListeners();

      Constants(context).snackBar(e.message!, Colors.red);

      return false;
    }
  }

  Future addImage(
      List<CroppedFile> croppedFiles, String userId, String productId) async {
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

      DocumentReference documentReference = productCollectionRef.doc(productId);

      await documentReference.update({
        Constants.imgUrls: FieldValue.arrayUnion(newUrls),
        Constants.updatedAt: DateTime.now().millisecondsSinceEpoch.toString(),
      }).then((_) {
        _process = Process.processComplete;
        notifyListeners();

        Constants(context)
            .snackBar('Image added successfully! ✅', Constants.tetiary);
      });

      return true;
    } on FirebaseException catch (e) {
      _process = Process.processError;
      notifyListeners();

      Constants(context).snackBar(e.message!, Colors.red);

      return false;
    }
  }

  Future deleteImg(String productId, String url) async {
    try {
      _process = Process.processing;
      notifyListeners();
      DocumentReference documentReference = productCollectionRef.doc(productId);

      Reference imageReference = firebaseStorage.refFromURL(url);

      await imageReference.delete().then((_) async {
        await documentReference.update({
          Constants.imgUrls: FieldValue.arrayRemove([url])
        }).then((_) async {
          _process = Process.processComplete;
          notifyListeners();

          Constants(context)
              .snackBar('Image deleted successfully! ✅', Constants.tetiary);
        });
      });

      return true;
    } on FirebaseException catch (e) {
      _process = Process.processError;
      notifyListeners();

      Constants(context).snackBar(e.message!, Colors.red);

      return false;
    }
  }

  Future deleteProduct(String productId) async {
    try {
      _process = Process.processing;
      notifyListeners();
      DocumentReference documentReference = productCollectionRef.doc(productId);

      DocumentSnapshot documentSnapshot = await documentReference.get();

      List urls = documentSnapshot.get(Constants.imgUrls);

      await documentReference.delete().then((_) async {
        for (var url in urls) {
          Reference imageReference = firebaseStorage.refFromURL(url);

          await imageReference.delete();
        }
      });

      _process = Process.processComplete;
      notifyListeners();

      return true;
    } on FirebaseException catch (e) {
      _process = Process.processError;
      notifyListeners();

      Constants(context).snackBar(e.message!, Colors.red);

      return false;
    }
  }

  Stream<QuerySnapshot> getAllProducts() {
    return productCollectionRef.snapshots();
  }

  Future searchProducts(String query) async {
    try {
      _process = Process.processing;
      // notifyListeners();
      QuerySnapshot querySnapshot = await productCollectionRef.get();
      List<DocumentSnapshot> documentSnapshot = querySnapshot.docs;
      List products = [];
      List<String> queries = query.trim().toLowerCase().split(' ');

      outer:
      for (var i = 0; i < documentSnapshot.length; i++) {
        String name =
            documentSnapshot[i].get(Constants.name).trim().toLowerCase();
        String description =
            documentSnapshot[i][Constants.prodDescription].trim().toLowerCase();
        String category =
            documentSnapshot[i][Constants.prodCategory].trim().toLowerCase();
        List specifications =
            documentSnapshot[i].get(Constants.prodSpecifications);
        List keyFeatures = documentSnapshot[i].get(Constants.prodKeyFeatures);
        List tags = documentSnapshot[i].get(Constants.prodTags);
        String shopName =
            documentSnapshot[i].get(Constants.shopName).trim().toLowerCase();

        // outer1:
        // for (var a = 0; a < queries.length; a++) {
        //   outer2:
        //   for (var element in specifications) {
        //     outer3:
        //     for (var element1 in keyFeatures) {
        //       outer4:
        //       for (var element2 in tags) {
        //         if (name.contains(queries[a])) {
        //           products.add(documentSnapshot[i].data());
        //           break outer1;
        //         } else if (description.contains(queries[a])) {
        //           products.add(documentSnapshot[i].data());
        //           break outer1;
        //         } else if (category.contains(queries[a])) {
        //           print('yay!!!');
        //           products.add(documentSnapshot[i].data());
        //           break outer1;
        //         } else if (shopName.contains(queries[a])) {
        //           products.add(documentSnapshot[i].data());
        //           break outer1;
        //         } else if (element.trim().toLowerCase().contains(queries[a])) {
        //           products.add(documentSnapshot[i].data());
        //           break outer2;
        //         } else if (element1.trim().toLowerCase().contains(queries[a])) {
        //           products.add(documentSnapshot[i].data());
        //           break outer3;
        //         } else if (element2.trim().toLowerCase().contains(queries[a])) {
        //           products.add(documentSnapshot[i].data());
        //           break outer4;
        //         }
        //       }
        //     }
        //   }
        // }

        if (documentSnapshot[i].get(Constants.prodCategory) == 'Cooked Foods') {
          continue outer;
        }

        for (var a = 0; a < queries.length; a++) {
          if (name.contains(queries[a])) {
            products.add(documentSnapshot[i].data());
            continue outer;
          }
        }

        for (var a = 0; a < queries.length; a++) {
          if (description.contains(queries[a])) {
            products.add(documentSnapshot[i].data());
            continue outer;
          }
        }

        for (var a = 0; a < queries.length; a++) {
          if (category.contains(queries[a])) {
            products.add(documentSnapshot[i].data());
            continue outer;
          }
        }

        for (var a = 0; a < queries.length; a++) {
          for (var b = 0; b < specifications.length; b++) {
            if (specifications[b].contains(queries[a])) {
              products.add(documentSnapshot[i].data());
              continue outer;
            }
          }
        }

        for (var a = 0; a < queries.length; a++) {
          for (var b = 0; b < keyFeatures.length; b++) {
            if (keyFeatures[b].contains(queries[a])) {
              products.add(documentSnapshot[i].data());
              continue outer;
            }
          }
        }

        for (var a = 0; a < queries.length; a++) {
          if (shopName.contains(queries[a])) {
            products.add(documentSnapshot[i].data());
            continue outer;
          }
        }

        for (var a = 0; a < queries.length; a++) {
          for (var b = 0; b < tags.length; b++) {
            if (tags[b].contains(queries[a])) {
              products.add(documentSnapshot[i].data());
              continue outer;
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

      Constants(context).snackBar(e.message!, Colors.red);

      return [];
    }
  }

  Future searchProductByCategory(String categoryQ) async {
    try {
      _process = Process.processing;
      // notifyListeners();
      QuerySnapshot querySnapshot = await productCollectionRef.get();
      List<DocumentSnapshot> documentSnapshot = querySnapshot.docs;
      List products = [];

      for (var i = 0; i < documentSnapshot.length; i++) {
        String category = documentSnapshot[i][Constants.prodCategory];

        if (category.contains(categoryQ)) {
          products.add(documentSnapshot[i].data());
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
      // notifyListeners();
      DocumentSnapshot documentSnapshot =
          await productCollectionRef.doc(productId).get();

      _process = Process.processComplete;
      notifyListeners();

      return documentSnapshot.data();
    } on FirebaseException catch (e) {
      _process = Process.processError;
      notifyListeners();

      Constants(context).snackBar(e.message!, Colors.red);

      return {};
    }
  }

  Future uploadReview(String productId, String name, String title, String body,
      int rateNo, double? rating) async {
    try {
      _process = Process.processing;
      // notifyListeners();
      CollectionReference collectionReference = productCollectionRef
          .doc(productId)
          .collection(Constants.collectionReviews);

      DocumentReference documentReference = await collectionReference.add({
        Constants.uid: '',
        Constants.userId: FirebaseAuth.instance.currentUser!.uid,
        Constants.reviewStarNo: rateNo,
        Constants.name: name,
        Constants.reviewTitle: title,
        Constants.reviewBody: body,
        Constants.createdAt: DateTime.now().millisecondsSinceEpoch.toString(),
        Constants.updatedAt: DateTime.now().millisecondsSinceEpoch.toString(),
      });

      await documentReference
          .update({Constants.uid: documentReference.id}).then((_) async {
        updateProduct({
          Constants.prodRating: rating ?? rateNo.toDouble(),
        }, productId)
            .then((value) {
          _process = Process.processComplete;
          notifyListeners();

          Constants(context)
              .snackBar('Review uploaded successfully! ✅', Constants.tetiary);
        });
      });

      return true;
    } on FirebaseException catch (e) {
      _process = Process.processError;
      notifyListeners();

      Constants(context).snackBar(e.message!, Colors.red);

      return false;
    }
  }

  Future fetchAllReviews(String productId) async {
    try {
      _process = Process.processing;
      // notifyListeners();
      QuerySnapshot querySnapshot = await productCollectionRef
          .doc(productId)
          .collection(Constants.collectionReviews)
          .get();

      List data = [];

      for (var element in querySnapshot.docs) {
        data.add(element.data());
      }

      return data;
    } on FirebaseException catch (e) {
      _process = Process.processError;
      notifyListeners();

      Constants(context).snackBar(e.message!, Colors.red);

      return [];
    }
  }
}
