import 'package:flutter/material.dart';
import 'package:GOCart/UI/utils/dimensions.dart';

import '../../CONSTANTS/constants.dart';

class InformationBox extends StatelessWidget {
  const InformationBox({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(
          left: Dimensions.sizedBoxWidth10,
          right: Dimensions.sizedBoxWidth10,
          bottom: Dimensions.sizedBoxHeight10),
      padding: EdgeInsets.all(Dimensions.sizedBoxWidth4 * 2),
      width: double.maxFinite,
      decoration: BoxDecoration(
          color: Constants.white,
          borderRadius: BorderRadius.circular(Dimensions.sizedBoxWidth4)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            '23 December',
            style: TextStyle(
                color: const Color.fromARGB(255, 145, 145, 145),
                fontSize: Dimensions.font12),
          ),
          SizedBox(
            height: Dimensions.sizedBoxHeight10,
          ),
          Text(
            '23 December',
            style: TextStyle(
                color: const Color.fromARGB(255, 145, 145, 145),
                fontSize: Dimensions.font12),
          ),
          SizedBox(
            height: Dimensions.sizedBoxHeight10,
          ),
          Column(
            children: const [],
          ),
          SizedBox(
            height: Dimensions.sizedBoxHeight4 * 2,
          ),
          Container(
            height: Dimensions.sizedBoxHeight100 / 2,
            width: double.maxFinite,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(Dimensions.sizedBoxWidth4),
                border: Border.all(color: Constants.lightGrey)),
            padding: EdgeInsets.all(Dimensions.sizedBoxWidth10),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  height: Dimensions.sizedBoxHeight15 * 2,
                  width: Dimensions.sizedBoxHeight15 * 2,
                  decoration: const BoxDecoration(
                      image: DecorationImage(
                          image: AssetImage('assets/images/1.jpg'),
                          fit: BoxFit.cover)),
                ),
                SizedBox(
                  width: Dimensions.sizedBoxWidth10,
                ),
                Text(
                  'Dummy Product Data Available',
                  style: TextStyle(fontSize: Dimensions.font12),
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}
