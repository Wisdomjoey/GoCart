import 'package:flutter/material.dart';
import 'package:schoolproj/utils/dimensions.dart';

class TxtButton extends StatelessWidget {
  final Color color;
  final double visualD;
  final String text;
  final bool addHPad;

  const TxtButton(
      {super.key,
      this.color = const Color(0XFF00923F),
      this.visualD = 0,
      required this.text,
      this.addHPad = true});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(
          top: Dimensions.sizedBoxHeight10,
          bottom: Dimensions.sizedBoxHeight10 * 2),
      padding: EdgeInsets.symmetric(horizontal: addHPad ? Dimensions.sizedBoxWidth10 * 2 : 0),
      child: Center(
        child: TextButton(
          style: TextButton.styleFrom(
              visualDensity: VisualDensity(vertical: visualD),
              minimumSize: Size.fromHeight(Dimensions.sizedBoxHeight100 / 2),
              backgroundColor: Colors.transparent,
              elevation: 0,
              shadowColor: Colors.transparent),
          onPressed: () {},
          child: Text(text,
              style: TextStyle(
                  fontSize: Dimensions.font14,
                  color: color,
                  fontWeight: FontWeight.w500)),
        ),
      ),
    );
  }
}
