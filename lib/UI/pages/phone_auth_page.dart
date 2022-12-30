import 'package:GOCart/UI/utils/dimensions.dart';
import 'package:flutter/material.dart';

import '../constants/constants.dart';

class PhoneAuthPage extends StatefulWidget {
  const PhoneAuthPage({super.key});

  @override
  State<PhoneAuthPage> createState() => _PhoneAuthPageState();
}

class _PhoneAuthPageState extends State<PhoneAuthPage> {
  List<TextEditingController> controllers = [];
  List<FocusNode> nodes = [];

  @override
  void initState() {
    for (var i = 0; i < 6; i++) {
      controllers.add(TextEditingController());
    }

    for (var i = 0; i < 6; i++) {
      nodes.add(FocusNode());
    }

    // for (var i = 0; i < 6; i++) {
    //   controllers[i].addListener(() {

    //   });
    // }

    super.initState();
  }

  @override
  void dispose() {
    for (var i = 0; i < 6; i++) {
      controllers[i].dispose();
    }

    for (var i = 0; i < 6; i++) {
      nodes[i].dispose();
    }

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Constants.white,
      body: CustomScrollView(
        slivers: [
          SliverFillRemaining(
            child: Container(
              margin: EdgeInsets.symmetric(
                  horizontal: Dimensions.sizedBoxWidth10 * 2),
              padding: EdgeInsets.only(bottom: Dimensions.sizedBoxHeight10 * 2),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    children: [
                      Container(
                        width: Dimensions.sizedBoxWidth100 * 2.5,
                        height: Dimensions.sizedBoxWidth100 * 2.5,
                        margin: EdgeInsets.only(
                            top: Dimensions.sizedBoxHeight15 * 5,
                            bottom: Dimensions.sizedBoxHeight10 * 4),
                        decoration: const BoxDecoration(
                            image: DecorationImage(
                                image: AssetImage('assets/images/Security.png'),
                                fit: BoxFit.contain)),
                      ),
                      Text(
                        'An OTP code has been sent to this phone number +23497236137',
                        style: TextStyle(
                            color: const Color.fromARGB(255, 91, 91, 91),
                            fontSize: Dimensions.font14),
                      ),
                      SizedBox(
                        height: Dimensions.sizedBoxHeight10 * 2,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [0, 1, 2, 3, 4, 5].map((e) {
                          return Container(
                            width: Dimensions.sizedBoxWidth25 * 1.7,
                            height: Dimensions.sizedBoxWidth25 * 1.7,
                            margin: EdgeInsets.only(
                                right:
                                    e < 4 ? Dimensions.sizedBoxWidth10 / 2 : 0,
                                left: e == 5
                                    ? Dimensions.sizedBoxWidth10 / 2
                                    : 0),
                            child: TextFormField(
                              controller: controllers[e],
                              focusNode: nodes[e],
                              onChanged: (value) {
                                if (value != '') {
                                  if (value.length > 1) {
                                    for (var i = 0; i < 6; i++) {
                                      controllers[i].text = value[i];
                                    }
                                    nodes[e].unfocus();
                                  } else {
                                    if (e != 5) {
                                      nodes[e].nextFocus();
                                    } else {
                                      nodes[e].unfocus();
                                    }
                                  }
                                } else {
                                  if (e != 0) {
                                    nodes[e].previousFocus();
                                  } else {
                                    nodes[e].unfocus();
                                  }
                                }
                              },
                              showCursor: false,
                              textAlign: TextAlign.center,
                              autofocus: e == 0 ? true : false,
                              style: TextStyle(
                                  fontWeight: FontWeight.w500,
                                  fontSize: Dimensions.font23,
                                  color:
                                      const Color.fromARGB(255, 116, 116, 116)),
                              keyboardType: TextInputType.number,
                              decoration: InputDecoration(
                                  contentPadding: const EdgeInsets.all(10),
                                  filled: true,
                                  border: InputBorder.none,
                                  enabledBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(
                                          Dimensions.sizedBoxWidth10),
                                      borderSide: const BorderSide(
                                          color: Constants.grey)),
                                  fillColor: Constants.lightGrey,
                                  focusedBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(
                                          Dimensions.sizedBoxWidth10),
                                      borderSide: const BorderSide(
                                          color: Constants.tetiary))),
                            ),
                          );
                        }).toList(),
                      ),
                      SizedBox(
                        height: Dimensions.sizedBoxHeight10 * 2,
                      ),
                      Text(
                        'Retry in 56s',
                        style: TextStyle(fontSize: Dimensions.font14),
                      ),
                    ],
                  ),
                  GestureDetector(
                    onTap: () => Navigator.pop(context),
                    child: Row(
                      children: [
                        const Icon(Icons.arrow_circle_left_outlined),
                        SizedBox(
                          width: Dimensions.sizedBoxWidth10 / 2,
                        ),
                        Text(
                          'Back',
                          style: TextStyle(fontSize: Dimensions.font17),
                        )
                      ],
                    ),
                  )
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
