import 'package:GOCart/PROVIDERS/order_provider.dart';
import 'package:GOCart/UI/widgets/elevated_button_widget.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../CONSTANTS/constants.dart';
import '../../utils/dimensions.dart';
import '../../widgets/box_chip_widget.dart';

class CheckOrdersPage extends StatefulWidget {
  final String shopName;

  const CheckOrdersPage({super.key, required this.shopName});

  @override
  State<CheckOrdersPage> createState() => _CheckOrdersPageState();
}

class _CheckOrdersPageState extends State<CheckOrdersPage>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    _tabController = TabController(length: 4, vsync: this);

    super.initState();
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          width: double.maxFinite,
          color: Constants.white,
          height: Dimensions.sizedBoxHeight10 * 4,
          child: Material(
            child: TabBar(
              controller: _tabController,
              indicatorColor: Constants.tetiary,
              labelColor: Constants.tetiary,
              unselectedLabelColor: const Color.fromARGB(255, 125, 125, 125),
              onTap: (value) {},
              isScrollable: true,
              tabs: [
                SizedBox(
                  width: Dimensions.sizedBoxWidth100,
                  child: const Tab(text: 'NEW ORDERS'),
                ),
                SizedBox(
                  width: Dimensions.sizedBoxWidth100,
                  child: const Tab(text: 'PROCESSING ORDERS'),
                ),
                SizedBox(
                  width: Dimensions.sizedBoxWidth100,
                  child: const Tab(
                    text: 'CLOSED ORDERS',
                  ),
                ),
                SizedBox(
                  width: Dimensions.sizedBoxWidth100,
                  child: const Tab(
                    text: 'CANCELLED ORDERS',
                  ),
                ),
              ],
            ),
          ),
        ),
        SizedBox(
          height: Dimensions.sizedBoxHeight10,
        ),
        Expanded(
          child: TabBarView(controller: _tabController, children: [
            StreamBuilder(
              stream: Provider.of<OrderProvider>(context, listen: false)
                  .fetchSellerOrders(widget.shopName, Constants.newOrder),
              builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
                List data = [];

                if (snapshot.hasData) {
                  for (var element in snapshot.data!.docs) {
                    data.add(element.data());
                  }
                }

                if (snapshot.hasError) {
                  Constants(context).snackBar(
                      'Something went wrong while loading this data',
                      Colors.red);

                  return const Center(
                    child: Text('No new orders'),
                  );
                }

                return snapshot.connectionState == ConnectionState.waiting
                    ? const Center(
                        child: CircularProgressIndicator(
                          color: Constants.tetiary,
                        ),
                      )
                    : (data.isEmpty
                        ? const Center(
                            child: Text('No new orders'),
                          )
                        : ListView.builder(
                            itemCount: data.length,
                            itemBuilder: (context, index) {
                              return Container(
                                padding: EdgeInsets.only(
                                    left: Dimensions.sizedBoxWidth10,
                                    right: Dimensions.sizedBoxWidth10,
                                    bottom: Dimensions.sizedBoxHeight10),
                                child: Material(
                                  borderRadius: BorderRadius.circular(
                                      Dimensions.sizedBoxWidth4),
                                  animationDuration:
                                      const Duration(milliseconds: 100),
                                  child: InkWell(
                                    child: Ink(
                                      height: Dimensions.sizedBoxHeight10 * 11,
                                      padding: EdgeInsets.all(
                                          Dimensions.sizedBoxWidth10),
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(
                                            Dimensions.sizedBoxWidth4),
                                        color: Constants.white,
                                      ),
                                      child: Row(
                                        children: [
                                          Ink(
                                            width: Dimensions.sizedBoxWidth100,
                                            decoration: BoxDecoration(
                                                image: DecorationImage(
                                                    image:
                                                        CachedNetworkImageProvider(
                                                            data[index][
                                                                Constants
                                                                    .imgUrl]),
                                                    fit: BoxFit.contain)),
                                          ),
                                          Expanded(
                                            child: Ink(
                                              child: Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceBetween,
                                                children: [
                                                  Column(
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .start,
                                                    children: [
                                                      Text(
                                                          data[index]
                                                              [Constants.name],
                                                          overflow: TextOverflow
                                                              .ellipsis,
                                                          style: TextStyle(
                                                            fontSize: Dimensions
                                                                .font12,
                                                          )),
                                                      SizedBox(
                                                        height: Dimensions
                                                            .sizedBoxHeight3,
                                                      ),
                                                      Text(
                                                          'Order ${data[index][Constants.orderId]}',
                                                          style: TextStyle(
                                                            fontSize: Dimensions
                                                                .font12,
                                                          ))
                                                    ],
                                                  ),
                                                  Column(
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .start,
                                                    children: [
                                                      const BoxChip(
                                                        text: 'NEW ORDER',
                                                        color:
                                                            Constants.tetiary,
                                                      ),
                                                      SizedBox(
                                                        height: Dimensions
                                                            .sizedBoxHeight3,
                                                      ),
                                                      Text('On 30-06',
                                                          style: TextStyle(
                                                              fontSize:
                                                                  Dimensions
                                                                      .font12,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w500))
                                                    ],
                                                  ),
                                                ],
                                              ),
                                            ),
                                          )
                                        ],
                                      ),
                                    ),
                                    onTap: () {
                                      showDialog(
                                          context: context,
                                          builder: (context) => _showDialog(
                                              context,
                                              data[index][Constants.orderId],
                                              data[index][Constants.imgUrl],
                                              data[index][Constants.name],
                                              'NEW ORDER',
                                              data[index][Constants.amount][0],
                                              Constants.tetiary));
                                    },
                                  ),
                                ),
                              );
                            },
                          ));
              },
            ),
            StreamBuilder(
              stream: Provider.of<OrderProvider>(context, listen: false)
                  .fetchSellerOrders(widget.shopName, Constants.processing),
              builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
                List data = [];

                if (snapshot.hasData) {
                  for (var element in snapshot.data!.docs) {
                    data.add(element.data());
                  }
                }

                if (snapshot.hasError) {
                  Constants(context).snackBar(
                      'Something went wrong while loading this data',
                      Colors.red);

                  return const Center(
                    child: Text('No processing orders'),
                  );
                }

                return snapshot.connectionState == ConnectionState.waiting
                    ? const Center(
                        child: CircularProgressIndicator(
                          color: Constants.tetiary,
                        ),
                      )
                    : (data.isEmpty
                        ? const Center(
                            child: Text('No processing orders'),
                          )
                        : ListView.builder(
                            itemCount: data.length,
                            itemBuilder: (context, index) {
                              return Container(
                                padding: EdgeInsets.only(
                                    left: Dimensions.sizedBoxWidth10,
                                    right: Dimensions.sizedBoxWidth10,
                                    bottom: Dimensions.sizedBoxHeight10),
                                child: Material(
                                  borderRadius: BorderRadius.circular(
                                      Dimensions.sizedBoxWidth4),
                                  animationDuration:
                                      const Duration(milliseconds: 100),
                                  child: InkWell(
                                    child: IgnorePointer(
                                      child: Ink(
                                        height:
                                            Dimensions.sizedBoxHeight10 * 11,
                                        padding: EdgeInsets.all(
                                            Dimensions.sizedBoxWidth10),
                                        decoration: BoxDecoration(
                                          borderRadius: BorderRadius.circular(
                                              Dimensions.sizedBoxWidth4),
                                          color: Constants.white,
                                        ),
                                        child: Row(
                                          children: [
                                            Ink(
                                              width:
                                                  Dimensions.sizedBoxWidth100,
                                              decoration: BoxDecoration(
                                                  image: DecorationImage(
                                                      image:
                                                          CachedNetworkImageProvider(
                                                              data[index][
                                                                  Constants
                                                                      .imgUrl]),
                                                      fit: BoxFit.contain)),
                                            ),
                                            Expanded(
                                              child: Ink(
                                                child: Column(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  mainAxisAlignment:
                                                      MainAxisAlignment
                                                          .spaceBetween,
                                                  children: [
                                                    Column(
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .start,
                                                      children: [
                                                        Text(
                                                            data[index][
                                                                Constants.name],
                                                            overflow:
                                                                TextOverflow
                                                                    .ellipsis,
                                                            style: TextStyle(
                                                              fontSize:
                                                                  Dimensions
                                                                      .font12,
                                                            )),
                                                        SizedBox(
                                                          height: Dimensions
                                                              .sizedBoxHeight3,
                                                        ),
                                                        Text(
                                                            'Order ${data[index][Constants.orderId]}',
                                                            style: TextStyle(
                                                              fontSize:
                                                                  Dimensions
                                                                      .font12,
                                                            ))
                                                      ],
                                                    ),
                                                    Column(
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .start,
                                                      children: [
                                                        const BoxChip(
                                                          text: 'PROCESSING',
                                                          color:
                                                              Constants.tetiary,
                                                        ),
                                                        SizedBox(
                                                          height: Dimensions
                                                              .sizedBoxHeight3,
                                                        ),
                                                        Text('On 30-06',
                                                            style: TextStyle(
                                                                fontSize:
                                                                    Dimensions
                                                                        .font12,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w500))
                                                      ],
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            )
                                          ],
                                        ),
                                      ),
                                    ),
                                    onTap: () {
                                      showDialog(
                                          context: context,
                                          barrierDismissible: false,
                                          builder: (context) => _showDialog(
                                              context,
                                              data[index][Constants.orderId],
                                              data[index][Constants.imgUrl],
                                              data[index][Constants.name],
                                              'PROCESSING',
                                              data[index][Constants.amount][0],
                                              Constants.tetiary));
                                    },
                                  ),
                                ),
                              );
                            },
                          ));
              },
            ),
            StreamBuilder(
              stream: Provider.of<OrderProvider>(context, listen: false)
                  .fetchSellerOrders(widget.shopName, Constants.closed),
              builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
                List data = [];

                if (snapshot.hasData) {
                  for (var element in snapshot.data!.docs) {
                    data.add(element.data());
                  }
                }

                if (snapshot.hasError) {
                  Constants(context).snackBar(
                      'Something went wrong while loading this data',
                      Colors.red);

                  return const Center(
                    child: Text('No closed orders'),
                  );
                }

                return snapshot.connectionState == ConnectionState.waiting
                    ? const Center(
                        child: CircularProgressIndicator(
                          color: Constants.tetiary,
                        ),
                      )
                    : (data.isEmpty
                        ? const Center(
                            child: Text('No closed orders'),
                          )
                        : ListView.builder(
                            itemCount: data.length,
                            itemBuilder: (context, index) {
                              return Container(
                                padding: EdgeInsets.only(
                                    left: Dimensions.sizedBoxWidth10,
                                    right: Dimensions.sizedBoxWidth10,
                                    bottom: Dimensions.sizedBoxHeight10),
                                child: Material(
                                  borderRadius: BorderRadius.circular(
                                      Dimensions.sizedBoxWidth4),
                                  animationDuration:
                                      const Duration(milliseconds: 100),
                                  child: InkWell(
                                    child: IgnorePointer(
                                      child: Ink(
                                        height:
                                            Dimensions.sizedBoxHeight10 * 11,
                                        padding: EdgeInsets.all(
                                            Dimensions.sizedBoxWidth10),
                                        decoration: BoxDecoration(
                                          borderRadius: BorderRadius.circular(
                                              Dimensions.sizedBoxWidth4),
                                          color: Constants.white,
                                        ),
                                        child: Row(
                                          children: [
                                            Ink(
                                              width:
                                                  Dimensions.sizedBoxWidth100,
                                              decoration: BoxDecoration(
                                                  image: DecorationImage(
                                                      image:
                                                          CachedNetworkImageProvider(
                                                              data[index][
                                                                  Constants
                                                                      .imgUrl]),
                                                      fit: BoxFit.contain)),
                                            ),
                                            Expanded(
                                              child: Ink(
                                                child: Column(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  mainAxisAlignment:
                                                      MainAxisAlignment
                                                          .spaceBetween,
                                                  children: [
                                                    Column(
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .start,
                                                      children: [
                                                        Text(
                                                            data[index][
                                                                Constants.name],
                                                            overflow:
                                                                TextOverflow
                                                                    .ellipsis,
                                                            style: TextStyle(
                                                              fontSize:
                                                                  Dimensions
                                                                      .font12,
                                                            )),
                                                        SizedBox(
                                                          height: Dimensions
                                                              .sizedBoxHeight3,
                                                        ),
                                                        Text(
                                                            'Order ${data[index][Constants.orderId]}',
                                                            style: TextStyle(
                                                              fontSize:
                                                                  Dimensions
                                                                      .font12,
                                                            ))
                                                      ],
                                                    ),
                                                    Column(
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .start,
                                                      children: [
                                                        const BoxChip(
                                                          text: 'DELIVERED',
                                                          color:
                                                              Constants.primary,
                                                        ),
                                                        SizedBox(
                                                          height: Dimensions
                                                              .sizedBoxHeight3,
                                                        ),
                                                        Text('On 30-06',
                                                            style: TextStyle(
                                                                fontSize:
                                                                    Dimensions
                                                                        .font12,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w500))
                                                      ],
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            )
                                          ],
                                        ),
                                      ),
                                    ),
                                    onTap: () {
                                      showDialog(
                                          context: context,
                                          barrierDismissible: false,
                                          builder: (context) => _showDialog(
                                              context,
                                              data[index][Constants.orderId],
                                              data[index][Constants.imgUrl],
                                              data[index][Constants.name],
                                              'DELIVERED',
                                              data[index][Constants.amount][0],
                                              Constants.primary));
                                    },
                                  ),
                                ),
                              );
                            },
                          ));
              },
            ),
            StreamBuilder(
              stream: Provider.of<OrderProvider>(context, listen: false)
                  .fetchSellerOrders(widget.shopName, Constants.cancelled),
              builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
                List data = [];

                if (snapshot.hasData) {
                  for (var element in snapshot.data!.docs) {
                    data.add(element.data());
                  }
                }

                if (snapshot.hasError) {
                  Constants(context).snackBar(
                      'Something went wrong while loading this data',
                      Colors.red);

                  return const Center(
                    child: Text('No cancelled orders'),
                  );
                }

                return snapshot.connectionState == ConnectionState.waiting
                    ? const Center(
                        child: CircularProgressIndicator(
                          color: Constants.tetiary,
                        ),
                      )
                    : (data.isEmpty
                        ? const Center(
                            child: Text('No cancelled orders'),
                          )
                        : ListView.builder(
                            itemCount: data.length,
                            itemBuilder: (context, index) {
                              return Container(
                                padding: EdgeInsets.only(
                                    left: Dimensions.sizedBoxWidth10,
                                    right: Dimensions.sizedBoxWidth10,
                                    bottom: Dimensions.sizedBoxHeight10),
                                child: Material(
                                  borderRadius: BorderRadius.circular(
                                      Dimensions.sizedBoxWidth4),
                                  animationDuration:
                                      const Duration(milliseconds: 100),
                                  child: InkWell(
                                    child: IgnorePointer(
                                      child: Ink(
                                        height:
                                            Dimensions.sizedBoxHeight10 * 11,
                                        padding: EdgeInsets.all(
                                            Dimensions.sizedBoxWidth10),
                                        decoration: BoxDecoration(
                                          borderRadius: BorderRadius.circular(
                                              Dimensions.sizedBoxWidth4),
                                          color: Constants.white,
                                        ),
                                        child: Row(
                                          children: [
                                            Ink(
                                              width:
                                                  Dimensions.sizedBoxWidth100,
                                              decoration: BoxDecoration(
                                                  image: DecorationImage(
                                                      image:
                                                          CachedNetworkImageProvider(
                                                              data[index][
                                                                  Constants
                                                                      .imgUrl]),
                                                      fit: BoxFit.contain)),
                                            ),
                                            Expanded(
                                              child: Ink(
                                                child: Column(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  mainAxisAlignment:
                                                      MainAxisAlignment
                                                          .spaceBetween,
                                                  children: [
                                                    Column(
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .start,
                                                      children: [
                                                        Text(
                                                            data[index][
                                                                Constants.name],
                                                            overflow:
                                                                TextOverflow
                                                                    .ellipsis,
                                                            style: TextStyle(
                                                              fontSize:
                                                                  Dimensions
                                                                      .font12,
                                                            )),
                                                        SizedBox(
                                                          height: Dimensions
                                                              .sizedBoxHeight3,
                                                        ),
                                                        Text(
                                                            'Order ${data[index][Constants.orderId]}',
                                                            style: TextStyle(
                                                              fontSize:
                                                                  Dimensions
                                                                      .font12,
                                                            ))
                                                      ],
                                                    ),
                                                    Column(
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .start,
                                                      children: [
                                                        const BoxChip(
                                                          text:
                                                              'CANCELLED - PURCHASE UNSUCCESSFUL',
                                                          color: Color.fromARGB(
                                                              255,
                                                              100,
                                                              100,
                                                              100),
                                                        ),
                                                        SizedBox(
                                                          height: Dimensions
                                                              .sizedBoxHeight3,
                                                        ),
                                                        Text('On 30-06',
                                                            style: TextStyle(
                                                                fontSize:
                                                                    Dimensions
                                                                        .font12,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w500))
                                                      ],
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            )
                                          ],
                                        ),
                                      ),
                                    ),
                                    onTap: () {
                                      showDialog(
                                          context: context,
                                          barrierDismissible: false,
                                          builder: (context) => _showDialog(
                                              context,
                                              data[index][Constants.orderId],
                                              data[index][Constants.imgUrl],
                                              data[index][Constants.name],
                                              'CANCELLED - PURCHASE UNSUCCESSFUL',
                                              data[index][Constants.amount][0],
                                              const Color.fromARGB(
                                                  255, 100, 100, 100)));
                                    },
                                  ),
                                ),
                              );
                            },
                          ));
              },
            ),
          ]),
        )
      ],
    );
  }

  Widget _showDialog(context, String orderId, String imgUrl, String name,
      String status, double price, Color color) {
    return Dialog(
      insetPadding:
          EdgeInsets.symmetric(horizontal: Dimensions.sizedBoxWidth10),
      child: Container(
        padding: EdgeInsets.all(Dimensions.sizedBoxWidth15),
        width: double.maxFinite,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                RichText(
                  text: TextSpan(
                      text: 'Order Id: ',
                      style: TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.w500,
                          fontSize: Dimensions.font16),
                      children: [
                        TextSpan(
                          text: orderId,
                          style: const TextStyle(color: Colors.grey),
                        ),
                      ]),
                ),
                GestureDetector(
                  child: const Icon(Icons.close),
                  onTap: () {
                    Navigator.pop(context);
                  },
                )
              ],
            ),
            SizedBox(
              height: Dimensions.sizedBoxHeight10,
            ),
            Row(
              children: [
                Container(
                  width: Dimensions.sizedBoxWidth100,
                  height: Dimensions.sizedBoxWidth100,
                  decoration: BoxDecoration(
                      image: DecorationImage(
                          image: CachedNetworkImageProvider(imgUrl),
                          fit: BoxFit.contain)),
                ),
                Expanded(
                  child: Text(name,
                      style: TextStyle(
                        fontSize: Dimensions.font12,
                      )),
                )
              ],
            ),
            SizedBox(
              height: Dimensions.sizedBoxHeight10,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                RichText(
                  text: TextSpan(
                      text: 'Price: ',
                      style: TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.w500,
                          fontSize: Dimensions.font14),
                      children: [
                        TextSpan(
                          text: '\$ $price',
                          style: const TextStyle(color: Colors.grey),
                        ),
                      ]),
                ),
                Row(
                  children: [
                    Text(
                      'Status:',
                      style: TextStyle(
                          fontWeight: FontWeight.w500,
                          fontSize: Dimensions.font16),
                    ),
                    SizedBox(
                      width: Dimensions.sizedBoxWidth10 / 2,
                    ),
                    BoxChip(
                      text: status,
                      color: color,
                    )
                  ],
                )
              ],
            ),
            SizedBox(
              height: Dimensions.sizedBoxHeight15,
            ),
            status != 'NEW'
                ? Container()
                : Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      DropdownButton(
                        items: const [
                          DropdownMenuItem(
                              value: 'Processing', child: Text('Processing'))
                        ],
                        value: 'Processing',
                        onChanged: (dynamic value) {},
                      ),
                      Container(
                        padding: EdgeInsets.symmetric(
                            vertical: Dimensions.sizedBoxHeight4),
                        width: Dimensions.sizedBoxWidth100,
                        child: const ElevatedBtn(
                          text: 'Update',
                        ),
                      )
                    ],
                  )
          ],
        ),
      ),
    );
  }
}
