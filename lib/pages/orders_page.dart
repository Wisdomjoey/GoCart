import 'package:flutter/material.dart';
import 'package:schoolproj/components/home_app_bar.dart';
import 'package:schoolproj/components/order_item_box.dart';
import 'package:schoolproj/utils/dimensions.dart';

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
      backgroundColor: const Color.fromARGB(255, 243, 243, 243),
      body: Column(
        children: [
          Container(
            width: double.maxFinite,
            color: Colors.white,
            height: Dimensions.sizedBoxHeight10 * 4,
            child: Material(
              child: TabBar(
                controller: _tabController,
                indicatorColor: const Color(0XFFF8C300),
                labelColor: const Color(0XFFF8C300),
                unselectedLabelColor: const Color.fromARGB(255, 125, 125, 125),
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
            child: TabBarView(controller: _tabController, children: const [
              OrderItemBox(text: 'DELIVERED', state: 'open',),
              OrderItemBox(text: 'CANCELLED - PAYMENT UNSUCCESSFUL', color: Color.fromARGB(255, 100, 100, 100), state: 'closed',),
            ]),
          )
        ],
      ),
    );
  }
}
