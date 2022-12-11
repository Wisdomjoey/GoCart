import 'package:flutter/material.dart';

import '../utils/dimensions.dart';

class ElevatedBtn extends StatelessWidget {
  final String text;
  final Color? textColor;
  final bool isElevated;
  final bool addBorder;
  final Icon? icon;

  const ElevatedBtn(
      {super.key,
      required this.text,
      this.icon,
      this.textColor,
      this.isElevated = true,
      this.addBorder = false});

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: () {},
      style: ElevatedButton.styleFrom(
          backgroundColor:
              addBorder ? Colors.transparent : const Color(0XFFF8C300),
          shadowColor: isElevated ? Colors.black : Colors.transparent,
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(Dimensions.sizedBoxWidth4),
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
