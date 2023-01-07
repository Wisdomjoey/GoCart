import 'dart:async';

import 'package:GOCart/UI/routes/route_helper.dart';
import 'package:GOCart/UI/utils/dimensions.dart';
import 'package:GOCart/UI/widgets/elevated_button_widget.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../CONSTANTS/constants.dart';

class IntroPage extends StatelessWidget {
  const IntroPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(children: [
        Container(
          width: double.maxFinite,
          height: double.maxFinite,
          decoration: const BoxDecoration(
              image: DecorationImage(
                  image: AssetImage('assets/images/intro.png'),
                  fit: BoxFit.cover)),
        ),
        Container(
          width: double.maxFinite,
          height: double.maxFinite,
          color: const Color.fromARGB(43, 0, 0, 0),
          padding:
              EdgeInsets.symmetric(vertical: Dimensions.sizedBoxHeight100 / 2),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(''),
              Container(
                padding: EdgeInsets.symmetric(
                    horizontal: Dimensions.sizedBoxWidth10 * 2),
                width: double.maxFinite,
                child: Column(
                  children: [
                    Text(
                      'Welcome to GOCART, a YabaTech sales app meant for sellers within Yaba College vicinity. You can buy and sell to students, lecturers and everyone within the school. Thank you for using our app 😊.',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          color: Constants.white,
                          letterSpacing: Dimensions.sizedBoxWidth3 / 2,
                          // wordSpacing: Dimensions.sizedBoxWidth3,
                          height: Dimensions.sizedBoxHeight3 / 2,
                          fontWeight: FontWeight.w500,
                          fontSize: Dimensions.font14),
                    ),
                    SizedBox(
                      height: Dimensions.sizedBoxHeight10 * 3,
                    ),
                    SizedBox(
                      width: double.maxFinite,
                      height: Dimensions.sizedBoxHeight100 / 2,
                      child: ElevatedBtn(
                        text: 'CONTINUE',
                        radius: Dimensions.sizedBoxWidth100 / 2,
                        pressed: () {
                          Timer(
                              const Duration(milliseconds: 200),
                              (() =>
                                  Get.toNamed(RouteHelper.getRegisterPage())));
                        },
                      ),
                    )
                  ],
                ),
              ),
            ],
          ),
        )
      ]),
    );
  }
}
