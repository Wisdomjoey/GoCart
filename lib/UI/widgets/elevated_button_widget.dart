import 'package:flutter/material.dart';

import '../../CONSTANTS/constants.dart';
import '../utils/dimensions.dart';

class ElevatedBtn extends StatelessWidget {
  final String text;
  final Color? textColor;
  final Color? bgColor;
  final bool isElevated;
  final bool addBorder;
  final bool disabled;
  final Icon? icon;
  final double? radius;
  final double? visualVD;
  final double? visualHD;
  final void Function()? pressed;

  const ElevatedBtn(
      {super.key,
      required this.text,
      this.icon,
      this.textColor,
      this.isElevated = true,
      this.addBorder = false,
      this.disabled = false,
      this.radius,
      this.pressed,
      this.visualVD,
      this.visualHD, this.bgColor});

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: disabled ? null : (pressed ?? () {}),
      style: ElevatedButton.styleFrom(
          backgroundColor: addBorder ? Colors.transparent : (bgColor ?? Constants.tetiary),
          shadowColor: isElevated ? Colors.black : Colors.transparent,
          visualDensity: VisualDensity(
            vertical: visualVD ?? 0,
            horizontal: visualHD ?? 0,
          ),
          shape: RoundedRectangleBorder(
              borderRadius:
                  BorderRadius.circular(radius ?? Dimensions.sizedBoxWidth4),
              side: BorderSide(
                  color: addBorder ? Constants.tetiary : Colors.transparent))),
      child: Stack(
        children: [
          Align(
            alignment: Alignment.centerLeft,
            child: icon,
          ),
          Align(
            alignment: Alignment.center,
            child: Text(
              text,
              style: TextStyle(
                  fontSize: Dimensions.font14,
                  color: textColor ?? Constants.white),
            ),
          )
        ],
      ),
    );
  }
}
