import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_multi_formatter/flutter_multi_formatter.dart';
import 'package:get/get.dart';

import '../../CONSTANTS/constants.dart';
import '../routes/route_helper.dart';
import '../utils/dimensions.dart';

class PhoneRegisterPage extends StatelessWidget {
  PhoneRegisterPage({super.key});

  GlobalKey<FormState> _key = GlobalKey<FormState>();

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
              padding:
                  EdgeInsets.only(bottom: Dimensions.sizedBoxHeight10 * 2),
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
                                image: AssetImage('assets/images/OTP.png'),
                                fit: BoxFit.contain)),
                      ),
                      SizedBox(
                        height: Dimensions.sizedBoxHeight100 / 2,
                      ),
                      Row(
                        children: [
                          SizedBox(
                            width: Dimensions.sizedBoxWidth10 * 7,
                            child: TextFormField(
                              onEditingComplete: () {
                                Timer(
                                    const Duration(milliseconds: 200),
                                    () =>
                                        Get.toNamed(RouteHelper.getPhoneAuthPage()));
                              },
                              enabled: false,
                              initialValue: '+234',
                              style: const TextStyle(color: Constants.grey),
                              textAlign: TextAlign.center,
                              decoration: const InputDecoration(
                                  fillColor: Constants.formFillColor,
                                  filled: true,
                                  disabledBorder: OutlineInputBorder(
                                    borderSide: BorderSide.none,
                                  ),
                                  helperText: ''),
                            ),
                          ),
                          SizedBox(
                            width: Dimensions.sizedBoxWidth10,
                          ),
                          Expanded(
                            child: Form(
                              key: _key,
                              child: TextFormField(
                                validator: (value) {
                                  if (value == '') {
                                    return Constants.err;
                                  } else {
                                    return null;
                                  }
                                },
                                autofocus: true,
                                decoration: const InputDecoration(
                                    labelText: 'Enter phone number',
                                    hintText: 'e.g. 8012382131',
                                    hintStyle: TextStyle(
                                        color: Color.fromARGB(255, 188, 188, 188)),
                                    helperText: 'ommit the first number (0)'),
                                keyboardType: TextInputType.phone,
                                inputFormatters: [
                                  MaskedInputFormatter('### #### ###')
                                ],
                                //   onChanged: (value) => print(value.replaceAll(RegExp(r' '), '')),
                              ),
                            ),
                          )
                        ],
                      ),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
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
                      ),
                      GestureDetector(
                        onTap: () {
                          if (_key.currentState!.validate()) {
                            Timer(const Duration(milliseconds: 200),
                                () => Get.toNamed(RouteHelper.getPhoneAuthPage()));
                          }
                        },
                        child: Row(
                          children: [
                            Text(
                              'Continue',
                              style: TextStyle(fontSize: Dimensions.font17),
                            ),
                            SizedBox(
                              width: Dimensions.sizedBoxWidth10 / 2,
                            ),
                            const Icon(Icons.arrow_circle_right_outlined),
                          ],
                        ),
                      ),
                    ],
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
