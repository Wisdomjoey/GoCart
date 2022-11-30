import 'package:flutter/material.dart';
import 'package:schoolproj/utils/dimensions.dart';

class IconBox extends StatelessWidget {
  final Color borderColor;
  final Color iconColor;
  final double? iconSize;
  final double? right;
  final IconData icon;
  final bool isClickable;
  final String? text;

  const IconBox(
      {super.key,
      this.borderColor = const Color(0XFFF8C300),
      this.iconColor = const Color(0XFFF8C300),
      this.iconSize,
      required this.icon,
      this.isClickable = true,
      this.text,
      this.right});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(right: right ?? Dimensions.sizedBoxWidth4 * 2),
      width: Dimensions.sizedBoxWidth32,
      height: Dimensions.sizedBoxWidth32,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(Dimensions.font12 / 3),
          border: Border.all(color: borderColor)),
      child: isClickable
          ? IconButton(
              splashRadius: 16.5,
              tooltip: text,
              icon: Icon(
                icon,
                color: iconColor,
                size: iconSize ?? Dimensions.font12,
              ),
              onPressed: () {},
            )
          : Icon(
              icon,
              size: iconSize ?? Dimensions.font12,
              color: iconColor,
            ),
    );
  }
}
