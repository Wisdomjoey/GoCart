import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:GOCart/UI/utils/dimensions.dart';
import 'package:intl/intl.dart';

import '../../CONSTANTS/constants.dart';

class InformationBox extends StatelessWidget {
  final Map<String, dynamic> data;

  const InformationBox({super.key, required this.data});

  @override
  Widget build(BuildContext context) {
    DateTime date = DateTime.parse(data['date']);

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
            DateFormat('d MMMM').format(date),
            style: TextStyle(
                color: const Color.fromARGB(255, 145, 145, 145),
                fontSize: Dimensions.font12),
          ),
          SizedBox(
            height: Dimensions.sizedBoxHeight10,
          ),
          Text(
            '${date.hour} : ${date.minute} : ${date.second}',
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
            height: Dimensions.sizedBoxHeight15 * 5,
            width: double.maxFinite,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(Dimensions.sizedBoxWidth4),
                border: Border.all(color: Constants.lightGrey)),
            padding: EdgeInsets.all(Dimensions.sizedBoxWidth10),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  height: Dimensions.sizedBoxHeight15 * 4,
                  width: Dimensions.sizedBoxHeight15 * 4,
                  decoration: BoxDecoration(
                      image: DecorationImage(
                          image: CachedNetworkImageProvider(data[Constants.imgUrl]),
                          fit: BoxFit.cover)),
                ),
                SizedBox(
                  width: Dimensions.sizedBoxWidth10,
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      data[Constants.inboxSubject],
                      style: TextStyle(fontSize: Dimensions.font13),
                    ),
                    SizedBox(height: Dimensions.sizedBoxHeight10 / 2,),
                    Text(
                      data[Constants.inboxMessage],
                      style: TextStyle(fontSize: Dimensions.font12, color: Constants.grey),
                    ),
                  ],
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}
