import 'dart:ffi';

import 'package:GOCart/UI/routes/route_helper.dart';
import 'package:bouncing_widget/bouncing_widget.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../utils/dimensions.dart';

class ShopPage extends StatefulWidget {
  const ShopPage({super.key});

  @override
  State<ShopPage> createState() => _ShopPageState();
}

class _ShopPageState extends State<ShopPage> {
  bool isEmpty = false;
  List<bool> isFav = List<bool>.generate(10, (index) => false);

  @override
  Widget build(BuildContext context) {
    return isEmpty
        ? Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Center(
                child: Image.asset(
                  'assets/images/shop.png',
                  width: Dimensions.sizedBoxWidth100 * 3,
                ),
              ),
              SizedBox(
                height: Dimensions.sizedBoxWidth15 * 2,
              ),
              const Center(
                child: Text(
                  'No Shops At The Moment',
                  style: TextStyle(color: Colors.grey),
                ),
              ),
            ],
          )
        : ListView.builder(
            itemCount: 10,
            itemBuilder: ((context, index) {
              return Container(
                padding: EdgeInsets.all(Dimensions.sizedBoxWidth15),
                margin:
                    EdgeInsets.only(bottom: Dimensions.sizedBoxHeight10 * 2),
                child: Material(
                  borderRadius:
                      BorderRadius.circular(Dimensions.sizedBoxWidth10),
                  elevation: 7,
                  child: InkWell(
                    borderRadius:
                        BorderRadius.circular(Dimensions.sizedBoxWidth10),
                    child: Ink(
                      height: 170,
                      decoration: BoxDecoration(
                        borderRadius:
                            BorderRadius.circular(Dimensions.sizedBoxWidth10),
                      ),
                      child: Stack(
                        children: [
                          Ink(
                            height: Dimensions.sizedBoxHeight10 * 17,
                            decoration: BoxDecoration(
                              image: const DecorationImage(
                                  image: AssetImage('assets/images/med.gif'),
                                  fit: BoxFit.cover),
                              borderRadius: BorderRadius.circular(
                                  Dimensions.sizedBoxWidth10),
                            ),
                          ),
                          Container(
                            width: double.maxFinite,
                            height: double.maxFinite,
                            decoration: BoxDecoration(
                              color: const Color.fromARGB(63, 0, 0, 0),
                              borderRadius: BorderRadius.circular(
                                  Dimensions.sizedBoxWidth10),
                            ),
                            child: Align(
                              alignment: Alignment.bottomCenter,
                              child: Container(
                                height: Dimensions.sizedBoxHeight10 * 6,
                                width: double.maxFinite,
                                padding: EdgeInsets.only(
                                    left: Dimensions.sizedBoxWidth10,
                                    right: Dimensions.sizedBoxWidth15),
                                decoration: BoxDecoration(
                                    color:
                                        const Color.fromARGB(212, 31, 31, 31),
                                    borderRadius: BorderRadius.only(
                                        bottomLeft: Radius.circular(
                                            Dimensions.sizedBoxWidth10),
                                        bottomRight: Radius.circular(
                                            Dimensions.sizedBoxWidth10))),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    IconButton(
                                      splashRadius:
                                          Dimensions.sizedBoxWidth15 * 2,
                                      icon: Icon(
                                        isFav[index]
                                            ? Icons.star_rounded
                                            : Icons.star_border_rounded,
                                        color: const Color.fromARGB(
                                            255, 196, 196, 196),
                                      ),
                                      onPressed: () {
                                        setState(() {
                                          isFav[index] = !isFav[index];
                                          print(isFav[index].toString());
                                        });
                                      },
                                    ),
                                    Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        Text(
                                          'Mr. Kola Shop',
                                          style: TextStyle(
                                              color: Colors.white,
                                              fontSize: Dimensions.font18,
                                              fontWeight: FontWeight.w500),
                                        ),
                                        SizedBox(
                                          height:
                                              Dimensions.sizedBoxHeight10 / 2,
                                        ),
                                        Text(
                                          'Check out ptoducts >',
                                          style: TextStyle(
                                              color: const Color.fromARGB(
                                                  255, 196, 196, 196),
                                              fontSize: Dimensions.font11),
                                        ),
                                      ],
                                    )
                                  ],
                                ),
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                    onTap: () => Get.toNamed(RouteHelper.getShopDetailsPage()),
                  ),
                ),
              );
            }),
          );
  }
}
