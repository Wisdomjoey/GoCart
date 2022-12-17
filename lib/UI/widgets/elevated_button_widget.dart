import 'package:flutter/material.dart';

import '../utils/dimensions.dart';

class ElevatedBtn extends StatelessWidget {
  final String text;
  final Color? textColor;
  final bool isElevated;
  final bool addBorder;
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
      this.radius,
      this.pressed,
      this.visualVD,
      this.visualHD});

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: pressed ?? () {},
      style: ElevatedButton.styleFrom(
          backgroundColor:
              addBorder ? Colors.transparent : const Color(0XFFF8C300),
          shadowColor: isElevated ? Colors.black : Colors.transparent,
          visualDensity: VisualDensity(
            vertical: visualVD ?? 0,
            horizontal: visualHD ?? 0,
          ),
          shape: RoundedRectangleBorder(
              borderRadius:
                  BorderRadius.circular(radius ?? Dimensions.sizedBoxWidth4),
              side: BorderSide(
                  color: addBorder
                      ? const Color(0XFFF8C300)
                      : Colors.transparent))),
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
                  color: textColor ?? Colors.white),
            ),
          )
        ],
      ),
    );
  }
}
