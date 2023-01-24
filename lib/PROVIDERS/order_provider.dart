import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import '../CONSTANTS/constants.dart';

enum OrderStats { processing, complete, error, init }

class OrderProvider extends ChangeNotifier {
  final BuildContext context;

  OrderStats _order = OrderStats.init;

  OrderProvider(this.context);

  OrderStats get orderStats => _order;

  CollectionReference orderCollectionRef =
      FirebaseFirestore.instance.collection(Constants.collectionOrders);

  Future createOrder(
      String userId,
      int quantity,
      String productId,
      String productName,
      String deliveryDate,
      String imgUrl,
      double amount,
      String shopName) async {
    try {
      _order = OrderStats.processing;
      notifyListeners();
      DocumentReference documentReference = await orderCollectionRef.add({
        Constants.uid: '',
        Constants.orderId:
            "#${DateTime.now().millisecondsSinceEpoch.toString()}",
        Constants.quantity: quantity,
        Constants.userId: userId,
        Constants.orderdeliveryDate: deliveryDate,
        Constants.productId: [productId],
        Constants.amount: [amount],
        Constants.name: productName,
        Constants.imgUrl: imgUrl,
        Constants.orderStatus: Constants.newOrder,
        Constants.shopName: shopName,
        Constants.createdAt: DateTime.now().millisecondsSinceEpoch.toString(),
        Constants.updatedAt: DateTime.now().millisecondsSinceEpoch.toString(),
      });

      await documentReference.update({Constants.uid: documentReference.id});
      _order = OrderStats.complete;
      notifyListeners();

      return 'Order placed successfully! ✅';
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

  Future fetchUserOrders(String userId, String status) async {
    try {
      _order = OrderStats.processing;
      notifyListeners();

      if (status == 'Cancelled') {
        QuerySnapshot querySnapshot = await orderCollectionRef
            .where(Constants.userId, isEqualTo: userId)
            .where(Constants.orderStatus, isEqualTo: status)
            .get();

        _order = OrderStats.complete;
        notifyListeners();

        return querySnapshot.docs;
      } else {
        QuerySnapshot querySnapshot = await orderCollectionRef
            .where(Constants.userId, isEqualTo: userId)
            .where(Constants.orderStatus, isNotEqualTo: 'Cancelled')
            .get();

        _order = OrderStats.complete;
        notifyListeners();

        return querySnapshot.docs;
      }
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
