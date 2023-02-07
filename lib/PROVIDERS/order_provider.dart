import 'package:GOCart/PROVIDERS/cart_provider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../CONSTANTS/constants.dart';

class OrderProvider extends ChangeNotifier {
  final BuildContext context;

  CollectionReference orderCollectionRef =
      FirebaseFirestore.instance.collection(Constants.collectionOrders);

  OrderProvider(this.context);

  Future createOrder(String userId, List amount, List<int> quantity,
      List<Map<String, dynamic>> prodData) async {
    try {
      for (var i = 0; i < prodData.length; i++) {
        DocumentReference documentReference = await orderCollectionRef.add({
          Constants.uid: '',
          Constants.orderId:
              "#${DateTime.now().millisecondsSinceEpoch.toString()}",
          Constants.quantity: quantity[i],
          Constants.userId: userId,
          Constants.orderdeliveryDate: '',
          Constants.productId: [prodData[i][Constants.uid]],
          Constants.amount:
              prodData[i][Constants.prodCategory] == 'Cooked Foods'
                  ? amount[i]
                  : [amount[i]],
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
            await Provider.of<CartProvider>(context, listen: false)
                .removeFromFoodCart(
                    userId,
                    prodData[i][Constants.uid],
                    amount[i].reduce((value, element) => value + element),
                    prodData[i][Constants.shopName],
                    true,
                    null,
                    true)
                .then((value) {
              Constants(context).snackBar(
                  'Product added to cart successfully! ✅', Constants.tetiary);
            });
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

      return true;
    } on FirebaseException catch (e) {
      return e.message;
    }
  }

  Future updateOrderStatus(String status, String orderUid) async {
    DocumentReference documentReference = orderCollectionRef.doc(orderUid);

    await documentReference.update({
      Constants.orderStatus: status,
      Constants.updatedAt: DateTime.now().millisecondsSinceEpoch.toString(),
    }).then((_) {
      Constants(context)
          .snackBar('Order status updated! ✅', Constants.tetiary);
    }).catchError((err) {
      Constants(context)
          .snackBar(err.toString(), Colors.red);
    });
  }

  Future fetchUserOrders(String userId) async {
    try {
      QuerySnapshot querySnapshot = await orderCollectionRef
          .where(Constants.userId, isEqualTo: userId)
          .get();

      return querySnapshot.docs;
    } on FirebaseException catch (e) {
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
