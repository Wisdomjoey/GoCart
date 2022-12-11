import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:GOCart/components/custom_painter.dart';
import 'package:GOCart/routes/route_helper.dart';

import '../utils/dimensions.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  bool _obscurePwd = true;

  @override
  Widget build(BuildContext context) {
    return AnnotatedRegion(
      value: const SystemUiOverlayStyle(statusBarColor: Colors.transparent),
      child: Scaffold(
        appBar: const CurvedPainter(text1: 'Hello 👋,', text2: 'Welcome'),
        backgroundColor: Colors.white,
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
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Expanded(
                            flex: 5,
                            // width: (Dimensions.screenWidth - (Dimensions.sizedBoxWidth10 * 4) - Dimensions.sizedBoxWidth10 + Dimensions.font25) / 2,
                            child: TextFormField(
                              decoration: InputDecoration(
                                  enabledBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(
                                          Dimensions.sizedBoxWidth15 * 2),
                                      borderSide: const BorderSide(
                                          color: Colors.transparent)),
                                  filled: true,
                                  labelStyle:
                                      TextStyle(fontSize: Dimensions.font15),
                                  fillColor:
                                      const Color.fromARGB(255, 242, 242, 242),
                                  contentPadding: EdgeInsets.symmetric(
                                      horizontal:
                                          Dimensions.sizedBoxWidth10 * 2),
                                  floatingLabelStyle:
                                      const TextStyle(color: Color(0XFFF8C300)),
                                  icon: const Icon(
                                    Icons.person_outline_rounded,
                                    color: Colors.grey,
                                  ),
                                  focusColor: const Color(0XFFF8C300),
                                  focusedBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(
                                          Dimensions.sizedBoxWidth15 * 2),
                                      borderSide: const BorderSide(
                                          color: Color(0XFFF8C300))),
                                  labelText: 'First Name'),
                              cursorColor: const Color(0XFFF8C300),
                            ),
                          ),
                          SizedBox(
                            width: Dimensions.sizedBoxWidth10 / 2,
                          ),
                          Expanded(
                            flex: 4,
                            // width: (Dimensions.screenWidth -
                            //         (Dimensions.sizedBoxWidth10 * 4) -
                            //         Dimensions.sizedBoxWidth10 - Dimensions.font20) /
                            //     2,
                            child: TextFormField(
                              decoration: InputDecoration(
                                  enabledBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(
                                          Dimensions.sizedBoxWidth15 * 2),
                                      borderSide: const BorderSide(
                                          color: Colors.transparent)),
                                  filled: true,
                                  labelStyle:
                                      TextStyle(fontSize: Dimensions.font15),
                                  fillColor:
                                      const Color.fromARGB(255, 242, 242, 242),
                                  contentPadding: EdgeInsets.symmetric(
                                      horizontal:
                                          Dimensions.sizedBoxWidth10 * 2),
                                  floatingLabelStyle:
                                      const TextStyle(color: Color(0XFFF8C300)),
                                  focusColor: const Color(0XFFF8C300),
                                  focusedBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(
                                          Dimensions.sizedBoxWidth15 * 2),
                                      borderSide: const BorderSide(
                                          color: Color(0XFFF8C300))),
                                  labelText: 'Second Name'),
                              cursorColor: const Color(0XFFF8C300),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: Dimensions.sizedBoxHeight10 * 2,
                      ),
                      TextFormField(
                        decoration: InputDecoration(
                            enabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(
                                    Dimensions.sizedBoxWidth15 * 2),
                                borderSide: const BorderSide(
                                    color: Colors.transparent)),
                            filled: true,
                            hintStyle: TextStyle(fontSize: Dimensions.font15),
                            labelStyle: TextStyle(fontSize: Dimensions.font15),
                            fillColor: const Color.fromARGB(255, 242, 242, 242),
                            contentPadding: EdgeInsets.symmetric(
                                horizontal: Dimensions.sizedBoxWidth10 * 2),
                            floatingLabelStyle:
                                const TextStyle(color: Color(0XFFF8C300)),
                            icon: const Icon(
                              Icons.mail_outline_rounded,
                              color: Colors.grey,
                            ),
                            focusColor: const Color(0XFFF8C300),
                            focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(
                                    Dimensions.sizedBoxWidth15 * 2),
                                borderSide:
                                    const BorderSide(color: Color(0XFFF8C300))),
                            hintText: 'example@gmail.com',
                            labelText: 'Email'),
                        cursorColor: const Color(0XFFF8C300),
                      ),
                      SizedBox(
                        height: Dimensions.sizedBoxHeight10 * 2,
                      ),
                      TextFormField(
                        obscureText: _obscurePwd,
                        decoration: InputDecoration(
                            enabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(
                                    Dimensions.sizedBoxWidth15 * 2),
                                borderSide: const BorderSide(
                                    color: Colors.transparent)),
                            filled: true,
                            labelStyle: TextStyle(fontSize: Dimensions.font15),
                            fillColor: const Color.fromARGB(255, 242, 242, 242),
                            contentPadding: EdgeInsets.symmetric(
                                horizontal: Dimensions.sizedBoxWidth10 * 2),
                            floatingLabelStyle:
                                const TextStyle(color: Color(0XFFF8C300)),
                            focusColor: const Color(0XFFF8C300),
                            icon: const Icon(
                              Icons.key,
                              color: Colors.grey,
                            ),
                            suffixIcon: GestureDetector(
                              onTap: () {
                                setState(() {
                                  _obscurePwd = !_obscurePwd;
                                });
                              },
                              child: Icon(_obscurePwd
                                  ? Icons.visibility
                                  : Icons.visibility_off),
                            ),
                            focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(
                                    Dimensions.sizedBoxWidth15 * 2),
                                borderSide:
                                    const BorderSide(color: Color(0XFFF8C300))),
                            labelText: 'Password *'),
                        cursorColor: const Color(0XFFF8C300),
                      ),
                      SizedBox(
                        height: Dimensions.sizedBoxHeight10 * 2,
                      ),
                      TextFormField(
                        obscureText: true,
                        decoration: InputDecoration(
                            enabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(
                                    Dimensions.sizedBoxWidth15 * 2),
                                borderSide: const BorderSide(
                                    color: Colors.transparent)),
                            filled: true,
                            labelStyle: TextStyle(fontSize: Dimensions.font15),
                            fillColor: const Color.fromARGB(255, 242, 242, 242),
                            contentPadding: EdgeInsets.symmetric(
                                horizontal: Dimensions.sizedBoxWidth10 * 2),
                            floatingLabelStyle:
                                const TextStyle(color: Color(0XFFF8C300)),
                            focusColor: const Color(0XFFF8C300),
                            icon: const Icon(
                              Icons.key_off_rounded,
                              color: Colors.grey,
                            ),
                            focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(
                                    Dimensions.sizedBoxWidth15 * 2),
                                borderSide:
                                    const BorderSide(color: Color(0XFFF8C300))),
                            labelText: 'Confirm Password'),
                        cursorColor: const Color(0XFFF8C300),
                      ),
                      SizedBox(
                        height: Dimensions.sizedBoxHeight100 / 2,
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
                                  Color(0XFF00923F),
                                  Color.fromARGB(255, 1, 191, 84)
                                ])),
                            child: Center(
                              child: Text(
                                'Sign Up',
                                style: TextStyle(
                                    color: Colors.white,
                                    fontSize: Dimensions.font20),
                              ),
                            ),
                          ),
                          onPressed: () {
                            Timer(const Duration(milliseconds: 100),
                                () => Get.toNamed(RouteHelper.getRoutePage(0)));
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
                                      color: const Color(0XFFF8C300),
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
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
