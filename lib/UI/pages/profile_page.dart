import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

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

    textEditingController2.text = 'Example';
    textEditingController3.text = 'Example';

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
                  validator: (value) {
                    if (value == '') {
                      return Constants.err;
                    }

                    return null;
                  },
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
                    text: 'UPDATE',
                    pressed: () {
                      if (key.currentState!.validate()) {}
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
