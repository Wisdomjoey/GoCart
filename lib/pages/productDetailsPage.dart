import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:schoolproj/components/ReviewBoxCon.dart';
import 'package:schoolproj/components/detailsBottomNavigation.dart';
import 'package:schoolproj/components/homeAppBar.dart';
import 'package:schoolproj/pages/RatingViewPage.dart';
import 'package:schoolproj/utils/dimensions.dart';
import 'package:schoolproj/widgets/ListTileBtnWidget.dart';
import 'package:schoolproj/widgets/headSectionWidget.dart';
import 'package:schoolproj/widgets/iconBoxWidget.dart';
import 'package:schoolproj/widgets/starRatingWidget.dart';

import 'detailsPage.dart';

class ProductDetailsPage extends StatefulWidget {
  const ProductDetailsPage({super.key});

  @override
  State<ProductDetailsPage> createState() => _ProductDetailsPageState();
}

class _ProductDetailsPageState extends State<ProductDetailsPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: HomeAppBar(
        title: 'Details',
        textSize: Dimensions.font25,
        implyLeading: true,
        showPopUp: true,
        showCart: true,
      ),
      backgroundColor: const Color.fromARGB(255, 243, 243, 243),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              width: double.maxFinite,
              height: Dimensions.sizedBoxHeight320,
              padding:
                  EdgeInsets.symmetric(vertical: Dimensions.sizedBoxHeight10),
              child: CarouselSlider.builder(
                options: CarouselOptions(
                  height: Dimensions.sizedBoxHeight320,
                  autoPlay: true,
                  autoPlayInterval: const Duration(seconds: 7),
                  autoPlayAnimationDuration: const Duration(milliseconds: 800),
                  viewportFraction: 1,
                  enableInfiniteScroll: false,
                  scrollDirection: Axis.horizontal,
                  initialPage: 0,
                ),
                itemCount: 5,
                itemBuilder: (context, index, realIndex) {
                  return _buildPageItem();
                },
              ),
            ),
            Container(
              padding: EdgeInsets.symmetric(
                  horizontal: Dimensions.sizedBoxWidth10 * 2,
                  vertical: Dimensions.sizedBoxHeight10),
              width: double.maxFinite,
              color: Colors.white,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Tractor with wide rollers and high maintainence',
                    style: TextStyle(
                      fontSize: Dimensions.font17,
                    ),
                  ),
                  SizedBox(
                    height: Dimensions.sizedBoxHeight10,
                  ),
                  Text(
                    '\$ 8000',
                    style: TextStyle(
                        fontSize: Dimensions.font24,
                        fontWeight: FontWeight.w500),
                  ),
                  SizedBox(
                    height: Dimensions.sizedBoxHeight10 / 2,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          const StarRating(),
                          SizedBox(
                            width: Dimensions.sizedBoxWidth10 / 2,
                          ),
                          const Text(
                            '(90 ratings)',
                            style: TextStyle(color: Color(0XFF00923F)),
                          )
                        ],
                      ),
                      Row(
                        children: [
                          const Icon(
                            Icons.share,
                            color: Color(0XFFF8C300),
                          ),
                          SizedBox(
                            width: Dimensions.sizedBoxWidth25,
                          ),
                          const Icon(
                            Icons.favorite_border_outlined,
                            color: Color(0XFFF8C300),
                          ),
                        ],
                      )
                    ],
                  )
                ],
              ),
            ),
            const HeadSedction(text: 'DELIVERY AND RETURNS INFO'),
            Container(
              padding: EdgeInsets.symmetric(
                  horizontal: Dimensions.sizedBoxWidth10 * 2,
                  vertical: Dimensions.sizedBoxHeight10),
              width: double.maxFinite,
              color: Colors.white,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      IconBox(
                        icon: Icons.delivery_dining_outlined,
                        right: Dimensions.sizedBoxWidth10,
                        iconSize: Dimensions.font23,
                        isClickable: false,
                        iconColor: Colors.grey,
                        borderColor: const Color.fromARGB(156, 158, 158, 158),
                      ),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                const Text(
                                  'In-Campus Delivery',
                                  style: TextStyle(fontWeight: FontWeight.w500),
                                ),
                                GestureDetector(
                                  child: Text(
                                    'Details',
                                    style: TextStyle(
                                        color: Colors.blueAccent,
                                        fontSize: Dimensions.font12),
                                  ),
                                  onTap: () {
                                    showDialog(
                                        context: context,
                                        builder: (context) =>
                                            _showDialog(context));
                                  },
                                )
                              ],
                            ),
                            SizedBox(
                              height: Dimensions.sizedBoxHeight3,
                            ),
                            Text(
                              'Delivery \$ 10',
                              style: TextStyle(fontSize: Dimensions.font12),
                            ),
                            Text(
                              'Delivery within 30mins - 1hr',
                              style: TextStyle(fontSize: Dimensions.font12),
                            )
                          ],
                        ),
                      )
                    ],
                  ),
                  SizedBox(
                    height: Dimensions.sizedBoxHeight15,
                  ),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      IconBox(
                        icon: Icons.history,
                        right: Dimensions.sizedBoxWidth10,
                        iconColor: Colors.grey,
                        iconSize: Dimensions.font23,
                        isClickable: false,
                        borderColor: const Color.fromARGB(156, 158, 158, 158),
                      ),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: const [
                                Text(
                                  'Return Policy',
                                  style: TextStyle(fontWeight: FontWeight.w500),
                                ),
                              ],
                            ),
                            SizedBox(
                              height: Dimensions.sizedBoxHeight3,
                            ),
                            Text(
                              'Free return within 1hour after puchase and delivery, product would not be accepted after 1hour of successful delivery.',
                              style: TextStyle(fontSize: Dimensions.font12),
                            ),
                          ],
                        ),
                      )
                    ],
                  ),
                ],
              ),
            ),
            const HeadSedction(text: 'PRODUCT DETAILS'),
            Container(
              margin:
                  EdgeInsets.symmetric(horizontal: Dimensions.sizedBoxWidth10),
              width: double.maxFinite,
              decoration: BoxDecoration(
                  color: Colors.white, borderRadius: BorderRadius.circular(Dimensions.sizedBoxWidth10 / 2)),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Material(
                    borderRadius: BorderRadius.circular(Dimensions.sizedBoxWidth10 / 2),
                    color: Colors.white,
                    child: ListTileBtn(
                      title: 'Description',
                      textSize: Dimensions.font16,
                      visualD: -3,
                      weight: FontWeight.w500,
                      page: const DetailsPage(),
                    ),
                  ),
                  SizedBox(
                    width: double.maxFinite,
                    child: Container(
                      height: 1,
                      color: const Color(0XFFEDEDED),
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.all(Dimensions.sizedBoxWidth10),
                    child: const Text(
                        'Lorem ipsum dolor sit amet, consectetur adipisicing elit. Ducimus deserunt cumque doloremque sequi facilis, ipsum quae atque vero repellat molestiae ipsam delectus ratione pariatur totam officia minima animi accusantium veritatis.'),
                  )
                ],
              ),
            ),
            const HeadSedction(text: 'VERIFIED CUSTOMER FEEDBACK'),
            Container(
              margin:
                  EdgeInsets.symmetric(horizontal: Dimensions.sizedBoxWidth10),
              width: double.maxFinite,
              decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(Dimensions.font25 / 5)),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Material(
                    borderRadius:
                        BorderRadius.circular(Dimensions.sizedBoxWidth10 / 2),
                    color: Colors.white,
                    child: ListTileBtn(
                      page: const RatingViewPage(),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Product Rating & Reviews',
                            style: TextStyle(
                                fontSize: Dimensions.font16,
                                fontWeight: FontWeight.w500),
                          ),
                          SizedBox(
                            height: Dimensions.sizedBoxHeight10,
                          ),
                          Row(
                            children: [
                              Container(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 1.5),
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(
                                        Dimensions.font12 / 6),
                                    border: Border.all(
                                        color: const Color.fromARGB(
                                            108, 248, 194, 0))),
                                child: Center(
                                  child: Row(
                                    children: [
                                      Text(
                                        '4.9',
                                        style: TextStyle(
                                            color: const Color(0XFFF8C300),
                                            fontWeight: FontWeight.w600,
                                            fontSize: Dimensions.font12),
                                      ),
                                      Text(
                                        '/5',
                                        style: TextStyle(
                                            color: const Color(0XFFF8C300),
                                            fontSize: Dimensions.font12),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                              const SizedBox(
                                width: 5,
                              ),
                              Text(
                                '(13 ratings)',
                                style: TextStyle(fontSize: Dimensions.font12),
                              )
                            ],
                          )
                        ],
                      ),
                    ),
                  ),
                  SizedBox(
                    width: double.maxFinite,
                    child: Container(
                      height: 1,
                      color: const Color(0XFFEDEDED),
                    ),
                  ),
                  Container(
                      padding: EdgeInsets.symmetric(horizontal: Dimensions.sizedBoxWidth10),
                      child: Column(
                        children: [
                          const ReviewBoxCon(
                              date: '14-11-2022',
                              topic: 'I love it',
                              review:
                                  'Lorem ipsum dolor sit amet, consectetur adipisicing elit. Ducimus deserunt cumque doloremque sequi facilis.',
                              name: 'David'),
                          SizedBox(
                            width: double.maxFinite,
                            child: Container(
                              height: 1,
                              color: const Color(0XFFEDEDED),
                            ),
                          ),
                          const ReviewBoxCon(
                              date: '14-11-2022',
                              topic: 'I love it',
                              review:
                                  'Lorem ipsum dolor sit amet, consectetur adipisicing elit. Ducimus deserunt cumque doloremque sequi facilis.',
                              name: 'David'),
                          SizedBox(
                            width: double.maxFinite,
                            child: Container(
                              height: 1,
                              color: const Color(0XFFEDEDED),
                            ),
                          ),
                          const ReviewBoxCon(
                              date: '14-11-2022',
                              topic: 'I love it',
                              review:
                                  'Lorem ipsum dolor sit amet, consectetur adipisicing elit. Ducimus deserunt cumque doloremque sequi facilis.',
                              name: 'David'),
                        ],
                      )),
                ],
              ),
            ),
            SizedBox(
              height: Dimensions.sizedBoxHeight10,
            )
          ],
        ),
      ),
      bottomNavigationBar: const DetailsBottomNav(),
    );
  }

  Widget _buildPageItem() {
    return Container(
      width: double.maxFinite,
      height: double.maxFinite,
      margin: EdgeInsets.all(Dimensions.sizedBoxWidth10),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(Dimensions.font25 / 5),
          color: Colors.white,
          image: const DecorationImage(
              image: AssetImage('assets/images/emptyCart.png'))),
    );
  }

  Widget _showDialog(context) {
    return Dialog(
      insetPadding: EdgeInsets.symmetric(horizontal: Dimensions.sizedBoxWidth10),
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: Dimensions.sizedBoxWidth10 * 2, vertical: Dimensions.sizedBoxHeight15),
        height: Dimensions.sizedBoxHeight230,
        decoration: BoxDecoration(
            color: Colors.white, borderRadius: BorderRadius.circular(Dimensions.font25 / 5)),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'DELIVERY DETAILS',
                  style: TextStyle(fontWeight: FontWeight.w500, fontSize: Dimensions.font17),
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
              height: Dimensions.sizedBoxHeight10 * 2,
            ),
            Text(
              'IN-CAMPUS DELIVERY',
              style: TextStyle(
                  fontWeight: FontWeight.w500,
                  fontSize: Dimensions.font14,
                  color: Colors.grey),
            ),
            SizedBox(
              height: Dimensions.sizedBoxHeight10,
            ),
            Text(
              'Delivery time starts from the time you place your order. Delivery time ranges from 30mins after order has been placed to 1hr. If you are unreachable, order will be cancelled',
              style: TextStyle(fontSize: Dimensions.font15),
            ),
            SizedBox(
              height: Dimensions.sizedBoxHeight10 * 2,
            ),
            Text(
              'DELIVERY FEE DETAILS',
              style: TextStyle(
                  fontWeight: FontWeight.w500,
                  fontSize: Dimensions.font14,
                  color: Colors.grey),
            ),
            SizedBox(
              height: Dimensions.sizedBoxHeight10,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Total Delivery Amount',
                  style: TextStyle(fontWeight: FontWeight.w600, fontSize: Dimensions.font14),
                ),
                Text(
                  '\$ 10',
                  style: TextStyle(fontWeight: FontWeight.w600, fontSize: Dimensions.font14),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
