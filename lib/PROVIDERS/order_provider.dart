import 'package:GOCart/PROVIDERS/cart_provider.dart';
import 'package:GOCart/PROVIDERS/shop_provider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../CONSTANTS/constants.dart';

class OrderProvider extends ChangeNotifier {
  final BuildContext context;

  CollectionReference orderCollectionRef =
      FirebaseFirestore.instance.collection(Constants.collectionOrders);

  OrderProvider(this.context);

  Future createOrder(String userId, List? amount1, List<int>? quantity1,
      List? prodData1, List? prodData2, String? shopUrl, String phone) async {
    try {
      if (prodData1 != null) {
        for (var i = 0; i < prodData1.length; i++) {
          DocumentReference documentReference = await orderCollectionRef.add({
            Constants.uid: '',
            Constants.orderId:
                "#${DateTime.now().millisecondsSinceEpoch.toString()}",
            Constants.quantity: quantity1![i],
            Constants.userId: userId,
            Constants.orderdeliveryDate: '',
            Constants.productId: prodData1[i][Constants.uid],
            Constants.amount: amount1![i],
            Constants.userPhone: phone,
            Constants.name: prodData1[i][Constants.name],
            "isCooked": false,
            Constants.imgUrl: prodData1[i][Constants.imgUrls][0],
            Constants.orderStatus: Constants.newOrder,
            Constants.shopName: prodData1[i][Constants.shopName],
            Constants.createdAt:
                DateTime.now().millisecondsSinceEpoch.toString(),
            Constants.updatedAt:
                DateTime.now().millisecondsSinceEpoch.toString(),
          });

          await documentReference.update(
              {Constants.uid: documentReference.id}).then((value) async {
            await Provider.of<CartProvider>(context, listen: false)
                .removeFromCart(userId, prodData1[i][Constants.uid], amount1[i], false)
                .then((value) {
              if (prodData2 == null) {
                if (i == prodData1.length - 1) {
                  Constants(context).snackBar(
                      'Order placed successfully! ✅', Constants.tetiary);
                }
              }
            });
          });
        }
      }

      if (prodData2 != null) {
        for (var i = 0; i < prodData2.length; i++) {
          double amt = prodData2[i][Constants.amount]
                  .reduce((value, element) => value + element) *
              prodData2[i][Constants.quantity];

          DocumentReference documentReference = await orderCollectionRef.add({
            Constants.uid: '',
            Constants.orderId:
                "#${DateTime.now().millisecondsSinceEpoch.toString()}",
            Constants.quantity: prodData2[i][Constants.quantity],
            Constants.userId: userId,
            Constants.orderdeliveryDate: '',
            Constants.productId: prodData2[i][Constants.productId],
            Constants.amount: amt,
            Constants.userPhone: phone,
            Constants.name: '${prodData2[i][Constants.shopName]} - FOOD',
            "isCooked": true,
            Constants.imgUrl: shopUrl!,
            Constants.orderStatus: Constants.newOrder,
            Constants.shopName: prodData2[i][Constants.shopName],
            Constants.createdAt:
                DateTime.now().millisecondsSinceEpoch.toString(),
            Constants.updatedAt:
                DateTime.now().millisecondsSinceEpoch.toString(),
          });

          await documentReference.update(
              {Constants.uid: documentReference.id}).then((value) async {
            await Provider.of<CartProvider>(context, listen: false)
                .removeFromFoodCart(userId, null, amt,
                    prodData2[i][Constants.shopName], true, null, true, false)
                .then((value) {
              if (i == prodData2.length - 1) {
                Constants(context).snackBar(
                    'Order placed successfully! ✅', Constants.tetiary);
              }
            });
          });
        }
      }

      return true;
    } on FirebaseException catch (e) {
      return e.message;
    }
  }

  Future updateOrderStatus(
      String status, String orderUid, String? shopId, double? amount) async {
    try {
      DocumentReference documentReference = orderCollectionRef.doc(orderUid);

      await documentReference.update({
        Constants.orderStatus: status,
        Constants.updatedAt: DateTime.now().millisecondsSinceEpoch.toString(),
      }).then((_) async {
        if (status == Constants.delivered) {
          await Provider.of<ShopProvider>(context, listen: false)
              .updateShopSales(shopId!, amount!)
              .then((value) {
            Constants(context)
                .snackBar('Order status updated! ✅', Constants.tetiary);
          });
        } else {
          Constants(context)
              .snackBar('Order status updated! ✅', Constants.tetiary);
        }
      });
    } on FirebaseException catch (e) {
      Constants(context).snackBar(e.message!, Colors.red);
    }
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
