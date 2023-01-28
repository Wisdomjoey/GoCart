import 'dart:async';

import 'package:GOCart/PROVIDERS/auth_provider.dart';
import 'package:GOCart/UI/utils/dimensions.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../CONSTANTS/constants.dart';

class PhoneAuthPage extends StatefulWidget {
  final String phoneNumber;

  const PhoneAuthPage({super.key, required this.phoneNumber});

  @override
  State<PhoneAuthPage> createState() => _PhoneAuthPageState();
}

class _PhoneAuthPageState extends State<PhoneAuthPage> {
  List<TextEditingController> controllers = [];
  List<FocusNode> nodes = [];
  int timer = 60;
  bool timeUp = false;
  Timer? countdown;

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

    // countdown!.cancel();
    super.dispose();
  }

  // start() {
  //   setState(() {
  //     countdown = Timer.periodic(Duration(seconds: 1), (ticker) {
  //       if (timer < 1) {
  //         setState(() {
  //           timeUp = true;
  //           ticker.cancel();
  //         });
  //       } else {
  //         setState(() {
  //           timer--;
  //         });
  //       }
  //       print('object');
  //     });
  //   });
  // }

  @override
  Widget build(BuildContext context) {
    Provider.of<AuthProvider>(context, listen: false)
        .verifyPhoneNumber(context, widget.phoneNumber);
    // Future.delayed(Duration.zero, (() => start()));

    return Scaffold(
      backgroundColor: Constants.white,
      body: SingleChildScrollView(
        child: Container(
          margin:
              EdgeInsets.symmetric(horizontal: Dimensions.sizedBoxWidth10 * 2),
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
                    'An OTP code has been sent to this phone number +234${widget.phoneNumber}',
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
                            right: e < 4 ? Dimensions.sizedBoxWidth10 / 2 : 0,
                            left: e == 5 ? Dimensions.sizedBoxWidth10 / 2 : 0),
                        child: TextFormField(
                          controller: controllers[e],
                          focusNode: nodes[e],
                          onTap: () {
                            if (e != 0) {
                              if (controllers[e - 1].text == '') {
                                nodes[e].unfocus();
                              } else {
                                nodes[e].requestFocus();
                              }
                            } else {
                              nodes[e].requestFocus();
                            }
                          },
                          onChanged: (value) async {
                            if (value != '') {
                              if (value.length > 1) {
                                for (var i = 0; i < value.length; i++) {
                                  controllers[i].text = value[i];
                                }
                                nodes[e].unfocus();
                              } else {
                                if (e != 5) {
                                  nodes[e].nextFocus();
                                } else {
                                  String otp = '';

                                  for (var element in controllers) {
                                    otp += element.text;
                                  }

                                  await Provider.of<AuthProvider>(context,
                                          listen: false)
                                      .submitOtp(
                                          context, otp, widget.phoneNumber)
                                      .then((value) async {
                                    nodes[e].unfocus();
                                    for (var element in controllers) {
                                      element.clear();
                                    }
                                  });
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
                              color: const Color.fromARGB(255, 116, 116, 116)),
                          keyboardType: TextInputType.number,
                          decoration: InputDecoration(
                              contentPadding: const EdgeInsets.all(10),
                              filled: true,
                              border: InputBorder.none,
                              enabledBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(
                                      Dimensions.sizedBoxWidth10),
                                  borderSide:
                                      const BorderSide(color: Constants.grey)),
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
                    'Retry in ${timer}s',
                    style: TextStyle(
                        fontSize: Dimensions.font14,
                        color: timeUp ? Constants.tetiary : Colors.black,
                        decoration: timeUp
                            ? TextDecoration.underline
                            : TextDecoration.none),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: Container(
        margin:
            EdgeInsets.symmetric(horizontal: Dimensions.sizedBoxWidth10 * 2),
        padding: EdgeInsets.only(bottom: Dimensions.sizedBoxHeight10 * 2),
        child: GestureDetector(
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
        ),
      ),
    );
  }
}
