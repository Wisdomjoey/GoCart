import 'package:GOCart/PROVIDERS/cart_provider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../CONSTANTS/constants.dart';

enum OrderStats { processing, complete, error, init }

class OrderProvider extends ChangeNotifier {
  OrderStats _order = OrderStats.init;

  OrderStats get orderStats => _order;

  CollectionReference orderCollectionRef =
      FirebaseFirestore.instance.collection(Constants.collectionOrders);

  Future createOrder(String userId, List amount, List<int> quantity,
      List<Map<String, dynamic>> prodData, BuildContext context) async {
    try {
      _order = OrderStats.processing;
      notifyListeners();

      for (var i = 0; i < prodData.length; i++) {
        DocumentReference documentReference = await orderCollectionRef.add({
          Constants.uid: '',
          Constants.orderId:
              "#${DateTime.now().millisecondsSinceEpoch.toString()}",
          Constants.quantity: quantity[i],
          Constants.userId: userId,
          Constants.orderdeliveryDate: '',
          Constants.productId: [prodData[i][Constants.uid]],
          Constants.amount: [amount[i]],
          Constants.name: prodData[i][Constants.name],
          Constants.imgUrl: prodData[i][Constants.imgUrls][0],
          Constants.orderStatus: Constants.newOrder,
          Constants.shopName: prodData[i][Constants.shopName],
          Constants.createdAt: DateTime.now().millisecondsSinceEpoch.toString(),
          Constants.updatedAt: DateTime.now().millisecondsSinceEpoch.toString(),
        });

        await documentReference
            .update({Constants.uid: documentReference.id}).then((value) async {
          if (prodData[i][Constants.prodCategory] == 'Cooked Foods') {
            for (var element in amount[i]) {
              await Provider.of<CartProvider>(context, listen: false)
                  .removeFromFoodCart(userId, prodData[i][Constants.uid],
                      element, prodData[i][Constants.shopName])
                  .then((value) {
                Constants(context).snackBar(
                    'Product added to cart successfully! ✅', Constants.tetiary);
              });
            }
          } else {
            await Provider.of<CartProvider>(context, listen: false)
                .removeFromCart(userId, prodData[i][Constants.uid], amount[i])
                .then((value) {
              Constants(context).snackBar(
                  'Product added to cart successfully! ✅', Constants.tetiary);
            });
          }
        });
      }

      _order = OrderStats.complete;
      notifyListeners();

      return true;
    } on FirebaseException catch (e) {
      _order = OrderStats.error;
      notifyListeners();

      return e.message;
    }
  }

  Future updateOrderStatus(String status, String orderUid) async {
    _order = OrderStats.processing;
    notifyListeners();
    DocumentReference documentReference = orderCollectionRef.doc(orderUid);

    await documentReference.update({
      Constants.orderStatus: status,
      Constants.updatedAt: DateTime.now().millisecondsSinceEpoch.toString(),
    }).then((_) {
      _order = OrderStats.complete;
      notifyListeners();

      return 'Order status updated! ✅';
    }).catchError((err) {
      _order = OrderStats.error;
      notifyListeners();

      return err;
    });
  }

  Future fetchUserOrders(
      String userId, BuildContext context) async {
    try {
      _order = OrderStats.processing;
      // notifyListeners();

      QuerySnapshot querySnapshot = await orderCollectionRef
          .where(Constants.userId, isEqualTo: userId)
          .get();

      _order = OrderStats.complete;
      notifyListeners();

      return querySnapshot.docs;
    } on FirebaseException catch (e) {
      _order = OrderStats.error;
      notifyListeners();

      Constants(context).snackBar(e.message!, Constants.tetiary);

      return [];
    }
  }

  Stream<QuerySnapshot> fetchSellerOrders(String shopName, String status) {
    return orderCollectionRef
        .where(Constants.shopName, isEqualTo: shopName)
        .where(Constants.orderStatus, isEqualTo: status)
        .snapshots();
  }
}
