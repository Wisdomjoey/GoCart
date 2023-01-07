import 'dart:async';

import 'package:GOCart/UI/routes/route_helper.dart';
import 'package:GOCart/UI/widgets/elevated_button_widget.dart';
import 'package:GOCart/UI/widgets/list_tile_btn_widget.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../CONSTANTS/constants.dart';
import '../../utils/dimensions.dart';
import '../../widgets/star_rating_widget.dart';

class CheckProductsPage extends StatelessWidget {
  const CheckProductsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: EdgeInsets.all(Dimensions.sizedBoxWidth15),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Material(
              child: Ink(
                  decoration: BoxDecoration(
                      color: Constants.white,
                      borderRadius: BorderRadius.circular(
                          Dimensions.sizedBoxWidth10 / 2)),
                  child: ListTileBtn(
                    title: 'Add Products',
                    textSize: Dimensions.font17,
                    textColor: const Color.fromARGB(255, 130, 130, 130),
                    trailing: const Icon(
                      Icons.add_task,
                      color: Color.fromARGB(255, 89, 89, 89),
                    ),
                    onTap: () {
                      Timer(const Duration(milliseconds: 200),
                          () => Get.toNamed(RouteHelper.getAddProductPage()));
                    },
                  )),
            ),
            SizedBox(
              height: Dimensions.sizedBoxHeight15,
            ),
            GridView.builder(
              physics: const NeverScrollableScrollPhysics(),
              shrinkWrap: true,
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  mainAxisSpacing: Dimensions.sizedBoxHeight10 * 2,
                  crossAxisSpacing: Dimensions.sizedBoxWidth10,
                  childAspectRatio: 0.7),
              itemCount: 20,
              itemBuilder: (context, index) {
                return Material(
                  animationDuration: const Duration(milliseconds: 100),
                  shape: RoundedRectangleBorder(
                    borderRadius:
                        BorderRadius.circular(Dimensions.sizedBoxWidth4),
                  ),
                  elevation: 5,
                  shadowColor: const Color.fromARGB(125, 0, 0, 0),
                  child: InkWell(
                    borderRadius:
                        BorderRadius.circular(Dimensions.sizedBoxWidth4),
                    child: Ink(
                      decoration: BoxDecoration(
                        borderRadius:
                            BorderRadius.circular(Dimensions.sizedBoxWidth4),
                        color: Constants.white,
                      ),
                      child: Column(
                        children: [
                          Expanded(
                            child: Padding(
                              padding:
                                  EdgeInsets.all(Dimensions.sizedBoxWidth10),
                              child:
                                  Stack(alignment: Alignment.center, children: [
                                Ink(
                                  height: double.maxFinite,
                                  decoration: BoxDecoration(
                                      image: DecorationImage(
                                          image: index.isEven
                                              ? const AssetImage(
                                                  'assets/images/1.jpg')
                                              : const AssetImage(
                                                  'assets/images/build.jpg'),
                                          fit: BoxFit.contain)),
                                ),
                                Align(
                                  alignment: Alignment.topRight,
                                  child: Container(
                                      width: Dimensions.sizedBoxWidth10 * 2.5,
                                      height: Dimensions.sizedBoxWidth10 * 2.5,
                                      decoration: BoxDecoration(
                                          borderRadius: BorderRadius.circular(
                                              Dimensions.sizedBoxWidth3),
                                          color:
                                              Constants.primary.withAlpha(70)),
                                      child: Center(
                                        child: PopupMenuButton(
                                          tooltip: 'Actions',
                                          icon: const Icon(
                                            Icons.more_horiz,
                                            color: Colors.black,
                                            size: 15,
                                          ),
                                          padding: const EdgeInsets.all(0),
                                          itemBuilder: (context) {
                                            return [
                                              PopupMenuItem(
                                                  onTap: () {
                                                    Timer(
                                                        const Duration(
                                                            milliseconds: 200),
                                                        () => Get.toNamed(
                                                            RouteHelper
                                                                .getEditProductPage()));
                                                  },
                                                  padding:
                                                      const EdgeInsets.all(0),
                                                  child: Container(
                                                      padding: const EdgeInsets
                                                              .symmetric(
                                                          horizontal: 16),
                                                      decoration: const BoxDecoration(
                                                          border: Border(
                                                              bottom: BorderSide(
                                                                  color: Color
                                                                      .fromARGB(
                                                                          255,
                                                                          225,
                                                                          225,
                                                                          225)))),
                                                      child: const ListTileBtn(
                                                        title: 'Edit',
                                                        trailing: Icon(
                                                          Icons
                                                              .drive_file_rename_outline_rounded,
                                                          color: Colors.blue,
                                                        ),
                                                        visualD: -4,
                                                      ))),
                                              PopupMenuItem(
                                                  child: ListTileBtn(
                                                onTap: () {
                                                  showDialog(
                                                      context: context,
                                                      builder: (context) =>
                                                          _showDialog(context));
                                                },
                                                title: 'Delete',
                                                trailing: const Icon(
                                                  Icons.delete,
                                                  color: Colors.red,
                                                ),
                                                visualD: -3,
                                              )),
                                            ];
                                          },
                                        ),
                                      )),
                                )
                              ]),
                            ),
                          ),
                          Ink(
                            padding: EdgeInsets.only(
                                left: Dimensions.sizedBoxWidth10,
                                right: Dimensions.sizedBoxWidth10,
                                bottom: Dimensions.sizedBoxHeight10),
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.only(
                                    bottomLeft: Radius.circular(
                                        Dimensions.sizedBoxWidth4),
                                    bottomRight: Radius.circular(
                                        Dimensions.sizedBoxWidth4)),
                                color: Constants.white),
                            width: double.maxFinite,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'Tractor with wide rollers and high maintainence',
                                  overflow: TextOverflow.ellipsis,
                                  style: TextStyle(
                                      fontSize: Dimensions.font13,
                                      fontWeight: FontWeight.w300),
                                ),
                                SizedBox(
                                  height: Dimensions.sizedBoxHeight4,
                                ),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      '\$ 8000',
                                      style: TextStyle(
                                          fontSize: Dimensions.font16,
                                          fontWeight: FontWeight.w500),
                                    ),
                                    Row(
                                      children: [
                                        Text(
                                          'Stock:',
                                          style: TextStyle(
                                              fontWeight: FontWeight.w500,
                                              fontSize: Dimensions.font12,
                                              color: Constants.grey),
                                        ),
                                        SizedBox(
                                          width: Dimensions.sizedBoxWidth3,
                                        ),
                                        Text(
                                          '213',
                                          style: TextStyle(
                                              fontWeight: FontWeight.w500,
                                              fontSize: Dimensions.font12),
                                        ),
                                      ],
                                    )
                                  ],
                                ),
                                SizedBox(
                                  height: Dimensions.sizedBoxHeight4,
                                ),
                                const StarRating(),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                    onTap: () {},
                  ),
                );
              },
            )
          ],
        ),
      ),
    );
  }

  Widget _showDialog(context) {
    return Dialog(
      insetPadding:
          EdgeInsets.symmetric(horizontal: Dimensions.sizedBoxWidth10 * 2),
      child: Container(
        padding: EdgeInsets.all(Dimensions.sizedBoxWidth15),
        width: double.maxFinite,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              'Are you sure you want to delete this product?',
              style: TextStyle(
                  fontSize: Dimensions.font18, fontWeight: FontWeight.w500),
              textAlign: TextAlign.center,
            ),
            SizedBox(
              height: Dimensions.sizedBoxWidth15 * 2,
            ),
            Row(
              children: [
                SizedBox(
                  width: Dimensions.sizedBoxWidth15,
                ),
                Expanded(
                  child: SizedBox(
                    height: Dimensions.sizedBoxHeight10 * 4,
                    width: double.maxFinite,
                    child: const ElevatedBtn(
                      text: 'YES',
                      bgColor: Colors.green,
                      icon: Icon(
                        Icons.task_alt,
                        color: Constants.white,
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  width: Dimensions.sizedBoxWidth10 * 2,
                ),
                Expanded(
                    child: SizedBox(
                  height: Dimensions.sizedBoxHeight10 * 4,
                  width: double.maxFinite,
                  child: ElevatedBtn(
                      text: 'NO',
                      bgColor: Colors.red,
                      pressed: () => Navigator.pop(context),
                      icon: const Icon(
                        Icons.close,
                        color: Constants.white,
                      )),
                )),
                SizedBox(
                  width: Dimensions.sizedBoxWidth15,
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
