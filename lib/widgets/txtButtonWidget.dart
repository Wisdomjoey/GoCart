import 'package:flutter/material.dart';
import 'package:schoolproj/utils/dimensions.dart';

class TxtButton extends StatelessWidget {
  final Color color;
  final Color? bgColor;
  final RoundedRectangleBorder? borderColor;
  final double visualD;
  final double? top;
  final double? textSize;
  final double? bottom;
  final double? pad;
  final String text;
  final bool addHPad;

  const TxtButton(
      {super.key,
      this.color = const Color(0XFF00923F),
      this.visualD = 0,
      required this.text,
      this.addHPad = true,
      this.top,
      this.bottom,
      this.pad,
      this.bgColor,
      this.borderColor,
      this.textSize});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(
          top: top ?? Dimensions.sizedBoxHeight10,
          bottom: bottom ?? Dimensions.sizedBoxHeight10 * 2),
      padding: EdgeInsets.symmetric(
          horizontal: addHPad ? pad ?? Dimensions.sizedBoxWidth10 * 2 : 0),
      child: Center(
        child: TextButton(
          style: TextButton.styleFrom(
              visualDensity: VisualDensity(vertical: visualD),
              minimumSize: Size.fromHeight(Dimensions.sizedBoxHeight100 / 2),
              backgroundColor: bgColor ?? Colors.transparent,
              elevation: 0,
              shape: borderColor ??
                  RoundedRectangleBorder(
                      side:
                          const BorderSide(width: 0, color: Colors.transparent),
                      borderRadius:
                          BorderRadius.circular(Dimensions.sizedBoxWidth4)),
              shadowColor: Colors.transparent),
          onPressed: () {},
          child: Text(text,
              style: TextStyle(
                  fontSize: textSize ?? Dimensions.font14,
                  color: color,
                  fontWeight: FontWeight.w500)),
        ),
      ),
    );
  }
}
