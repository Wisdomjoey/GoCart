import 'package:GOCart/CONSTANTS/constants.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

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
    return Scaffold(
      backgroundColor: Constants.white,
      body: SingleChildScrollView(
        child: Form(
          key: key,
          child: Column(
            children: [
              Text('Enter your email address'),
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
              Text(
                  'A password reset mail will be sent to the email address provided'),
              ElevatedBtn(
                  pressed: () async {
                    if (key.currentState!.validate()) {
                      await FirebaseAuth.instance
                          .sendPasswordResetEmail(email: controller.text.trim())
                          .then((value) {
                        Constants(context).snackBar(
                            'Link to reset your password has been sent to your email',
                            Constants.tetiary);

                        Navigator.pop(context);
                      });
                    }
                  },
                  text: 'Send')
            ],
          ),
        ),
      ),
    );
  }
}
