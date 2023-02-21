// import 'package:cached_network_image/cached_network_image.dart';
// import 'package:flutter/material.dart';
// import 'package:provider/provider.dart';

// import '../../CONSTANTS/constants.dart';
// import '../../PROVIDERS/global_provider.dart';
// import '../../PROVIDERS/order_provider.dart';
// import '../utils/dimensions.dart';
// import '../widgets/box_chip_widget.dart';
// import '../widgets/elevated_button_widget.dart';

// class OrderStats extends StatefulWidget {
//   final String orderId;
//   final String imgUrl;
//   final String name;
//   final String orderUid;
//   final double price;

//   const OrderStats(
//       {super.key,
//       required this.orderId,
//       required this.imgUrl,
//       required this.name,
//       required this.orderUid,
//       required this.price});

//   @override
//   State<OrderStats> createState() => _OrderStatsState();
// }

// class _OrderStatsState extends State<OrderStats> {
//   @override
//   Widget build(BuildContext context) {
//     String currency = Constants(context).currency().currencySymbol;
//     String val = 'Delivered';

//     return Dialog(
//       insetPadding:
//           EdgeInsets.symmetric(horizontal: Dimensions.sizedBoxWidth10),
//       child: Container(
//         padding: EdgeInsets.all(Dimensions.sizedBoxWidth15),
//         width: double.maxFinite,
//         child: Column(
//           mainAxisSize: MainAxisSize.min,
//           children: [
//             Row(
//               mainAxisAlignment: MainAxisAlignment.spaceBetween,
//               children: [
//                 RichText(
//                   text: TextSpan(
//                       text: 'Order Id: ',
//                       style: TextStyle(
//                           color: Colors.black,
//                           fontWeight: FontWeight.w500,
//                           fontSize: Dimensions.font16),
//                       children: [
//                         TextSpan(
//                           text: widget.orderId,
//                           style: const TextStyle(color: Colors.grey),
//                         ),
//                       ]),
//                 ),
//                 GestureDetector(
//                   child: const Icon(Icons.close),
//                   onTap: () {
//                     Navigator.pop(context);
//                   },
//                 )
//               ],
//             ),
//             SizedBox(
//               height: Dimensions.sizedBoxHeight10,
//             ),
//             Row(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: [
//                 Container(
//                   width: Dimensions.sizedBoxWidth100,
//                   height: Dimensions.sizedBoxWidth100,
//                   decoration: BoxDecoration(
//                       image: DecorationImage(
//                           image: CachedNetworkImageProvider(widget.imgUrl),
//                           fit: BoxFit.contain)),
//                 ),
//                 SizedBox(
//                   width: Dimensions.sizedBoxWidth10,
//                 ),
//                 Expanded(
//                   child: Text(widget.name,
//                       style: TextStyle(
//                         fontSize: Dimensions.font12,
//                       )),
//                 )
//               ],
//             ),
//             SizedBox(
//               height: Dimensions.sizedBoxHeight10,
//             ),
//             Row(
//               mainAxisAlignment: MainAxisAlignment.spaceBetween,
//               children: [
//                 RichText(
//                   text: TextSpan(
//                       text: 'Price: ',
//                       style: TextStyle(
//                           color: Colors.black,
//                           fontWeight: FontWeight.w500,
//                           fontSize: Dimensions.font14),
//                       children: [
//                         TextSpan(
//                           text:
//                               '$currency${Constants.format.format(widget.price)}',
//                           style: const TextStyle(color: Colors.grey),
//                         ),
//                       ]),
//                 ),
//                 Row(
//                   children: [
//                     Text(
//                       'Status:',
//                       style: TextStyle(
//                           fontWeight: FontWeight.w500,
//                           fontSize: Dimensions.font16),
//                     ),
//                     SizedBox(
//                       width: Dimensions.sizedBoxWidth10 / 2,
//                     ),
//                     const BoxChip(
//                       text: 'PROCESSING',
//                       color: Constants.tetiary,
//                     )
//                   ],
//                 )
//               ],
//             ),
//             SizedBox(
//               height: Dimensions.sizedBoxHeight15,
//             ),
//             Row(
//               mainAxisAlignment: MainAxisAlignment.spaceBetween,
//               children: [
//                 DropdownButton(
//                   items: const [
//                     DropdownMenuItem(
//                         value: 'Delivered', child: Text('Delivered')),
//                     DropdownMenuItem(
//                         value: 'Cancelled', child: Text('Cancelled')),
//                   ],
//                   value: val,
//                   onChanged: (dynamic value) {
//                     setState(() {
//                       val = value;
//                     });
//                   },
//                 ),
//                 Container(
//                   padding: EdgeInsets.symmetric(
//                       vertical: Dimensions.sizedBoxHeight4),
//                   width: Dimensions.sizedBoxWidth100,
//                   child: ElevatedBtn(
//                     pressed: () async {
//                       Provider.of<GlobalProvider>(context, listen: false)
//                           .setProcess(Processes.waiting);

//                       await Provider.of<OrderProvider>(context, listen: false)
//                           .updateOrderStatus(
//                               Constants.delivered, widget.orderUid)
//                           .whenComplete(() {
//                         Provider.of<GlobalProvider>(context, listen: false)
//                             .setProcess(Processes.done);
//                         Navigator.pop(context);
//                       });
//                     },
//                     text: 'Update',
//                     disabled: Provider.of<GlobalProvider>(context).process ==
//                             Processes.waiting
//                         ? true
//                         : false,
//                     child: Provider.of<GlobalProvider>(context).process ==
//                             Processes.waiting
//                         ? SizedBox(
//                             width: Dimensions.sizedBoxWidth10 * 1.5,
//                             height: Dimensions.sizedBoxWidth10 * 1.5,
//                             child: const CircularProgressIndicator(
//                               color: Constants.white,
//                               strokeWidth: 3,
//                             ))
//                         : Text(
//                             'Update',
//                             style: TextStyle(
//                                 color: Constants.white,
//                                 fontSize: Dimensions.font14),
//                           ),
//                   ),
//                 )
//               ],
//             ),
//             SizedBox(
//               height: Dimensions.sizedBoxHeight10,
//             ),
//             const Text(
//                 'Have you recieved this order? If so please update order status'),
//           ],
//         ),
//       ),
//     );
//   }
// }
