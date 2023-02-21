import 'package:GOCart/PROVIDERS/auth_provider.dart';
import 'package:GOCart/PROVIDERS/cart_provider.dart';
import 'package:GOCart/PROVIDERS/shop_provider.dart';
import 'package:GOCart/UI/pages/local_auth_page.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:GOCart/UI/components/custom_painter.dart';
import 'package:GOCart/UI/routes/route_helper.dart';
import 'package:GOCart/UI/utils/dimensions.dart';
import 'package:provider/provider.dart';

import '../../CONSTANTS/constants.dart';
import '../../PROVIDERS/user_provider.dart';
import '../widgets/text_form_field_widget.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  bool _obscurePwd = true;
  GlobalKey<FormState> key = GlobalKey<FormState>();
  late AuthProvider authProvider;

  late TextEditingController controller1;
  late TextEditingController controller2;

  late FocusNode node1;
  late FocusNode node2;

  @override
  void initState() {
    authProvider = Provider.of<AuthProvider>(context, listen: false);

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
      value: const SystemUiOverlayStyle(
          statusBarColor: Colors.transparent,
          statusBarBrightness: Brightness.light,
          statusBarIconBrightness: Brightness.light),
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
                        SizedBox(
                          width: double.maxFinite,
                          height: Dimensions.sizedBoxHeight10 * 4,
                          child: Material(
                            color: Colors.transparent,
                            elevation: 3,
                            borderRadius: BorderRadius.circular(
                                Dimensions.sizedBoxHeight10 * 4),
                            child: InkWell(
                              onTap: () async {
                                // if (Provider.of<AuthProvider>(context,
                                //                 listen: false)
                                //             .isSigned ==
                                //         null ||
                                //     Provider.of<AuthProvider>(context,
                                //                 listen: false)
                                //             .isSigned ==
                                //         false) {
                                //   await authProvider
                                //       .googleSignin()
                                //       .then((value) {
                                //     if (value == true) {
                                //       Constants(context).snackBar(
                                //           'Sign In Succesful!',
                                //           Constants.tetiary);

                                //       Get.offNamed(RouteHelper.getRoutePage(),
                                //           arguments: 0);
                                //     } else if (value == false) {
                                //       Constants(context).snackBar(
                                //           'Sign In Failed!', Colors.red);
                                //     } else {
                                //       if (authProvider.status ==
                                //           Status.authenticateError) {
                                //         Constants(context)
                                //             .snackBar(value, Colors.red);
                                //       }
                                //     }
                                //   });
                                // } else {
                                //   await authProvider
                                //       .googleSignin1()
                                //       .then((value) {
                                //     if (value == true) {
                                //       Constants(context).snackBar(
                                //           'Sign In Succesful!',
                                //           Constants.tetiary);

                                //       Get.offNamed(RouteHelper.getRoutePage(),
                                //           arguments: 0);
                                //     } else if (value == false) {
                                //       Constants(context).snackBar(
                                //           'Sign In Failed!', Colors.red);
                                //     } else {
                                //       if (authProvider.status ==
                                //           Status.authenticateError) {
                                //         Constants(context)
                                //             .snackBar(value, Colors.red);
                                //       }
                                //     }
                                //   });
                                // }
                              },
                              borderRadius: BorderRadius.circular(
                                  Dimensions.sizedBoxHeight10 * 4),
                              child: Ink(
                                width: double.maxFinite,
                                height: Dimensions.sizedBoxHeight10 * 4,
                                padding: EdgeInsets.symmetric(
                                    horizontal: Dimensions.sizedBoxWidth10),
                                decoration: BoxDecoration(
                                    color: Constants.white,
                                    borderRadius: BorderRadius.circular(
                                        Dimensions.sizedBoxHeight10 * 4)),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Image.asset(
                                      'assets/images/google.png',
                                      width: Dimensions.sizedBoxWidth15 * 2,
                                    ),
                                    const Text('Sign In With Google'),
                                    const Icon(Icons.arrow_forward)
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ),
                        SizedBox(
                          height: Dimensions.sizedBoxHeight15 * 2,
                        ),
                        TextFormFieldWidget(
                          controller: controller1,
                          node: node1,
                          label: 'Email',
                          icon: const Icon(
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
                          icon: const Icon(
                            Icons.key,
                            color: Constants.grey,
                          ),
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
                        SizedBox(
                          height: Dimensions.sizedBoxHeight15 * 2,
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
                                child: Provider.of<AuthProvider>(context,
                                                listen: true)
                                            .status ==
                                        Status.authenticating
                                    ? SizedBox(
                                        width: Dimensions.sizedBoxWidth10 * 2,
                                        height: Dimensions.sizedBoxWidth10 * 2,
                                        child: const CircularProgressIndicator(
                                          color: Constants.white,
                                          strokeWidth: 3,
                                        ))
                                    : Text(
                                        'Sign In',
                                        style: TextStyle(
                                            color: Constants.white,
                                            fontSize: Dimensions.font20),
                                      ),
                              ),
                            ),
                            onPressed: () async {
                              User? user = FirebaseAuth.instance.currentUser;

                              if (user != null) {
                                Constants(context).snackBar(
                                    'You are logged in already',
                                    Constants.tetiary);

                                Get.offNamed(RouteHelper.getRoutePage(),
                                    arguments: 0);
                              } else {
                                if (key.currentState!.validate()) {
                                  // Timer(
                                  //     const Duration(milliseconds: 200),
                                  //     () => Get.toNamed(RouteHelper.getRoutePage(0)));
                                  await Provider.of<AuthProvider>(context,
                                          listen: false)
                                      .loginWithEmailAndPass(
                                          controller1.text.trim(),
                                          controller2.text,
                                          context)
                                      .then((value) async {
                                    if (value == true &&
                                        authProvider.status ==
                                            Status.authenticated) {
                                      await Provider.of<CartProvider>(context,
                                              listen: false)
                                          .initializeCart(FirebaseAuth
                                              .instance.currentUser!.uid)
                                          .whenComplete(() async {
                                        await Provider.of<ShopProvider>(context,
                                                listen: false)
                                            .fetchAllShops()
                                            .whenComplete(() async {
                                          await Provider.of<UserProvider>(
                                                  context,
                                                  listen: false)
                                              .initializeUserData(FirebaseAuth
                                                  .instance.currentUser!.uid)
                                              .then((value) {
                                            Constants(context).snackBar(
                                                'Sign In Succesful!',
                                                Constants.tetiary);

                                            if (Provider.of<UserProvider>(
                                                        context,
                                                        listen: false)
                                                    .userData[
                                                Constants.userPinIsSet]) {
                                              Get.off(
                                                  () => const LocalAuthPage());
                                            } else {
                                              Get.offNamed(
                                                  RouteHelper.getRoutePage(),
                                                  arguments: 0);
                                            }
                                          });
                                        });
                                      });
                                    } else if (value == false) {
                                      Constants(context).snackBar(
                                          'An error occurred', Colors.red);
                                    } else {
                                      Constants(context)
                                          .snackBar('$value', Colors.red);
                                    }
                                  });
                                }
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
                                    color: const Color.fromARGB(
                                        255, 124, 124, 124),
                                    fontSize: Dimensions.font15,
                                    decoration: TextDecoration.underline),
                              ),
                              onTap: () => Get.toNamed(
                                  RouteHelper.getPasswordResetPage()),
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
