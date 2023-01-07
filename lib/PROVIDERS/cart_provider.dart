import 'dart:convert';

import 'package:GOCart/CONSTANTS/constants.dart';
import 'package:GOCart/PREFS/preferences.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class CartProvider extends ChangeNotifier {
  int _cartListNo = 0;
  Map<String, dynamic> _cart = {};

  int get cartListNo => _cartListNo;
  Map<String, dynamic> get cart => _cart;

  CollectionReference userCollectionRef =
      FirebaseFirestore.instance.collection(Constants.collectionUsers);
  CollectionReference productCollectionRef =
      FirebaseFirestore.instance.collection(Constants.collectionProducts);

  Future initializeCart(String userId, String cartData) async {
    QuerySnapshot foodSnapshot = await userCollectionRef
        .doc(userId)
        .collection(Constants.collectionFoodCart)
        .get();
    QuerySnapshot cartSnapshot = await userCollectionRef
        .doc(userId)
        .collection(Constants.collectionCart)
        .get();

    _cartListNo = foodSnapshot.docs.length + cartSnapshot.docs.length;
    _cart = jsonDecode(cartData);
    notifyListeners();
  }

  // Future initializeCart(String userId) async {
  //   QuerySnapshot cartSnapshot = await userCollectionRef
  //       .doc(userId)
  //       .collection(Constants.collectionCart)
  //       .get();

  //   for (var i = 0; i < cartSnapshot.docs.length; i++) {
  //     _cart[cartSnapshot.docs[i][Constants.productId]] =
  //         cartSnapshot.docs[i][Constants.quantity];
  //   }

  //   notifyListeners();
  // }

  Future addToCart(
      String userId, String productId, double? amount, String shopName) async {
    try {
      QuerySnapshot querySnapshot = await productCollectionRef
          .where(Constants.prodCategory, isEqualTo: 'cooked')
          .where(Constants.uid, isEqualTo: productId)
          .get();

      if (querySnapshot.docs.isNotEmpty) {
        CollectionReference collectionReference = userCollectionRef
            .doc(userId)
            .collection(Constants.collectionFoodCart);
        QuerySnapshot querySnapshot = await collectionReference
            .where(Constants.shopName, isEqualTo: shopName)
            .get();

        if (querySnapshot.docs.isNotEmpty) {
          DocumentReference documentReference =
              collectionReference.doc(querySnapshot.docs[0][Constants.uid]);

          documentReference.update({
            Constants.productId: FieldValue.arrayUnion([productId]),
            Constants.amount: FieldValue.arrayUnion([amount]),
            Constants.updatedAt:
                DateTime.now().millisecondsSinceEpoch.toString(),
          });
        } else {
          DocumentReference documentReference = await collectionReference.add({
            Constants.uid: '',
            Constants.productId: [productId],
            Constants.amount: [amount],
            Constants.shopName: shopName,
            Constants.quantity: 1,
            Constants.createdAt:
                DateTime.now().millisecondsSinceEpoch.toString(),
            Constants.updatedAt:
                DateTime.now().millisecondsSinceEpoch.toString(),
          });

          await documentReference.update({
            Constants.uid: documentReference.id,
          });
        }

        _cart['food'] = 1;
        Preferences()
            .saveStringData(Constants.prefsCartData, jsonEncode(_cart));
        _cartListNo++;
        notifyListeners();
      } else {
        DocumentSnapshot snapshot =
            await productCollectionRef.doc(productId).get();

        if (snapshot[Constants.prodTotalStock] > 0) {
          CollectionReference collectionReference = userCollectionRef
              .doc(userId)
              .collection(Constants.collectionCart);

          DocumentReference documentReference = await collectionReference.add({
            Constants.uid: '',
            Constants.quantity: 1,
            Constants.productId: [productId],
            Constants.amount: [amount],
            Constants.shopName: shopName,
            Constants.createdAt:
                DateTime.now().millisecondsSinceEpoch.toString(),
            Constants.updatedAt:
                DateTime.now().millisecondsSinceEpoch.toString(),
          });

          await documentReference.update({
            Constants.uid: documentReference.id,
          });
        } else {
          return 'Product is out of stock ❗';
        }

        _cart[productId] = 1;
        Preferences()
            .saveStringData(Constants.prefsCartData, jsonEncode(_cart));
        _cartListNo++;
        notifyListeners();
      }

      // return 'Product added to cart successfully! ✅';
      return true;
    } on FirebaseException catch (e) {
      return e.message;
    }
  }

  Future removeFromCart(String userId, String productId, String cartId) async {
    try {
      DocumentReference documentReference = userCollectionRef
          .doc(userId)
          .collection(Constants.collectionCart)
          .doc(cartId);

      await documentReference.delete();

      _cart.remove(productId);
      Preferences().saveStringData(Constants.prefsCartData, jsonEncode(_cart));
      _cartListNo--;
      notifyListeners();

      // return 'Product removed from cart successfully! ✅';
      return true;
    } on FirebaseException catch (e) {
      return e.message;
    }
  }

  Future removeFromFoodCart(
      String userId, String productId, String cartId, double amount) async {
    try {
      DocumentReference documentReference = userCollectionRef
          .doc(userId)
          .collection(Constants.collectionFoodCart)
          .doc(cartId);

      await documentReference.update({
        Constants.productId: FieldValue.arrayRemove([productId]),
        Constants.amount: FieldValue.arrayRemove([amount]),
        Constants.updatedAt: DateTime.now().millisecondsSinceEpoch.toString(),
      });

      // return 'Product removed from cart successfully! ✅';
      return true;
    } on FirebaseException catch (e) {
      return e.message;
    }
  }

  Future increaseCartProduct(
      String? productId, String userId, String cartId, String category) async {
    if (category == 'food') {
      DocumentReference documentReference = userCollectionRef
          .doc(userId)
          .collection(Constants.collectionFoodCart)
          .doc(cartId);

      DocumentSnapshot cartDocSnapshot = await documentReference.get();
      int quantity = cartDocSnapshot[Constants.quantity];

      await documentReference.update({
        Constants.quantity: quantity + 1,
        Constants.updatedAt: DateTime.now().millisecondsSinceEpoch.toString(),
      }).then((_) {
        _cart.update('food', (value) => value++);
        Preferences()
            .saveStringData(Constants.prefsCartData, jsonEncode(_cart));
        notifyListeners();
      });

      return 'Your cart has been updated successfully! ✅';
    } else {
      DocumentReference documentReference = userCollectionRef
          .doc(userId)
          .collection(Constants.collectionCart)
          .doc(cartId);

      DocumentSnapshot cartDocSnapshot = await documentReference.get();
      int quantity = cartDocSnapshot[Constants.quantity];

      DocumentSnapshot documentSnapshot =
          await productCollectionRef.doc(productId).get();
      int stock = documentSnapshot[Constants.prodTotalStock];

      if (quantity + 1 > stock) {
        return 'No more products in stock ❗';
      } else {
        await documentReference.update({
          Constants.quantity: quantity + 1,
          Constants.updatedAt: DateTime.now().millisecondsSinceEpoch.toString(),
        }).then((_) {
          _cart.update(productId!, (value) => value++);
          Preferences()
              .saveStringData(Constants.prefsCartData, jsonEncode(_cart));
          notifyListeners();
        });

        return 'Your cart has been updated successfully! ✅';
      }
    }
  }

  Future decreaseCartProduct(
      String? productId, String userId, String cartId, String category) async {
    if (category == 'food') {
      DocumentReference documentReference = userCollectionRef
          .doc(userId)
          .collection(Constants.collectionFoodCart)
          .doc(cartId);

      DocumentSnapshot cartDocSnapshot = await documentReference.get();
      int quantity = cartDocSnapshot[Constants.quantity];

      await documentReference.update({
        Constants.quantity: quantity - 1,
        Constants.updatedAt: DateTime.now().millisecondsSinceEpoch.toString(),
      }).then((_) {
        _cart.update('food', (value) => value--);
        Preferences()
            .saveStringData(Constants.prefsCartData, jsonEncode(_cart));
        notifyListeners();
      });

      return 'Your cart has been updated successfully! ✅';
    } else {
      DocumentReference documentReference = userCollectionRef
          .doc(userId)
          .collection(Constants.collectionCart)
          .doc(cartId);

      DocumentSnapshot cartDocSnapshot = await documentReference.get();
      int quantity = cartDocSnapshot[Constants.quantity];

      DocumentSnapshot documentSnapshot =
          await productCollectionRef.doc(productId).get();
      int stock = documentSnapshot[Constants.prodTotalStock];

      if (quantity + 1 > stock) {
        return 'No more products in stock ❗';
      } else {
        await documentReference.update({
          Constants.quantity: quantity + 1,
          Constants.updatedAt: DateTime.now().millisecondsSinceEpoch.toString(),
        }).then((_) {
          _cart.update(productId!, (value) => value++);
          Preferences()
              .saveStringData(Constants.prefsCartData, jsonEncode(_cart));
          notifyListeners();
        });

        return 'Your cart has been updated successfully! ✅';
      }
    }
  }

  Future getCart(String userId) async {
    try {
      QuerySnapshot querySnapshot = await userCollectionRef
          .doc(userId)
          .collection(Constants.collectionCart)
          .get();

      return querySnapshot;
    } on FirebaseException catch (e) {
      return e.message;
    }
  }

  Future getFoodCart(String userId) async {
    try {
      QuerySnapshot querySnapshot = await userCollectionRef
          .doc(userId)
          .collection(Constants.collectionFoodCart)
          .get();

      return querySnapshot;
    } on FirebaseException catch (e) {
      return e.message;
    }
  }

  Future updateFoodCartItemAmount(
      String userId, double amount, String cartId, String productId) async {
    try {
      DocumentReference documentReference = userCollectionRef
          .doc(userId)
          .collection(Constants.collectionFoodCart)
          .doc(cartId);

      DocumentSnapshot documentSnapshot = await documentReference.get();

      List data = documentSnapshot[Constants.amount];

      int index = data.indexOf(amount);

      data[index] = amount;

      await documentReference.update({
        Constants.amount: data,
        Constants.updatedAt: DateTime.now().millisecondsSinceEpoch.toString(),
      }).then((_) {
        return 'Food amount has been changed successfully! ✅';
      });
    } on FirebaseException catch (e) {
      return e.message;
    }
  }
}
