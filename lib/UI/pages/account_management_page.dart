import 'dart:convert';

import 'package:GOCart/PROVIDERS/global_provider.dart';
import 'package:GOCart/PROVIDERS/user_provider.dart';
import 'package:GOCart/UI/routes/route_helper.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hash/hash.dart';
import 'package:provider/provider.dart';

import '../components/home_app_bar.dart';
import '../../CONSTANTS/constants.dart';
import '../utils/dimensions.dart';
import '../utils/validator.dart';
import '../widgets/head_section_widget.dart';
import '../widgets/list_tile_btn_widget.dart';

class AccountManagementPage extends StatefulWidget {
  const AccountManagementPage({super.key});

  @override
  State<AccountManagementPage> createState() => _AccountManagementPageState();
}

class _AccountManagementPageState extends State<AccountManagementPage> {
  List<TextEditingController> controllers = [];
  late TextEditingController controller;
  List<FocusNode> nodes = [];
  GlobalKey<FormState> key = GlobalKey<FormState>();

  @override
  void initState() {
    for (var i = 0; i < 6; i++) {
      controllers.add(TextEditingController());
    }

    for (var i = 0; i < 6; i++) {
      nodes.add(FocusNode());
    }
    controller = TextEditingController();

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: HomeAppBar(
        textSize: Dimensions.font24,
        title: 'Account Management',
        implyLeading: true,
        showCart: true,
      ),
      body: SingleChildScrollView(
        child: Container(
          margin: EdgeInsets.symmetric(horizontal: Dimensions.sizedBoxWidth10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const HeadSedction(
                text: 'PROFILE DETAILS',
                weight: FontWeight.w500,
              ),
              Material(
                color: Constants.white,
                borderRadius: BorderRadius.circular(Dimensions.sizedBoxWidth4),
                child: Column(
                  children: [
                    ListTileBtn(
                        page: RouteHelper.getProfilePage(),
                        title: 'Basic Details',
                        textSize: Dimensions.font14),
                    ListTileBtn(
                        onTap: () => showDialog(
                            context: context,
                            builder: (context) => _showDialog('Phone')),
                        title: 'Edit Phone Number',
                        textSize: Dimensions.font14),
                  ],
                ),
              ),
              const HeadSedction(
                text: 'SECURITY SETTINGS',
                weight: FontWeight.w500,
              ),
              Material(
                color: Constants.white,
                borderRadius: BorderRadius.circular(Dimensions.sizedBoxWidth4),
                child: Column(
                  children: [
                    ListTileBtn(
                      title: 'Use Biometrics',
                      textSize: Dimensions.font15,
                      trailing: Switch(
                          value: Provider.of<UserProvider>(context)
                              .userData[Constants.userPinIsSet],
                          activeColor: Constants.tetiary,
                          onChanged: ((value) {
                            // setState(() {
                            //   _switch = !_switch;
                            // });
                            showDialog(
                                context: context,
                                builder: (context) =>
                                    _showDialog('Biometrics'));
                          })),
                    ),
                    ListTileBtn(
                        onTap: () => showDialog(
                            context: context,
                            builder: (context) => _showDialog('Password')),
                        title: 'Change Password',
                        textSize: Dimensions.font14),
                    ListTileBtn(
                        title: 'Delete Account', textSize: Dimensions.font14),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _showPasswordD() {
    return Dialog(
      insetPadding:
          EdgeInsets.symmetric(horizontal: Dimensions.sizedBoxWidth10),
      child: Container(
        padding: EdgeInsets.all(Dimensions.sizedBoxWidth10 * 2),
        // height: Dimensions.sizedBoxHeight230,
        decoration: BoxDecoration(
            color: Constants.white,
            borderRadius: BorderRadius.circular(Dimensions.font25 / 5)),
        child: Form(
          key: key,
          child: TextFormField(
            controller: controller,
            validator: (value) => !isValidPass(value!) ? 'Invalid password combination' : null,
            obscureText: true,
            autofocus: true,
            decoration: const InputDecoration(
                labelText: 'New Password',
                helperText: 'More than 8 and at least 1 capital, 1 lowercase and 1 special characters',
                helperMaxLines: 2,
                prefix: Icon(
                  Icons.key,
                  color: Constants.grey,
                )),
            onEditingComplete: () {
              if (key.currentState!.validate()) {
                if (controller.text != '') {
                  try {
                    FirebaseAuth.instance.currentUser!
                        .updatePassword(controller.text.trim())
                        .then((value) {
                      Constants(context).snackBar(
                          'Password has been changed successfully!',
                          Constants.tetiary);

                      Navigator.pop(context);
                    });
                  } on FirebaseException catch (e) {
                    Constants(context).snackBar(e.message!, Colors.red);
                  }
                }
              }
            },
          ),
        ),
      ),
    );
  }

  Widget _showDialog(String purpose) {
    return Dialog(
      insetPadding:
          EdgeInsets.symmetric(horizontal: Dimensions.sizedBoxWidth10),
      child: Provider.of<GlobalProvider>(context).process == Processes.waiting
          ? const Center(
              child: CircularProgressIndicator(color: Constants.white),
            )
          : Container(
              padding: EdgeInsets.all(Dimensions.sizedBoxWidth10 * 2),
              // height: Dimensions.sizedBoxHeight230,
              decoration: BoxDecoration(
                  color: Constants.white,
                  borderRadius: BorderRadius.circular(Dimensions.font25 / 5)),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    purpose == 'Biometrics'
                        ? (Provider.of<UserProvider>(context, listen: false)
                                .userData[Constants.userPinIsSet]
                            ? 'Enter pin or scan fingerprint to deactivate biometrics login?'
                            : 'Add pin to be able to use biometrics to login')
                        : 'Verify your identity',
                    style: TextStyle(
                        fontSize: Dimensions.font17,
                        fontWeight: FontWeight.w500),
                  ),
                  SizedBox(
                    height: Dimensions.sizedBoxHeight10 * 2,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [0, 1, 2, 3, 4, 5].map((e) {
                      return Container(
                        width: Dimensions.sizedBoxWidth25 * 1.5,
                        height: Dimensions.sizedBoxWidth25 * 1.5,
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
                                  String pin = '';

                                  for (var element in controllers) {
                                    pin += element.text;
                                  }
                                  var b = utf8.encode(pin);
                                  List c = SHA256().update(b).digest();
                                  bool matches = const ListEquality().equals(
                                      c,
                                      Provider.of<UserProvider>(context,
                                              listen: false)
                                          .userData[Constants.userPin]);
                                          
                                  switch (purpose) {
                                    case 'Biometrics':
                                      if (Provider.of<UserProvider>(context,
                                              listen: false)
                                          .userData[Constants.userPinIsSet]) {
                                        if (matches) {
                                          Provider.of<GlobalProvider>(context,
                                                  listen: false)
                                              .setProcess(Processes.waiting);

                                          await Provider.of<UserProvider>(
                                                  context,
                                                  listen: false)
                                              .updateUserData(
                                                  {
                                                Constants.userPin: [],
                                                Constants.userPinIsSet: false
                                              },
                                                  FirebaseAuth
                                                      .instance
                                                      .currentUser!
                                                      .uid).then((value) {
                                            if (value) {
                                              Provider.of<GlobalProvider>(
                                                      context,
                                                      listen: false)
                                                  .setProcess(Processes.done);

                                              Constants(context).snackBar(
                                                  'Biometrics login has been deactivated',
                                                  Constants.tetiary);

                                              for (var element in controllers) {
                                                element.clear();
                                              }

                                              Navigator.pop(context);
                                            }
                                          });
                                        } else {
                                          Constants(context).snackBar(
                                              'Pin is incorrect', Colors.red);
                                        }
                                      } else {
                                        Provider.of<GlobalProvider>(context,
                                                listen: false)
                                            .setProcess(Processes.waiting);

                                        await Provider.of<UserProvider>(context,
                                                listen: false)
                                            .updateUserData(
                                                {
                                              Constants.userPin: c,
                                              Constants.userPinIsSet: true
                                            },
                                                FirebaseAuth
                                                    .instance
                                                    .currentUser!
                                                    .uid).then((value) {
                                          if (value) {
                                            Provider.of<GlobalProvider>(context,
                                                    listen: false)
                                                .setProcess(Processes.done);

                                            Constants(context).snackBar(
                                                'Biometrics login has been activated',
                                                Constants.tetiary);

                                            for (var element in controllers) {
                                              element.clear();
                                            }

                                            Navigator.pop(context);
                                          }
                                        });
                                      }
                                      break;

                                    case 'Phone':
                                      if (matches) {
                                        Navigator.pop(context);

                                        for (var element in controllers) {
                                          element.clear();
                                        }

                                        Get.toNamed(
                                            RouteHelper.getPhoneRegisterPage());
                                      } else {
                                        Constants(context).snackBar(
                                            'Pin is incorrect', Colors.red);
                                      }
                                      break;

                                    case 'Password':
                                      if (matches) {
                                        Navigator.pop(context);

                                        for (var element in controllers) {
                                          element.clear();
                                        }

                                        showDialog(
                                            context: context,
                                            builder: (context) =>
                                                _showPasswordD());
                                      } else {
                                        Constants(context).snackBar(
                                            'Pin is incorrect', Colors.red);
                                      }
                                      break;

                                    case 'Delete':
                                      if (matches) {
                                        Navigator.pop(context);

                                        for (var element in controllers) {
                                          element.clear();
                                        }

                                        Get.toNamed(
                                            RouteHelper.getPhoneRegisterPage());
                                      } else {
                                        Constants(context).snackBar(
                                            'Pin is incorrect', Colors.red);
                                      }
                                      break;
                                    default:
                                  }
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
                          obscureText: true,
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
                                  borderSide: const BorderSide(
                                      color: Constants.lightGrey)),
                              fillColor: Constants.white,
                              focusedBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(
                                      Dimensions.sizedBoxWidth10),
                                  borderSide:
                                      const BorderSide(color: Constants.grey))),
                        ),
                      );
                    }).toList(),
                  ),
                ],
              ),
            ),
    );
  }
}
