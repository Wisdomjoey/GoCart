// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import 'package:GOCart/CONSTANTS/constants.dart';

class CartProvider extends ChangeNotifier {
  final BuildContext context;

  CartProvider(this.context);

  int _cartListNo = 0;
  int get cartListNo => _cartListNo;

  Map<String, dynamic> _cart = {};
  Map<String, dynamic> get cart => _cart;

  double _cartSubtotal = 0;
  double get cartSubtotal => _cartSubtotal;

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

    _cartListNo = foodSnapshot.docs.length + cartSnapshot.docs.length;

    print(cartSnapshot.docs);

    for (var element in cartSnapshot.docs) {
      _cart.addAll(
          {element.get(Constants.productId): element.get(Constants.quantity)});

      _cartSubtotal += element.get(Constants.amount);
      print('object');
    }

    for (var element in foodSnapshot.docs) {
      _cart.addAll(
          {element.get(Constants.shopName): element.get(Constants.quantity)});

      for (var element1 in element.get(Constants.amount)) {
        _cartSubtotal += element1;
      }
    }

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
      String userId, String productId, double amount, String shopName) async {
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
            await getFoodCart(userId).then((value) {
              _cart[shopName] = 1;
              _cartListNo++;
              _cartSubtotal += amount;
              notifyListeners();

              Constants(context).snackBar(
                  'Product added to cart successfully! ✅', Constants.tetiary);

              return true;
            });
          });
        }
      } else {
        productCollectionRef.doc(productId).get().then((value) async {
          if (value.get(Constants.prodTotalStock) > 0) {
            CollectionReference collectionReference = userCollectionRef
                .doc(userId)
                .collection(Constants.collectionCart);

            DocumentReference documentReference =
                await collectionReference.add({
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
              await getCart(userId).then((value) {
                _cart[productId] = 1;
                _cartListNo++;
                _cartSubtotal += amount;
                notifyListeners();

                Constants(context).snackBar(
                    'Product added to cart successfully! ✅', Constants.tetiary);
              });
            });

            return true;
          } else {
            Constants(context)
                .snackBar('Product is out of stock ❌', Colors.red);

            return false;
          }
        });
      }
      // return true;
    } on FirebaseException catch (e) {
      Constants(context).snackBar(e.message!, Colors.red);

      return false;
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
        _cartListNo--;
        _cartSubtotal -= amount;
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

  Future increaseCartProduct(String productId, String userId, String category,
      String shopName, double amount) async {
    if (category == 'Cooked Foods') {
      String cartId = ((_carts
          .where((element) => element[Constants.shopName] == shopName)
          .elementAt(0)) as Map<String, dynamic>)[Constants.uid];

      DocumentReference documentReference = userCollectionRef
          .doc(userId)
          .collection(Constants.collectionFoodCart)
          .doc(cartId);

      DocumentSnapshot cartDocSnapshot = await documentReference.get();
      int quantity = cartDocSnapshot[Constants.quantity];

      await documentReference.update({
        Constants.quantity: quantity + 1,
        Constants.updatedAt: DateTime.now().millisecondsSinceEpoch.toString(),
      }).then((_) async {
        _cart[shopName] += 1;
        _cartSubtotal += amount;
        notifyListeners();

        Constants(context)
            .snackBar('Cart updated successfully! ✅', Constants.tetiary);
      });

      return true;
    } else {
      String cartId = ((_carts
          .where((element) => element[Constants.productId] == productId)
          .elementAt(0)) as Map<String, dynamic>)[Constants.uid];

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
          }).then((_) async {
            _cart[productId] += 1;
            _cartSubtotal += amount;
            notifyListeners();

            Constants(context)
                .snackBar('Cart updated successfully! ✅', Constants.tetiary);
          });

          return true;
        }
      });
    }
  }

  Future decreaseCartProduct(String productId, String userId, String category,
      double amount, String shopName) async {
    if (category == 'Cooked Foods') {
      String cartId = ((_carts
          .where((element) => element[Constants.shopName] == shopName)
          .elementAt(0)) as Map<String, dynamic>)[Constants.uid];

      DocumentReference documentReference = userCollectionRef
          .doc(userId)
          .collection(Constants.collectionFoodCart)
          .doc(cartId);

      DocumentSnapshot cartDocSnapshot = await documentReference.get();
      int quantity = cartDocSnapshot[Constants.quantity];

      await documentReference.update({
        Constants.quantity: quantity - 1,
        Constants.updatedAt: DateTime.now().millisecondsSinceEpoch.toString(),
      }).then((_) async {
        _cart[shopName] -= 1;
        _cartSubtotal -= amount;
        notifyListeners();

        Constants(context).snackBar(
            'Your cart has been updated successfully! ✅', Constants.tetiary);
      });

      return true;
    } else {
      String cartId = ((_carts
          .where((element) => element[Constants.productId] == productId)
          .elementAt(0)) as Map<String, dynamic>)[Constants.uid];

      DocumentReference documentReference = userCollectionRef
          .doc(userId)
          .collection(Constants.collectionCart)
          .doc(cartId);

      DocumentSnapshot cartDocSnapshot = await documentReference.get();
      int quantity = cartDocSnapshot[Constants.quantity];

      await productCollectionRef.doc(productId).get().then((value) async {
        int stock = value[Constants.prodTotalStock];

        if (quantity - 1 < 1) {
          await removeFromCart(userId, productId, cartId, amount);
        } else {
          await documentReference.update({
            Constants.quantity: quantity - 1,
            Constants.updatedAt:
                DateTime.now().millisecondsSinceEpoch.toString(),
          }).then((_) async {
            _cart[productId] -= 1;
            _cartSubtotal -= amount;
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

      List newCart = [];

      for (var element in querySnapshot.docs) {
        newCart.add(element.data());
      }

      _carts = newCart;
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

      List newCart = [];

      for (var element in querySnapshot.docs) {
        newCart.add(element.data());
      }

      _foodCarts = newCart;
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
