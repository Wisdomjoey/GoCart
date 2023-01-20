import 'dart:async';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:GOCart/UI/utils/dimensions.dart';

class ListTileBtn extends StatelessWidget {
  final double visualD;
  final double? textSize;
  final Color? textColor;
  final double? hr;
  final String? title;
  final Widget? leading;
  final Widget? trailing;
  final Widget? child;
  final FontWeight? weight;
  final void Function()? onTap;
  final String? page;
  final bool showTrailing;
  final bool selected;
  final dynamic args;

  const ListTileBtn(
      {super.key,
      this.visualD = -1,
      this.textSize,
      this.title,
      this.leading,
      this.weight,
      this.page,
      this.child,
      this.showTrailing = true,
      this.trailing,
      this.onTap,
      this.hr,
      this.textColor,
      this.selected = false, this.args});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: leading,
      contentPadding:
          EdgeInsets.symmetric(horizontal: hr ?? Dimensions.sizedBoxWidth10),
      title: child ??
          Text(
            title!,
            style: TextStyle(
                fontSize: textSize, fontWeight: weight, color: textColor),
          ),
      trailing: showTrailing
          ? (trailing ??
              Icon(
                Icons.arrow_forward_ios_rounded,
                size: textSize ?? Dimensions.font12,
              ))
          : const Text(''),
      iconColor: const Color(0XFF111111),
      minLeadingWidth: 2.0,
      selected: selected,
      visualDensity: VisualDensity(vertical: visualD),
      onTap: page != null
          ? () {
              Timer(
                  const Duration(milliseconds: 200), () => Get.toNamed(page!, arguments: args));
            }
          : onTap,
    );
  }
}
