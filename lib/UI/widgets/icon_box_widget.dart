import 'package:flutter/material.dart';
import 'package:GOCart/UI/utils/dimensions.dart';

import '../../CONSTANTS/constants.dart';

class IconBox extends StatelessWidget {
  final Color borderColor;
  final Color iconColor;
  final Color? color;
  final double? iconSize;
  final double? right;
  final IconData icon;
  final bool isClickable;
  final bool isDisabled;
  final double? borderRadius;
  final double? width;
  final double? height;
  final VoidCallback? pressed;

  const IconBox(
      {super.key,
      this.borderColor = Constants.tetiary,
      this.iconColor = Constants.tetiary,
      this.iconSize,
      required this.icon,
      this.isClickable = true,
      this.isDisabled = false,
      this.right,
      this.borderRadius,
      this.width,
      this.height,
      this.color,
      this.pressed});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(right: right ?? Dimensions.sizedBoxWidth4 * 2),
      width: width ?? Dimensions.sizedBoxWidth32,
      height: height ?? Dimensions.sizedBoxWidth32,
      child: isClickable
          ? TextButton(
              onPressed: isDisabled ? null : (pressed ?? () {}),
              style: TextButton.styleFrom(
                  padding: const EdgeInsets.all(0),
                  backgroundColor: color ?? Colors.transparent,
                  disabledBackgroundColor:
                      const Color.fromARGB(255, 243, 225, 158),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(
                          borderRadius ?? Dimensions.font12 / 3),
                      side: BorderSide(color: borderColor))),
              child: Icon(
                icon,
                color: iconColor,
                size: iconSize ?? Dimensions.font12,
              ),
            )
          : Icon(
              icon,
              size: iconSize ?? Dimensions.font12,
              color: iconColor,
            ),
    );
  }
}
