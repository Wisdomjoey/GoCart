import 'package:flutter/material.dart';
import 'package:GOCart/UI/utils/dimensions.dart';
import 'package:GOCart/UI/widgets/elevated_button_widget.dart';

import '../../CONSTANTS/constants.dart';

class DetailsBottomNav extends StatelessWidget {
  final Widget? leading;
  final String text;
  final Icon? icon;

  const DetailsBottomNav(
      {super.key, this.leading, required this.text, this.icon});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(
          vertical: Dimensions.sizedBoxHeight4 * 2,
          horizontal: Dimensions.sizedBoxWidth10 * 2),
      height: Dimensions.sizedBoxHeight65,
      decoration: const BoxDecoration(
          border: Border(
              top: BorderSide(
                  color: Constants.lightGrey, style: BorderStyle.solid)),
          color: Constants.white),
      child: Row(
        children: [
          leading!,
          Expanded(
            child: ElevatedBtn(
              text: text,
              icon: icon,
            ),
          )
        ],
      ),
    );
  }
}
