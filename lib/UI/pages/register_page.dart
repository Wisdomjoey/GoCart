import 'dart:async';

import 'package:GOCart/UI/utils/validator.dart';
import 'package:GOCart/UI/widgets/text_form_field_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:GOCart/UI/components/custom_painter.dart';
import 'package:GOCart/UI/routes/route_helper.dart';

import '../constants/constants.dart';
import '../utils/dimensions.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  bool _obscurePwd = true;
  bool _checkBox = false;
  GlobalKey<FormState> key = GlobalKey<FormState>();

  late TextEditingController controller1;
  late TextEditingController controller2;
  late TextEditingController controller3;
  late TextEditingController controller4;
  late TextEditingController controller5;

  late FocusNode node1;
  late FocusNode node2;
  late FocusNode node3;
  late FocusNode node4;
  late FocusNode node5;

  @override
  void initState() {
    controller1 = TextEditingController();
    controller2 = TextEditingController();
    controller3 = TextEditingController();
    controller4 = TextEditingController();
    controller5 = TextEditingController();

    node1 = FocusNode();
    node2 = FocusNode();
    node3 = FocusNode();
    node4 = FocusNode();
    node5 = FocusNode();

    super.initState();
  }

  @override
  void dispose() {
    controller1.dispose();
    controller2.dispose();
    controller3.dispose();
    controller4.dispose();
    controller5.dispose();

    node1.dispose();
    node2.dispose();
    node3.dispose();
    node4.dispose();
    node5.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnnotatedRegion(
      value: const SystemUiOverlayStyle(statusBarColor: Colors.transparent),
      child: Scaffold(
        appBar: const CurvedPainter(text1: 'Hello 👋,', text2: 'Welcome'),
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
                  height: Dimensions.sizedBoxHeight15 * 2,
                ),
                Container(
                  padding: EdgeInsets.symmetric(
                      horizontal: Dimensions.sizedBoxWidth10 * 2),
                  width: double.maxFinite,
                  child: Form(
                    key: key,
                    child: Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Expanded(
                              flex: 5,
                              child: TextFormFieldWidget(
                                node: node1,
                                controller: controller1,
                                label: 'First Name',
                                icon: const Icon(
                                  Icons.person_outline,
                                  color: Constants.grey,
                                ),
                              ),
                            ),
                            SizedBox(
                              width: Dimensions.sizedBoxWidth10 / 2,
                            ),
                            Expanded(
                              flex: 4,
                              child: TextFormFieldWidget(
                                label: 'Second Name',
                                node: node2,
                                controller: controller2,
                              ),
                            ),
                          ],
                        ),
                        TextFormFieldWidget(
                          node: node3,
                          controller: controller3,
                          label: 'Email',
                          icon: const Icon(
                            Icons.mail_outline_rounded,
                            color: Constants.grey,
                          ),
                          hint: 'example@gmail.com',
                          error: 'Enter a valid email',
                          val: () => isValidEmail(controller3.text),
                        ),
                        TextFormFieldWidget(
                          node: node4,
                          controller: controller4,
                          label: 'Password *',
                          icon: const Icon(
                            Icons.key,
                            color: Constants.grey,
                          ),
                          help:
                              'More than 8 and at least 1 capital, 1 lowercase and 1 special characters',
                          error: 'Invalid password',
                          helpMax: 2,
                          val: () => isValidPass(controller4.text),
                          val2: () => isPassEqual(controller4.text, controller5.text),
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
                        TextFormFieldWidget(
                          node: node5,
                          controller: controller5,
                          label: 'Confirm Password',
                          error: 'Passwords do not match',
                          obscureTxt: true,
                          val: () =>
                              isPassEqual(controller4.text, controller5.text),
                          icon: const Icon(
                            Icons.key_off,
                            color: Constants.grey,
                          ),
                        ),
                        Row(
                          children: [
                            Checkbox(
                                value: _checkBox,
                                onChanged: ((value) {
                                  if (value != null) {
                                    setState(() {
                                      _checkBox = value;
                                    });
                                  }
                                })),
                            Text(
                              'Are you a seller? If so check this box.',
                              style: TextStyle(fontSize: Dimensions.font12),
                            )
                          ],
                        ),
                        SizedBox(
                          height: Dimensions.sizedBoxHeight10 * 2,
                        ),
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
                                  'Sign Up',
                                  style: TextStyle(
                                      color: Constants.white,
                                      fontSize: Dimensions.font20),
                                ),
                              ),
                            ),
                            onPressed: () {
                              // if (key.currentState!.validate()) {
                                Timer(
                                    const Duration(milliseconds: 200),
                                    () => Get.toNamed(_checkBox
                                        ? RouteHelper.getShopRegisterPage()
                                        : RouteHelper.getRoutePage(0)));
                              // }
                            },
                          ),
                        ),
                        Column(
                          children: [
                            SizedBox(
                              height: Dimensions.sizedBoxHeight10 * 2,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  'Already have an account?',
                                  style: TextStyle(fontSize: Dimensions.font16),
                                ),
                                SizedBox(
                                  width: Dimensions.sizedBoxWidth10 / 2,
                                ),
                                GestureDetector(
                                  child: Text(
                                    'Sign In',
                                    style: TextStyle(
                                        fontSize: Dimensions.font18,
                                        color: Constants.tetiary,
                                        decoration: TextDecoration.underline),
                                  ),
                                  onTap: () {
                                    Get.toNamed(RouteHelper.getLoginPage());
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
