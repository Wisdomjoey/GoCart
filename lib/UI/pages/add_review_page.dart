import 'package:GOCart/CONSTANTS/constants.dart';
import 'package:GOCart/PROVIDERS/global_provider.dart';
import 'package:GOCart/PROVIDERS/product_provider.dart';
import 'package:GOCart/UI/components/home_app_bar.dart';
import 'package:GOCart/UI/utils/dimensions.dart';
import 'package:GOCart/UI/widgets/head_section_widget.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../widgets/elevated_button_widget.dart';

class AddReviewPage extends StatefulWidget {
  final Map<String, dynamic> prodData;

  const AddReviewPage({super.key, required this.prodData});

  @override
  State<AddReviewPage> createState() => _AddReviewPageState();
}

class _AddReviewPageState extends State<AddReviewPage> {
  int anchor = 0;
  GlobalKey<FormState> key = GlobalKey<FormState>();
  late TextEditingController controller1;
  late TextEditingController controller2;
  late TextEditingController controller3;

  @override
  void initState() {
    controller1 = TextEditingController();
    controller2 = TextEditingController();
    controller3 = TextEditingController();

    super.initState();
  }

  @override
  void dispose() {
    controller1.clear();
    controller2.clear();
    controller3.clear();

    controller1.dispose();
    controller2.dispose();
    controller3.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: HomeAppBar(
        title: 'Add Review',
        showCart: true,
        implyLeading: true,
        textSize: Dimensions.font24,
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: EdgeInsets.symmetric(
                  horizontal: Dimensions.sizedBoxWidth4 * 2),
              child: const HeadSedction(text: 'ADD A RATING TO THIS PRODUCT'),
            ),
            SizedBox(
              height: Dimensions.sizedBoxHeight10,
            ),
            Container(
              padding: EdgeInsets.all(Dimensions.sizedBoxWidth10),
              margin:
                  EdgeInsets.symmetric(horizontal: Dimensions.sizedBoxWidth10),
              decoration: BoxDecoration(
                  borderRadius:
                      BorderRadius.circular(Dimensions.sizedBoxWidth4),
                  color: Constants.white),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(
                    height: Dimensions.sizedBoxHeight10,
                  ),
                  const Text(
                    'Adding a rating helps improve a seller\'s sales and help provide feedback for needed improvement',
                    style: TextStyle(color: Constants.grey),
                    textAlign: TextAlign.center,
                  ),
                  SizedBox(
                    height: Dimensions.sizedBoxHeight10 * 3,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [1, 2, 3, 4, 5].map((e) {
                      return IconButton(
                          onPressed: (() {
                            setState(() {
                              anchor = e;
                            });
                          }),
                          tooltip: e.toString(),
                          icon: Icon(
                            Icons.star,
                            color: e <= anchor
                                ? Constants.tetiary
                                : const Color.fromARGB(255, 194, 194, 194),
                            size: Dimensions.font19 * 2,
                          ));
                    }).toList(),
                  ),
                  SizedBox(
                    height: Dimensions.sizedBoxHeight10 * 3,
                  ),
                ],
              ),
            ),
            Padding(
              padding: EdgeInsets.all(Dimensions.sizedBoxWidth4 * 2),
              child:
                  const HeadSedction(text: 'UPLOAD A REVIEW FOR THIS PRODUCT'),
            ),
            Container(
              padding: EdgeInsets.all(Dimensions.sizedBoxWidth10),
              margin:
                  EdgeInsets.symmetric(horizontal: Dimensions.sizedBoxWidth10),
              decoration: BoxDecoration(
                  borderRadius:
                      BorderRadius.circular(Dimensions.sizedBoxWidth4),
                  color: Constants.white),
              child: Form(
                key: key,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    TextFormField(
                      controller: controller1,
                      validator: (value) {
                        if (value == '') {
                          return 'Field connot be empty';
                        } else {
                          return null;
                        }
                      },
                      decoration: InputDecoration(
                          labelText: 'Name',
                          border: OutlineInputBorder(
                              borderSide:
                                  const BorderSide(color: Constants.grey),
                              borderRadius: BorderRadius.all(
                                  Radius.circular(Dimensions.sizedBoxWidth4)))),
                    ),
                    SizedBox(
                      height: Dimensions.sizedBoxHeight10,
                    ),
                    TextFormField(
                      controller: controller2,
                      validator: (value) {
                        if (value == '') {
                          return 'Field connot be empty';
                        } else {
                          return null;
                        }
                      },
                      decoration: InputDecoration(
                          labelText: 'Title',
                          border: OutlineInputBorder(
                              borderSide:
                                  const BorderSide(color: Constants.grey),
                              borderRadius: BorderRadius.all(
                                  Radius.circular(Dimensions.sizedBoxWidth4)))),
                    ),
                    SizedBox(
                      height: Dimensions.sizedBoxHeight10,
                    ),
                    TextFormField(
                      controller: controller3,
                      validator: (value) {
                        if (value == '') {
                          return 'Field connot be empty';
                        } else {
                          return null;
                        }
                      },
                      maxLines: 3,
                      decoration: InputDecoration(
                          labelText: 'Body',
                          border: OutlineInputBorder(
                              borderSide:
                                  const BorderSide(color: Constants.grey),
                              borderRadius: BorderRadius.all(
                                  Radius.circular(Dimensions.sizedBoxWidth4)))),
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(
              height: Dimensions.sizedBoxHeight15,
            ),
            Padding(
              padding: EdgeInsets.all(Dimensions.sizedBoxWidth4 * 2),
              child: SizedBox(
                width: double.maxFinite,
                height: Dimensions.sizedBoxHeight100 / 2,
                child: ElevatedBtn(
                  pressed: () async {
                    if (key.currentState!.validate()) {
                      Provider.of<GlobalProvider>(context, listen: false)
                          .setProcess(Processes.waiting);

                      await Provider.of<ProductProvider>(context, listen: false)
                          .fetchAllReviews(widget.prodData[Constants.productId])
                          .then((value) async {
                        int rate = 0;

                        for (var element in value) {
                          rate += element[Constants.reviewStarNo] as int;
                        }
                        double rating = rate / value.length;

                        await Provider.of<ProductProvider>(context,
                                listen: false)
                            .uploadReview(
                                widget.prodData[Constants.productId],
                                controller1.text.trim(),
                                controller2.text.trim(),
                                controller3.text.trim(),
                                anchor,
                                value.isEmpty ? null : rating)
                            .then((value1) async {
                          if (value1) {
                            Provider.of<GlobalProvider>(context, listen: false)
                                .setProcess(Processes.done);

                            Navigator.pop(context);
                          }
                        });
                      });
                    }
                  },
                  text: 'Upload Review',
                  disabled: Provider.of<GlobalProvider>(context).process ==
                          Processes.waiting
                      ? true
                      : false,
                  child: Provider.of<GlobalProvider>(context).process ==
                          Processes.waiting
                      ? SizedBox(
                          width: Dimensions.sizedBoxWidth10 * 2,
                          height: Dimensions.sizedBoxWidth10 * 2,
                          child: const CircularProgressIndicator(
                            color: Constants.white,
                            strokeWidth: 3,
                          ))
                      : Text(
                          'Upload Review',
                          style: TextStyle(
                              color: Constants.white,
                              fontSize: Dimensions.font14),
                        ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
