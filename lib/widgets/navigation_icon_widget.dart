import 'package:flutter/material.dart';
import 'package:GOCart/utils/dimensions.dart';

class NavigationIcon extends StatelessWidget {
  final Icon icon;
  final String text;

  const NavigationIcon({super.key, required this.icon, required this.text});

  @override
  Widget build(BuildContext context) {
    return Column(children: [
      icon,
      SizedBox(
        height: Dimensions.sizedBoxHeight3,
      ),
      Text(
        text,
        style: const TextStyle(fontSize: 13),
      )
    ]);
  }
}
