import 'dart:async';

import 'package:GOCart/UI/widgets/elevated_button_widget.dart';
import 'package:flutter/material.dart';

import '../../../CONSTANTS/constants.dart';
import '../../utils/dimensions.dart';
import '../../widgets/box_chip_widget.dart';

class CheckOrdersPage extends StatefulWidget {
  const CheckOrdersPage({super.key});

  @override
  State<CheckOrdersPage> createState() => _CheckOrdersPageState();
}

class _CheckOrdersPageState extends State<CheckOrdersPage>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;
  // int _selectedIndex = 1;

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
            ListView.builder(
              itemCount: 5,
              itemBuilder: (context, index) {
                return Container(
                  padding: EdgeInsets.only(
                      left: Dimensions.sizedBoxWidth10,
                      right: Dimensions.sizedBoxWidth10,
                      bottom: Dimensions.sizedBoxHeight10),
                  child: Material(
                    borderRadius:
                        BorderRadius.circular(Dimensions.sizedBoxWidth4),
                    animationDuration: const Duration(milliseconds: 100),
                    child: InkWell(
                      child: Ink(
                        height: Dimensions.sizedBoxHeight10 * 11,
                        padding: EdgeInsets.all(Dimensions.sizedBoxWidth10),
                        decoration: BoxDecoration(
                          borderRadius:
                              BorderRadius.circular(Dimensions.sizedBoxWidth4),
                          color: Constants.white,
                        ),
                        child: Row(
                          children: [
                            Ink(
                              width: Dimensions.sizedBoxWidth100,
                              decoration: const BoxDecoration(
                                  image: DecorationImage(
                                      image: AssetImage('assets/images/1.jpg'),
                                      fit: BoxFit.contain)),
                            ),
                            Expanded(
                              child: Ink(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                            'Rechargeable Hand drier with wireless charging function.',
                                            overflow: TextOverflow.ellipsis,
                                            style: TextStyle(
                                              fontSize: Dimensions.font12,
                                            )),
                                        SizedBox(
                                          height: Dimensions.sizedBoxHeight3,
                                        ),
                                        Text('Order #127339927228',
                                            style: TextStyle(
                                              fontSize: Dimensions.font12,
                                            ))
                                      ],
                                    ),
                                    Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        const BoxChip(
                                          text: 'DELIVERED',
                                          color: Color.fromARGB(
                                              255, 107, 205, 110),
                                        ),
                                        SizedBox(
                                          height: Dimensions.sizedBoxHeight3,
                                        ),
                                        Text('On 30-06',
                                            style: TextStyle(
                                                fontSize: Dimensions.font12,
                                                fontWeight: FontWeight.w500))
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
                            builder: (context) => _showDialog(context));
                      },
                    ),
                  ),
                );
              },
            ),
            ListView.builder(
              itemCount: 5,
              itemBuilder: (context, index) {
                return Container(
                  padding: EdgeInsets.only(
                      left: Dimensions.sizedBoxWidth10,
                      right: Dimensions.sizedBoxWidth10,
                      bottom: Dimensions.sizedBoxHeight10),
                  child: Material(
                    borderRadius:
                        BorderRadius.circular(Dimensions.sizedBoxWidth4),
                    animationDuration: const Duration(milliseconds: 100),
                    child: InkWell(
                      child: IgnorePointer(
                        child: Ink(
                          height: Dimensions.sizedBoxHeight10 * 11,
                          padding: EdgeInsets.all(Dimensions.sizedBoxWidth10),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(
                                Dimensions.sizedBoxWidth4),
                            color: Constants.white,
                          ),
                          child: Row(
                            children: [
                              Ink(
                                width: Dimensions.sizedBoxWidth100,
                                decoration: const BoxDecoration(
                                    image: DecorationImage(
                                        image:
                                            AssetImage('assets/images/1.jpg'),
                                        fit: BoxFit.contain)),
                              ),
                              Expanded(
                                child: Ink(
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                              'Rechargeable Hand drier with wireless charging function.',
                                              overflow: TextOverflow.ellipsis,
                                              style: TextStyle(
                                                fontSize: Dimensions.font12,
                                              )),
                                          SizedBox(
                                            height: Dimensions.sizedBoxHeight3,
                                          ),
                                          Text('Order #127339927228',
                                              style: TextStyle(
                                                fontSize: Dimensions.font12,
                                              ))
                                        ],
                                      ),
                                      Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          const BoxChip(
                                            text:
                                                'CANCELLED - PAYMENT UNSUCCESSFUL',
                                            color: Color.fromARGB(
                                                255, 100, 100, 100),
                                          ),
                                          SizedBox(
                                            height: Dimensions.sizedBoxHeight3,
                                          ),
                                          Text('On 30-06',
                                              style: TextStyle(
                                                  fontSize: Dimensions.font12,
                                                  fontWeight: FontWeight.w500))
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
                            builder: (context) => _showDialog(context));
                      },
                    ),
                  ),
                );
              },
            ),
            ListView.builder(
              itemCount: 5,
              itemBuilder: (context, index) {
                return Container(
                  padding: EdgeInsets.only(
                      left: Dimensions.sizedBoxWidth10,
                      right: Dimensions.sizedBoxWidth10,
                      bottom: Dimensions.sizedBoxHeight10),
                  child: Material(
                    borderRadius:
                        BorderRadius.circular(Dimensions.sizedBoxWidth4),
                    animationDuration: const Duration(milliseconds: 100),
                    child: InkWell(
                      child: IgnorePointer(
                        child: Ink(
                          height: Dimensions.sizedBoxHeight10 * 11,
                          padding: EdgeInsets.all(Dimensions.sizedBoxWidth10),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(
                                Dimensions.sizedBoxWidth4),
                            color: Constants.white,
                          ),
                          child: Row(
                            children: [
                              Ink(
                                width: Dimensions.sizedBoxWidth100,
                                decoration: const BoxDecoration(
                                    image: DecorationImage(
                                        image:
                                            AssetImage('assets/images/1.jpg'),
                                        fit: BoxFit.contain)),
                              ),
                              Expanded(
                                child: Ink(
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                              'Rechargeable Hand drier with wireless charging function.',
                                              overflow: TextOverflow.ellipsis,
                                              style: TextStyle(
                                                fontSize: Dimensions.font12,
                                              )),
                                          SizedBox(
                                            height: Dimensions.sizedBoxHeight3,
                                          ),
                                          Text('Order #127339927228',
                                              style: TextStyle(
                                                fontSize: Dimensions.font12,
                                              ))
                                        ],
                                      ),
                                      Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          const BoxChip(
                                            text:
                                                'CANCELLED - PAYMENT UNSUCCESSFUL',
                                            color: Color.fromARGB(
                                                255, 100, 100, 100),
                                          ),
                                          SizedBox(
                                            height: Dimensions.sizedBoxHeight3,
                                          ),
                                          Text('On 30-06',
                                              style: TextStyle(
                                                  fontSize: Dimensions.font12,
                                                  fontWeight: FontWeight.w500))
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
                            builder: (context) => _showDialog(context));
                      },
                    ),
                  ),
                );
              },
            ),
            ListView.builder(
              itemCount: 5,
              itemBuilder: (context, index) {
                return Container(
                  padding: EdgeInsets.only(
                      left: Dimensions.sizedBoxWidth10,
                      right: Dimensions.sizedBoxWidth10,
                      bottom: Dimensions.sizedBoxHeight10),
                  child: Material(
                    borderRadius:
                        BorderRadius.circular(Dimensions.sizedBoxWidth4),
                    animationDuration: const Duration(milliseconds: 100),
                    child: InkWell(
                      child: IgnorePointer(
                        child: Ink(
                          height: Dimensions.sizedBoxHeight10 * 11,
                          padding: EdgeInsets.all(Dimensions.sizedBoxWidth10),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(
                                Dimensions.sizedBoxWidth4),
                            color: Constants.white,
                          ),
                          child: Row(
                            children: [
                              Ink(
                                width: Dimensions.sizedBoxWidth100,
                                decoration: const BoxDecoration(
                                    image: DecorationImage(
                                        image:
                                            AssetImage('assets/images/1.jpg'),
                                        fit: BoxFit.contain)),
                              ),
                              Expanded(
                                child: Ink(
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                              'Rechargeable Hand drier with wireless charging function.',
                                              overflow: TextOverflow.ellipsis,
                                              style: TextStyle(
                                                fontSize: Dimensions.font12,
                                              )),
                                          SizedBox(
                                            height: Dimensions.sizedBoxHeight3,
                                          ),
                                          Text('Order #127339927228',
                                              style: TextStyle(
                                                fontSize: Dimensions.font12,
                                              ))
                                        ],
                                      ),
                                      Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          const BoxChip(
                                            text:
                                                'CANCELLED - PAYMENT UNSUCCESSFUL',
                                            color: Color.fromARGB(
                                                255, 100, 100, 100),
                                          ),
                                          SizedBox(
                                            height: Dimensions.sizedBoxHeight3,
                                          ),
                                          Text('On 30-06',
                                              style: TextStyle(
                                                  fontSize: Dimensions.font12,
                                                  fontWeight: FontWeight.w500))
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
                            builder: (context) => _showDialog(context));
                      },
                    ),
                  ),
                );
              },
            ),
          ]),
        )
      ],
    );
  }

  Widget _showDialog(context) {
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
                          text: '#356532579',
                          style: TextStyle(color: Colors.grey),
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
            SizedBox(height: Dimensions.sizedBoxHeight10,),
            Row(
              children: [
                Container(
                  width: Dimensions.sizedBoxWidth100,
                  height: Dimensions.sizedBoxWidth100,
                  decoration: const BoxDecoration(
                      image: DecorationImage(
                          image: AssetImage('assets/images/1.jpg'),
                          fit: BoxFit.contain)),
                ),
                Expanded(
                  child: Text(
                      'Rechargeable Hand drier with wireless charging function.',
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
                      children: const [
                        TextSpan(
                          text: '\$ 800',
                          style: TextStyle(color: Colors.grey),
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
                      text: 'DELIVERED',
                      color: Color.fromARGB(255, 107, 205, 110),
                    )
                  ],
                )
              ],
            ),
            SizedBox(
              height: Dimensions.sizedBoxHeight15,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                DropdownButton(
                  items: [
                    DropdownMenuItem(child: Text('Processing'), value: 'Processing')
                  ],
                  value: 'Processing',
                  onChanged: (dynamic value) {
                    
                  },
                ),
                Container(
                  padding: EdgeInsets.symmetric(vertical: Dimensions.sizedBoxHeight4),
                  width: Dimensions.sizedBoxWidth100,
                  child: ElevatedBtn(text: 'Update',),
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}
