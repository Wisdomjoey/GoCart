import 'package:flutter/material.dart';
import 'package:GOCart/components/home_app_bar.dart';
import 'package:GOCart/utils/dimensions.dart';

class DetailsPage extends StatefulWidget {
  const DetailsPage({super.key});

  @override
  State<DetailsPage> createState() => _DetailsPageState();
}

class _DetailsPageState extends State<DetailsPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: HomeAppBar(
        title: 'Product Details',
        textSize: Dimensions.font23,
        implyLeading: true,
        showPopUp: true,
        showCart: true,
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              width: double.maxFinite,
              color: Colors.white,
              margin: EdgeInsets.only(top: Dimensions.sizedBoxHeight10),
              padding: EdgeInsets.all(Dimensions.sizedBoxWidth10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Description',
                    style: TextStyle(fontWeight: FontWeight.w600),
                  ),
                  SizedBox(
                    height: Dimensions.sizedBoxHeight10,
                  ),
                  Text(
                    'Lorem ipsum dolor sit amet, consectetur adipisicing elit. Ducimus deserunt cumque doloremque sequi facilis, ipsum quae atque vero repellat molestiae ipsam delectus ratione pariatur totam officia minima animi accusantium veritatis.',
                    style: TextStyle(fontSize: Dimensions.font12),
                  ),
                ],
              ),
            ),
            Container(
              width: double.maxFinite,
              decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius:
                      BorderRadius.circular(Dimensions.sizedBoxWidth4)),
              margin: EdgeInsets.all(Dimensions.sizedBoxWidth10),
              padding: EdgeInsets.all(Dimensions.sizedBoxWidth10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Key Features',
                    style: TextStyle(fontWeight: FontWeight.w600),
                  ),
                  SizedBox(
                    height: Dimensions.sizedBoxHeight10,
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [1, 2, 3, 4, 5]
                        .map((e) => Text(
                              '- Test',
                              style: TextStyle(fontSize: Dimensions.font12),
                            ))
                        .toList(),
                  )
                ],
              ),
            ),
            Container(
              width: double.maxFinite,
              decoration: BoxDecoration(
                  color: Colors.white, borderRadius: BorderRadius.circular(4)),
              margin:
                  EdgeInsets.symmetric(horizontal: Dimensions.sizedBoxWidth10),
              padding: EdgeInsets.all(Dimensions.sizedBoxWidth10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Specifications',
                    style: TextStyle(fontWeight: FontWeight.w600),
                  ),
                  SizedBox(
                    height: Dimensions.sizedBoxHeight10,
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [1, 2, 3, 4, 5]
                        .map((e) => (Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  children: [
                                    Text(
                                      'H23:',
                                      style: TextStyle(
                                          fontSize: Dimensions.font12,
                                          fontWeight: FontWeight.w500),
                                    ),
                                    SizedBox(
                                      width: Dimensions.sizedBoxWidth10,
                                    ),
                                    Text(
                                      'Something',
                                      style: TextStyle(
                                          fontSize: Dimensions.font12),
                                    )
                                  ],
                                ),
                                SizedBox(
                                  height: Dimensions.sizedBoxHeight10 / 2,
                                )
                              ],
                            )))
                        .toList(),
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
