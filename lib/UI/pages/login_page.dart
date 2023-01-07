import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:GOCart/UI/components/custom_painter.dart';
import 'package:GOCart/UI/routes/route_helper.dart';
import 'package:GOCart/UI/utils/dimensions.dart';

import '../../CONSTANTS/constants.dart';
import '../widgets/text_form_field_widget.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  bool _obscurePwd = true;
  GlobalKey<FormState> key = GlobalKey<FormState>();

  late TextEditingController controller1;
  late TextEditingController controller2;

  late FocusNode node1;
  late FocusNode node2;

  @override
  void initState() {
    controller1 = TextEditingController();
    controller2 = TextEditingController();

    node1 = FocusNode();
    node2 = FocusNode();

    super.initState();
  }

    @override
  void dispose() {
    controller1.dispose();
    controller2.dispose();

    node1.dispose();
    node2.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnnotatedRegion(
      value: const SystemUiOverlayStyle(statusBarColor: Colors.transparent),
      child: Scaffold(
        appBar: const CurvedPainter(text1: 'Welcome', text2: 'Back 😊'),
        backgroundColor: Constants.white,
        body: NotificationListener<OverscrollIndicatorNotification>(
          onNotification: (notification) {
            notification.disallowIndicator();
            return true;
          },
          child: SingleChildScrollView(
            child: Column(
              children: [
                SizedBox(
                  height: Dimensions.sizedBoxHeight100 / 2,
                ),
                Container(
                  padding: EdgeInsets.symmetric(
                      horizontal: Dimensions.sizedBoxWidth10 * 2),
                  width: double.maxFinite,
                  child: Form(
                    key: key,
                    child: Column(
                      children: [
                        TextFormFieldWidget(
                          controller: controller1,
                          node: node1,
                          label: 'Email',
                          icon: Icon(
                            Icons.mail_outline_rounded,
                            color: Constants.grey,
                          ),
                          hint: 'example@gmail.com',
                        ),
                        // SizedBox(
                        //   height: Dimensions.sizedBoxHeight10 * 2,
                        // ),
                        TextFormFieldWidget(
                          controller: controller2,
                          node: node2,
                          label: 'Password *',
                          icon: const Icon(Icons.key, color: Constants.grey,),
                          suffix: GestureDetector(
                            onTap: () {
                              setState(() {
                                _obscurePwd = !_obscurePwd;
                              });
                            },
                            child: Icon(_obscurePwd
                                ? Icons.visibility_off
                                : Icons.visibility),
                          ),
                          obscureTxt: _obscurePwd,
                        ),
                        // SizedBox(
                        //   height: Dimensions.sizedBoxHeight100 / 2,
                        // ),
                        SizedBox(
                          width: double.maxFinite,
                          child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 0),
                                disabledForegroundColor: Colors.transparent,
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(
                                        Dimensions.sizedBoxWidth15 * 2)),
                                backgroundColor: Colors.transparent),
                            child: Ink(
                              width: double.maxFinite,
                              padding: EdgeInsets.symmetric(
                                  vertical: Dimensions.sizedBoxHeight15),
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(
                                      Dimensions.sizedBoxWidth15 * 2),
                                  gradient: const LinearGradient(colors: [
                                    Constants.secondary,
                                    Color.fromARGB(255, 1, 191, 84)
                                  ])),
                              child: Center(
                                child: Text(
                                  'Sign In',
                                  style: TextStyle(
                                      color: Constants.white,
                                      fontSize: Dimensions.font20),
                                ),
                              ),
                            ),
                            onPressed: () {
                              if (key.currentState!.validate()) {
                                // Timer(
                                //     const Duration(milliseconds: 200),
                                //     () => Get.toNamed(RouteHelper.getRoutePage(0)));
                              }
                            },
                          ),
                        ),
                        Column(
                          children: [
                            SizedBox(
                              height: Dimensions.sizedBoxHeight10 * 2,
                            ),
                            GestureDetector(
                              child: Text(
                                'Forgot Password?',
                                style: TextStyle(
                                    color:
                                        const Color.fromARGB(255, 124, 124, 124),
                                    fontSize: Dimensions.font15,
                                    decoration: TextDecoration.underline),
                              ),
                              onTap: () {},
                            ),
                            SizedBox(
                              height: Dimensions.sizedBoxHeight10 * 2,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  'Don\'t have an account?',
                                  style: TextStyle(fontSize: Dimensions.font16),
                                ),
                                SizedBox(
                                  width: Dimensions.sizedBoxWidth10 / 2,
                                ),
                                GestureDetector(
                                  child: Text(
                                    'Sign Up',
                                    style: TextStyle(
                                        fontSize: Dimensions.font18,
                                        color: Constants.tetiary,
                                        decoration: TextDecoration.underline),
                                  ),
                                  onTap: () {
                                    Get.toNamed(RouteHelper.getRegisterPage());
                                  },
                                )
                              ],
                            )
                          ],
                        )
                      ],
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
