import 'package:GOCart/PROVIDERS/order_provider.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:GOCart/UI/components/home_app_bar.dart';
import 'package:GOCart/UI/components/order_item_box.dart';
import 'package:GOCart/UI/utils/dimensions.dart';
import 'package:provider/provider.dart';

import '../../CONSTANTS/constants.dart';

class OrdersPage extends StatefulWidget {
  const OrdersPage({super.key});

  @override
  State<OrdersPage> createState() => _OrdersPageState();
}

class _OrdersPageState extends State<OrdersPage>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;
  // int _selectedIndex = 1;

  @override
  void initState() {
    _tabController = TabController(length: 2, vsync: this);
    super.initState();
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: HomeAppBar(
        title: 'Orders',
        showCart: true,
        implyLeading: true,
        textSize: Dimensions.font24,
      ),
      body: FutureBuilder(
        future: Provider.of<OrderProvider>(context, listen: false)
            .fetchUserOrders(FirebaseAuth.instance.currentUser!.uid),
        builder: (context, AsyncSnapshot snapshot) {
          List<Map<String, dynamic>> open = [];
          List<Map<String, dynamic>> closed = [];

          if (snapshot.hasData) {
            for (var element in snapshot.data) {
              if (element.get(Constants.orderStatus) == 'new' ||
                  element.get(Constants.orderStatus) == 'processing') {
                open.add(element.data());
              } else {
                closed.add(element.data());
              }
            }
          }

          return snapshot.connectionState == ConnectionState.waiting
              ? const Center(
                  child: CircularProgressIndicator(color: Constants.tetiary),
                )
              : Column(
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
                          unselectedLabelColor:
                              const Color.fromARGB(255, 125, 125, 125),
                          onTap: (value) {},
                          isScrollable: true,
                          tabs: [
                            SizedBox(
                              width: Dimensions.sizedBoxWidth148,
                              child: const Tab(text: 'OPEN ORDERS'),
                            ),
                            SizedBox(
                              width: Dimensions.sizedBoxWidth148,
                              child: const Tab(
                                text: 'CLOSED ORDERS',
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
                        OrderItemBox(data: open),
                        OrderItemBox(
                          data: closed,
                        ),
                      ]),
                    )
                  ],
                );
        },
      ),
    );
  }
}
