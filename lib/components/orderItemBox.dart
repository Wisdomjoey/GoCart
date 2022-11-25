import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:schoolproj/widgets/boxChipWidget.dart';

import '../routes/route_helper.dart';
import '../utils/dimensions.dart';

class OrderItemBox extends StatelessWidget {
  final Color color;
  final String text;
  final String state;

  const OrderItemBox(
      {super.key,
      this.color = const Color.fromARGB(255, 107, 205, 110),
      required this.text,
      required this.state});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: 5,
      itemBuilder: (context, index) {
        return Container(
          padding: EdgeInsets.only(
              left: Dimensions.sizedBoxWidth10,
              right: Dimensions.sizedBoxWidth10,
              bottom: Dimensions.sizedBoxHeight10),
          child: Material(
            borderRadius: BorderRadius.circular(Dimensions.sizedBoxWidth4),
            animationDuration: const Duration(milliseconds: 100),
            child: InkWell(
              child: Ink(
                height: Dimensions.sizedBoxHeight10 * 11,
                padding: EdgeInsets.all(Dimensions.sizedBoxWidth10),
                decoration: BoxDecoration(
                  borderRadius:
                      BorderRadius.circular(Dimensions.sizedBoxWidth4),
                  color: Colors.white,
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
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
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
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                BoxChip(
                                  text: text,
                                  color: color,
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
                Get.toNamed(RouteHelper.getOrderDetailsPage(state, text));
              },
            ),
          ),
        );
      },
    );
  }
}
