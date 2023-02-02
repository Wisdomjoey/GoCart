import 'package:GOCart/CONSTANTS/constants.dart';
import 'package:flutter/material.dart';

import '../widgets/text_form_field_widget.dart';

class PasswordResetPage extends StatefulWidget {
  const PasswordResetPage({super.key});

  @override
  State<PasswordResetPage> createState() => _PasswordResetPageState();
}

class _PasswordResetPageState extends State<PasswordResetPage> {
  late TextEditingController controller;
  late FocusNode node;

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
              ),
            ),
          ],
        ),
      ),
    );
  }
}
