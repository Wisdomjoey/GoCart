// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:GOCart/PROVIDERS/product_provider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import 'package:GOCart/CONSTANTS/constants.dart';
import 'package:provider/provider.dart';

class CartProvider extends ChangeNotifier {
  final BuildContext context;

  CartProvider(this.context);

  int _cartListNo = 0;
  int get cartListNo => _cartListNo;

  Map<String, dynamic> _cart = {};
  Map<String, dynamic> get cart => _cart;

  double _cartSubtotal = 0;
  double get cartSubtotal => _cartSubtotal;

  List<Map<String, dynamic>> _prodData = [];
  List<Map<String, dynamic>> get prodData => _prodData;

  List _fProdData = [];
  List get fProdData => _fProdData;

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

    if (_cartListNo == 0) {
      _cartListNo = foodSnapshot.docs.length + cartSnapshot.docs.length;
    }

    if (_cart.isEmpty && _cartSubtotal == 0) {
      for (var element in cartSnapshot.docs) {
        _cart.addAll({
          element.get(Constants.productId): element.get(Constants.quantity)
        });

        _cartSubtotal +=
            element.get(Constants.amount) * element.get(Constants.quantity);
      }

      for (var element in foodSnapshot.docs) {
        _cart.addAll(
            {element.get(Constants.shopName): element.get(Constants.quantity)});

        for (var element1 in element.get(Constants.amount)) {
          _cartSubtotal += element1 * element.get(Constants.quantity);
        }
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

  Future addToCart(String userId, String productId, double amount,
      String shopName, String prodCat) async {
    try {
      if (prodCat == 'Cooked Foods') {
        CollectionReference collectionReference = userCollectionRef
            .doc(userId)
            .collection(Constants.collectionFoodCart);
        QuerySnapshot querySnapshot = await collectionReference
            .where(Constants.shopName, isEqualTo: shopName)
            .get();

        if (querySnapshot.docs.isNotEmpty) {
          DocumentReference documentReference =
              collectionReference.doc(querySnapshot.docs[0][Constants.uid]);
          await documentReference.get().then((value) {
            List prodsId = value.get(Constants.productId);
            List amounts = value.get(Constants.amount);

            if (prodsId.contains(productId)) {
              Constants(context)
                  .snackBar('Product already in cart!', Colors.red);
            } else {
              documentReference.update({
                Constants.productId: FieldValue.arrayUnion([productId]),
                Constants.amount: [...amounts, amount],
                Constants.updatedAt:
                    DateTime.now().millisecondsSinceEpoch.toString(),
              }).then((value) async {
                await getFoodCart(userId).then((value) {
                  _cartSubtotal += amount;
                  notifyListeners();

                  Constants(context).snackBar(
                      'Product added to cart successfully! ✅',
                      Constants.tetiary);
                });
              });
            }
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
            });
          });
        }
      } else {
        await productCollectionRef.doc(productId).get().then((value) async {
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

  Future removeFromCart(String userId, String productId, double amount, bool showMsg) async {
    try {
      if (carts.isNotEmpty) {
        String cartId = ((_carts
            .where((element) => element[Constants.productId] == productId)
            .elementAt(0)) as Map<String, dynamic>)[Constants.uid];

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
            if (showMsg) {
              Constants(context).snackBar(
                  'Product removed from cart successfully! ✅',
                  Constants.tetiary);
            }
          });
        });

        // return 'Product removed from cart successfully! ✅';
        return true;
      }
    } on FirebaseException catch (e) {
      Constants(context).snackBar(e.message!, Colors.red);

      return false;
    }
  }

  Future removeFromFoodCart(String userId, String? productId, double amount,
      String shopName, bool anchor, int? amountInd, bool getCart, bool showMsg) async {
    try {
      if (foodCarts.isNotEmpty) {
        String cartId = ((_foodCarts
            .where((element) => element[Constants.shopName] == shopName)
            .elementAt(0)) as Map<String, dynamic>)[Constants.uid];

        DocumentReference documentReference = userCollectionRef
            .doc(userId)
            .collection(Constants.collectionFoodCart)
            .doc(cartId);

        if (anchor) {
          await documentReference.delete().then((value) async {
            _cartSubtotal -= amount;
            _cartListNo--;
            notifyListeners();

            if (getCart) {
              await getFoodCart(userId).then((value) {
                if (showMsg) {
                  Constants(context).snackBar(
                      'Product removed from cart successfully! ✅',
                      Constants.tetiary);
                }
              });
            } else {
              if (showMsg) {
                Constants(context).snackBar(
                    'Product removed from cart successfully! ✅',
                    Constants.tetiary);
              }
            }
          });
        } else {
          DocumentSnapshot documentSnapshot = await documentReference.get();
          List amounts = documentSnapshot.get(Constants.amount);
          amounts.removeAt(amountInd!);

          await documentReference.update({
            Constants.productId: FieldValue.arrayRemove([productId]),
            Constants.amount: amounts,
            Constants.updatedAt:
                DateTime.now().millisecondsSinceEpoch.toString(),
          }).then((value) async {
            _cartSubtotal -= amount;
            notifyListeners();

            if (showMsg) {
              Constants(context).snackBar(
                  'Food Item removed from cart successfully! ✅',
                  Constants.tetiary);
            }
          });
        }

        // return 'Product removed from cart successfully! ✅';
        return true;
      }
    } on FirebaseException catch (e) {
      return e.message;
    }
  }

  Future increaseCartProduct(String? productId, String userId, String category,
      String shopName, double amount) async {
    if (category == 'Cooked Foods') {
      String cartId = ((_foodCarts
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
            _cart[productId!] += 1;
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

  Future decreaseCartProduct(String? productId, String userId, String category,
      double amount, String shopName) async {
    if (category == 'Cooked Foods') {
      String cartId = ((_foodCarts
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
        if (quantity - 1 < 1) {
          await removeFromCart(userId, productId!, amount, true);
        } else {
          await documentReference.update({
            Constants.quantity: quantity - 1,
            Constants.updatedAt:
                DateTime.now().millisecondsSinceEpoch.toString(),
          }).then((_) async {
            _cart[productId!] -= 1;
            _cartSubtotal -= amount;
            notifyListeners();

            Constants(context).snackBar(
                'Your cart has been updated successfully! ✅',
                Constants.tetiary);
          });
        }
      });

      return true;
    }
  }

  Future getCart(String userId) async {
    try {
      await userCollectionRef
          .doc(userId)
          .collection(Constants.collectionCart)
          .get()
          .then((value) async {
        List newCart = [];
        List<Map<String, dynamic>> data = [];

        for (var element in value.docs) {
          newCart.add(element.data());
        }

        for (var element in newCart) {
          var snapshot =
              await Provider.of<ProductProvider>(context, listen: false)
                  .getProductData(element[Constants.productId]);

          data.add(snapshot);
        }

        _prodData = data;
        _carts = newCart;
        notifyListeners();
      });
    } on FirebaseException catch (e) {
      _carts = [];
      notifyListeners();

      Constants(context).snackBar(e.message!, Colors.red);
    }
  }

  Future getFoodCart(String userId) async {
    try {
      await userCollectionRef
          .doc(userId)
          .collection(Constants.collectionFoodCart)
          .get()
          .then((value) async {
        List newCart = [];

        for (var element in value.docs) {
          newCart.add(element.data());
        }

        _fProdData = newCart;
        _foodCarts = newCart;
        notifyListeners();
      });
    } on FirebaseException catch (e) {
      _foodCarts = [];
      notifyListeners();

      Constants(context).snackBar(e.message!, Colors.red);
    }
  }

  Future updateFoodCartItemAmount(
      String userId, double firstAmount, double amount, String cartId) async {
    try {
      DocumentReference documentReference = userCollectionRef
          .doc(userId)
          .collection(Constants.collectionFoodCart)
          .doc(cartId);

      DocumentSnapshot documentSnapshot = await documentReference.get();

      List data = documentSnapshot[Constants.amount];

      int index = data.indexOf(firstAmount);

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
