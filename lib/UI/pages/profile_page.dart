import 'package:GOCart/PROVIDERS/global_provider.dart';
import 'package:GOCart/PROVIDERS/user_provider.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';

import '../../CONSTANTS/constants.dart';
import '../utils/dimensions.dart';
import '../widgets/elevated_button_widget.dart';
import '../widgets/head_section_widget.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  GlobalKey<FormState> key = GlobalKey<FormState>();

  List<bool> disability = [false, false, false];
  bool anchor = true;

  late TextEditingController textEditingController1;
  late TextEditingController textEditingController2;
  late TextEditingController textEditingController3;

  late FocusNode focusNode1;
  late FocusNode focusNode2;
  late FocusNode focusNode3;

  @override
  void initState() {
    textEditingController1 = TextEditingController();
    textEditingController2 = TextEditingController();
    textEditingController3 = TextEditingController();

    focusNode1 = FocusNode();
    focusNode2 = FocusNode();
    focusNode3 = FocusNode();

    super.initState();
  }

  @override
  void dispose() {
    textEditingController1.dispose();
    textEditingController2.dispose();
    textEditingController3.dispose();

    focusNode1.dispose();
    focusNode2.dispose();
    focusNode3.dispose();

    super.dispose();
  }

  // chageFocus(FocusNode focusNode) {
  //   focusNode.requestFocus();
  // }

  @override
  Widget build(BuildContext context) {
    if (anchor) {
      anchor = false;
      
      textEditingController1.text =
          Provider.of<UserProvider>(context).userData[Constants.userUserName];
      textEditingController2.text =
          Provider.of<UserProvider>(context).userData[Constants.userFirstName];
      textEditingController3.text =
          Provider.of<UserProvider>(context).userData[Constants.userLastName];
    }

    return Scaffold(
      backgroundColor: Constants.white,
      appBar: AppBar(
        title: Text(
          'Personal Details',
          style: TextStyle(fontSize: Dimensions.font23),
        ),
        backgroundColor: Constants.secondary,
        systemOverlayStyle: const SystemUiOverlayStyle(
            statusBarColor: Color.fromARGB(84, 0, 146, 63),
            statusBarBrightness: Brightness.light,
            statusBarIconBrightness: Brightness.light),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(Dimensions.sizedBoxWidth15),
          child: Form(
            key: key,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    HeadSedction(
                      text: 'Username',
                      tMargin: Dimensions.sizedBoxHeight15 * 2,
                      textSize: Dimensions.font16,
                    ),
                    IconButton(
                        onPressed: (() {
                          setState(() {
                            disability[0] = true;
                          });
                        }),
                        icon: const Icon(
                          Icons.edit,
                          size: 20,
                          color: Constants.tetiary,
                        ))
                  ],
                ),
                SizedBox(
                  height: Dimensions.sizedBoxHeight10 / 2,
                ),
                TextFormField(
                  controller: textEditingController1,
                  focusNode: focusNode1,
                  // validator: (value) {
                  //   if (value == '') {
                  //     return Constants.err;
                  //   }

                  //   return null;
                  // },
                  decoration: InputDecoration(
                    enabled: disability[0],
                    filled: true,
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    HeadSedction(
                      text: 'First Name',
                      tMargin: Dimensions.sizedBoxHeight15 * 2,
                      textSize: Dimensions.font16,
                    ),
                    IconButton(
                        onPressed: (() {
                          setState(() {
                            disability[1] = true;
                          });
                        }),
                        icon: const Icon(
                          Icons.edit,
                          size: 20,
                          color: Constants.tetiary,
                        ))
                  ],
                ),
                SizedBox(
                  height: Dimensions.sizedBoxHeight10 / 2,
                ),
                TextFormField(
                  controller: textEditingController2,
                  focusNode: focusNode2,
                  validator: (value) {
                    if (value == '') {
                      return Constants.err;
                    }

                    return null;
                  },
                  decoration: InputDecoration(
                    enabled: disability[1],
                    filled: true,
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    HeadSedction(
                      text: 'Second Name',
                      tMargin: Dimensions.sizedBoxHeight15 * 2,
                      textSize: Dimensions.font16,
                    ),
                    IconButton(
                        onPressed: (() {
                          setState(() {
                            disability[2] = true;
                          });
                        }),
                        icon: const Icon(
                          Icons.edit,
                          size: 20,
                          color: Constants.tetiary,
                        ))
                  ],
                ),
                SizedBox(
                  height: Dimensions.sizedBoxHeight10 / 2,
                ),
                TextFormField(
                  controller: textEditingController3,
                  focusNode: focusNode3,
                  validator: (value) {
                    if (value == '') {
                      return Constants.err;
                    }

                    return null;
                  },
                  decoration: InputDecoration(
                    enabled: disability[2],
                    filled: true,
                  ),
                ),
                SizedBox(
                  height: Dimensions.sizedBoxWidth10 * 2,
                ),
                SizedBox(
                  width: double.maxFinite,
                  height: Dimensions.sizedBoxHeight100 / 2,
                  child: ElevatedBtn(
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
                            'UPDATE',
                            style: TextStyle(
                                color: Constants.white,
                                fontSize: Dimensions.font14),
                          ),
                    pressed: () async {
                      if (key.currentState!.validate()) {
                        Provider.of<GlobalProvider>(context, listen: false)
                            .setProcess(Processes.waiting);

                        await Provider.of<UserProvider>(context, listen: false)
                            .updateUserData({
                          Constants.userUserName:
                              textEditingController1.text.trim(),
                          Constants.userFirstName:
                              textEditingController2.text.trim().toLowerCase(),
                          Constants.userLastName:
                              textEditingController3.text.trim().toLowerCase(),
                        }, FirebaseAuth.instance.currentUser!.uid).then(
                                (value) {
                          if (value) {
                            Provider.of<GlobalProvider>(context, listen: false)
                                .setProcess(Processes.done);

                            Constants(context).snackBar(
                                'Details updated successfully!',
                                Constants.tetiary);

                            Navigator.pop(context);
                          }
                        });
                      }
                    },
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
