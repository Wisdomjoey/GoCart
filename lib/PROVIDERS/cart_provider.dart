// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import 'package:GOCart/CONSTANTS/constants.dart';
import 'package:GOCart/PREFS/preferences.dart';

class CartProvider extends ChangeNotifier {
  final BuildContext context;

  CartProvider(this.context);

  int _cartListNo = 0;
  Map<String, dynamic> _cart = {};

  double _cartSubtotal = 0;
  double get cartSubtotal => _cartSubtotal;

  int get cartListNo => _cartListNo;
  Map<String, dynamic> get cart => _cart;

  List _carts = [];
  List get carts => _carts;

  List _foodCarts = [];
  List get foodCarts => _foodCarts;

  CollectionReference userCollectionRef =
      FirebaseFirestore.instance.collection(Constants.collectionUsers);
  CollectionReference productCollectionRef =
      FirebaseFirestore.instance.collection(Constants.collectionProducts);

  Future initializeCart(String userId) async {
    QuerySnapshot foodSnapshot = await userCollectionRef
        .doc(userId)
        .collection(Constants.collectionFoodCart)
        .get();
    QuerySnapshot cartSnapshot = await userCollectionRef
        .doc(userId)
        .collection(Constants.collectionCart)
        .get();

    await getCart(userId);
    await getFoodCart(userId);

    double? subtotal = await Preferences().getDoubleData(Constants.subtotal);
    String? cartData =
        await Preferences().getStringData(Constants.prefsCartData);

    _cartListNo = foodSnapshot.docs.length + cartSnapshot.docs.length;
    _cart = cartData != null ? jsonDecode(cartData) : {};
    _cartSubtotal = subtotal ?? 0;
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
          .where(Constants.prodCategory, isEqualTo: 'food')
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
          }).then((value) async {
            await getFoodCart(userId);

            _cart[shopName] = 1;
            Preferences()
                .saveStringData(Constants.prefsCartData, jsonEncode(_cart));
            _cartListNo++;
            notifyListeners();
          });
        }
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
            Constants.productId: productId,
            Constants.amount: amount,
            Constants.shopName: shopName,
            Constants.createdAt:
                DateTime.now().millisecondsSinceEpoch.toString(),
            Constants.updatedAt:
                DateTime.now().millisecondsSinceEpoch.toString(),
          });

          await documentReference.update({
            Constants.uid: documentReference.id,
          }).then((value) async {
            await getCart(userId);

            _cart[productId] = 1;
            Preferences()
                .saveStringData(Constants.prefsCartData, jsonEncode(_cart));
            _cartListNo++;
            notifyListeners();
          });
        } else {
          return 'Product is out of stock ❗';
        }
      }

      _cartSubtotal += amount!;
      Preferences().saveDoubleData(Constants.subtotal, _cartSubtotal);
      notifyListeners();

      return 'Product added to cart successfully! ✅';
      // return true;
    } on FirebaseException catch (e) {
      return e.message;
    }
  }

  Future removeFromCart(
      String userId, String productId, String cartId, double amount) async {
    try {
      DocumentReference documentReference = userCollectionRef
          .doc(userId)
          .collection(Constants.collectionCart)
          .doc(cartId);

      await documentReference.delete().then((value) async {
        _cart.remove(productId);
        Preferences()
            .saveStringData(Constants.prefsCartData, jsonEncode(_cart));
        _cartListNo--;
        _cartSubtotal -= amount;
        Preferences().saveDoubleData(Constants.subtotal, _cartSubtotal);
        notifyListeners();

        await getCart(userId).then((value) {
          Constants(context).snackBar(
              'Product removed from cart successfully! ✅', Constants.tetiary);
        });
      });

      // return 'Product removed from cart successfully! ✅';
      return true;
    } on FirebaseException catch (e) {
      Constants(context).snackBar(e.message!, Colors.red);

      return false;
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
      }).then((value) async {
        _cartSubtotal -= amount;
        Preferences().saveDoubleData(Constants.subtotal, _cartSubtotal);
        notifyListeners();

        await getFoodCart(userId).then((value) {
          Constants(context).snackBar(
              'Product removed from cart successfully! ✅', Constants.tetiary);
        });
      });

      // return 'Product removed from cart successfully! ✅';
      return true;
    } on FirebaseException catch (e) {
      return e.message;
    }
  }

  Future increaseCartProduct(String? productId, String userId, String cartId,
      String category, String shopName, double amount) async {
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
        _cart.update(shopName, (value) => value++);
        Preferences()
            .saveStringData(Constants.prefsCartData, jsonEncode(_cart));
        _cartSubtotal += amount;
        Preferences().saveDoubleData(Constants.subtotal, _cartSubtotal);
        notifyListeners();

        Constants(context)
            .snackBar('Cart updated successfully! ✅', Constants.tetiary);
      });

      return true;
    } else {
      DocumentReference documentReference = userCollectionRef
          .doc(userId)
          .collection(Constants.collectionCart)
          .doc(cartId);

      DocumentSnapshot cartDocSnapshot = await documentReference.get();
      int quantity = cartDocSnapshot[Constants.quantity];

      await productCollectionRef.doc(productId).get().then((value) async {
        int stock = value[Constants.prodTotalStock];

        if (quantity + 1 > stock) {
          Constants(context)
              .snackBar('No more products in stock ❗', Colors.red);

          return false;
        } else {
          await documentReference.update({
            Constants.quantity: quantity + 1,
            Constants.updatedAt:
                DateTime.now().millisecondsSinceEpoch.toString(),
          }).then((_) {
            _cart.update(productId!, (value) => value++);
            Preferences()
                .saveStringData(Constants.prefsCartData, jsonEncode(_cart));
            _cartSubtotal += amount;
            Preferences().saveDoubleData(Constants.subtotal, _cartSubtotal);
            notifyListeners();

            Constants(context)
                .snackBar('Cart updated successfully! ✅', Constants.tetiary);
          });

          return true;
        }
      });
    }
  }

  Future decreaseCartProduct(String? productId, String userId, String cartId,
      String category, double amount) async {
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

      _cartSubtotal -= amount;
      Preferences().saveDoubleData(Constants.subtotal, _cartSubtotal);
      notifyListeners();

      return 'Your cart has been updated successfully! ✅';
    } else {
      DocumentReference documentReference = userCollectionRef
          .doc(userId)
          .collection(Constants.collectionCart)
          .doc(cartId);

      DocumentSnapshot cartDocSnapshot = await documentReference.get();
      int quantity = cartDocSnapshot[Constants.quantity];

      await productCollectionRef.doc(productId).get().then((value) async {
        int stock = value[Constants.prodTotalStock];

        if (quantity + 1 > stock) {
          Constants(context)
              .snackBar('No more products in stock ❗', Colors.red);

          return false;
        } else {
          await documentReference.update({
            Constants.quantity: quantity + 1,
            Constants.updatedAt:
                DateTime.now().millisecondsSinceEpoch.toString(),
          }).then((_) {
            _cart.update(productId!, (value) => value++);
            Preferences()
                .saveStringData(Constants.prefsCartData, jsonEncode(_cart));
            _cartSubtotal -= amount;
            Preferences().saveDoubleData(Constants.subtotal, _cartSubtotal);
            notifyListeners();

            Constants(context).snackBar(
                'Your cart has been updated successfully! ✅',
                Constants.tetiary);
          });

          return true;
        }
      });
    }
  }

  Future getCart(String userId) async {
    try {
      QuerySnapshot querySnapshot = await userCollectionRef
          .doc(userId)
          .collection(Constants.collectionCart)
          .get();

      _carts = querySnapshot.docs;
      notifyListeners();
    } on FirebaseException catch (e) {
      _carts = [];
      notifyListeners();

      Constants(context).snackBar(e.message!, Colors.red);
    }
  }

  Future getFoodCart(String userId) async {
    try {
      QuerySnapshot querySnapshot = await userCollectionRef
          .doc(userId)
          .collection(Constants.collectionFoodCart)
          .get();

      _foodCarts = querySnapshot.docs;
      notifyListeners();
    } on FirebaseException catch (e) {
      _foodCarts = [];
      notifyListeners();
      
      Constants(context).snackBar(e.message!, Colors.red);
    }
  }

  Future updateFoodCartItemAmount(String userId, double firstAmount,
      double amount, String cartId, String productId) async {
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
        _cartSubtotal -= firstAmount;
        _cartSubtotal += amount;
        Preferences().saveDoubleData(Constants.subtotal, _cartSubtotal);
        notifyListeners();

        Constants(context).snackBar(
            'Food amount has been changed successfully! ✅', Constants.tetiary);

        return true;
      });
    } on FirebaseException catch (e) {
      return e.message;
    }
  }
}
