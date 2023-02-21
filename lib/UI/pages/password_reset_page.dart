import 'package:GOCart/CONSTANTS/constants.dart';
import 'package:GOCart/UI/utils/dimensions.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';

import '../../PROVIDERS/global_provider.dart';
import '../utils/validator.dart';
import '../widgets/elevated_button_widget.dart';
import '../widgets/text_form_field_widget.dart';

class PasswordResetPage extends StatefulWidget {
  const PasswordResetPage({super.key});

  @override
  State<PasswordResetPage> createState() => _PasswordResetPageState();
}

class _PasswordResetPageState extends State<PasswordResetPage> {
  late TextEditingController controller;
  late FocusNode node;
  GlobalKey<FormState> key = GlobalKey<FormState>();

  @override
  void initState() {
    controller = TextEditingController();
    node = FocusNode();

    super.initState();
  }

  @override
  void dispose() {
    controller.dispose();
    node.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnnotatedRegion(
      value: const SystemUiOverlayStyle(
          statusBarBrightness: Brightness.dark,
          statusBarIconBrightness: Brightness.dark),
      child: Scaffold(
        backgroundColor: Constants.white,
        body: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.symmetric(
                horizontal: Dimensions.sizedBoxWidth15 * 2,
                vertical: Dimensions.sizedBoxHeight100 / 2),
            child: Form(
              key: key,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    height: Dimensions.sizedBoxHeight320,
                    width: double.maxFinite,
                    decoration: const BoxDecoration(
                        image: DecorationImage(
                            image: AssetImage('assets/images/forgot.png'))),
                  ),
                  SizedBox(
                    height: Dimensions.sizedBoxHeight15 * 2,
                  ),
                  const Text('Enter your email address'),
                  SizedBox(
                    height: Dimensions.sizedBoxHeight15,
                  ),
                  Center(
                    child: TextFormFieldWidget(
                      controller: controller,
                      node: node,
                      label: 'Email',
                      icon: const Icon(
                        Icons.mail_outline_rounded,
                        color: Constants.grey,
                      ),
                      hint: 'example@gmail.com',
                      error: 'Enter a valid email',
                      val: () => isValidEmail(controller.text),
                    ),
                  ),
                  const Text(
                    'A password reset mail will be sent to the email address provided',
                    style: TextStyle(color: Constants.grey),
                  ),
                  SizedBox(
                    height: Dimensions.sizedBoxHeight15 * 2,
                  ),
                  ElevatedBtn(
                    pressed: () async {
                      if (key.currentState!.validate()) {
                        try {
                          Provider.of<GlobalProvider>(context, listen: false)
                              .setProcess(Processes.waiting);

                          await FirebaseAuth.instance
                              .sendPasswordResetEmail(
                                  email: controller.text.trim())
                              .then((value) {
                            Provider.of<GlobalProvider>(context, listen: false)
                                .setProcess(Processes.done);

                            Constants(context).snackBar(
                                'Link to reset your password has been sent to your email',
                                Constants.tetiary);

                            Navigator.pop(context);
                          });
                        } on FirebaseException catch (e) {
                          Constants(context).snackBar(e.message!, Colors.red);
                        }
                      }
                    },
                    text: 'Send',
                    disabled:
                        Provider.of<GlobalProvider>(context, listen: false)
                                    .process ==
                                Processes.waiting
                            ? true
                            : false,
                    child: Provider.of<GlobalProvider>(context, listen: false)
                                .process ==
                            Processes.waiting
                        ? SizedBox(
                            width: Dimensions.sizedBoxWidth10 * 1.5,
                            height: Dimensions.sizedBoxWidth10 * 1.5,
                            child: const CircularProgressIndicator(
                              color: Constants.white,
                              strokeWidth: 3,
                            ))
                        : Text(
                            'Send',
                            style: TextStyle(
                                color: Constants.white,
                                fontSize: Dimensions.font14),
                          ),
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
