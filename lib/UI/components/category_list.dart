import 'package:GOCart/UI/utils/firebase_actions.dart';
import 'package:flutter/material.dart';
import 'package:GOCart/UI/utils/dimensions.dart';
import 'package:provider/provider.dart';

import '../../CONSTANTS/constants.dart';
import '../../PROVIDERS/user_provider.dart';

class CategoryList extends StatelessWidget {
  final String cat;

  const CategoryList({super.key, required this.cat});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          Padding(
              padding: EdgeInsets.only(
                  top: Dimensions.sizedBoxHeight15,
                  left: Dimensions.sizedBoxWidth15,
                  right: Dimensions.sizedBoxWidth15),
              child: Material(
                color: Constants.white,
                borderRadius: BorderRadius.circular(Dimensions.sizedBoxWidth4),
                child: ListTile(
                  title: Text(
                    'ALL PRODUCTS',
                    style: TextStyle(
                        fontWeight: FontWeight.w500,
                        fontSize: Dimensions.font13),
                  ),
                  trailing: Icon(
                    Icons.arrow_forward_ios_rounded,
                    size: Dimensions.font15,
                  ),
                  iconColor: const Color(0XFF111111),
                  minLeadingWidth: Dimensions.sizedBoxWidth4 / 2,
                  visualDensity: VisualDensity(
                      vertical: -(Dimensions.sizedBoxHeight4 / 2)),
                  onTap: () async {
                    await sendPushMessage(
                            Provider.of<UserProvider>(context, listen: false)
                                .userData[Constants.userFCMToken],
                            'Title test',
                            'Test body, Hi this notification worked')
                        .then((value) {
                      print(value.toString());
                    });
                  },
                ),
              )),
          Container(
            width: double.maxFinite,
            margin: EdgeInsets.only(
                left: Dimensions.sizedBoxWidth15,
                top: Dimensions.sizedBoxHeight10,
                right: Dimensions.sizedBoxWidth15),
            padding: EdgeInsets.symmetric(
                horizontal: Dimensions.sizedBoxWidth10,
                vertical: Dimensions.sizedBoxHeight15),
            decoration: BoxDecoration(
                color: Constants.white,
                borderRadius: BorderRadius.all(
                    Radius.circular(Dimensions.sizedBoxHeight4))),
            child: GridView.builder(
              physics: const NeverScrollableScrollPhysics(),
              shrinkWrap: true,
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 3,
                  mainAxisSpacing: Dimensions.sizedBoxWidth10 * 2,
                  crossAxisSpacing: Dimensions.sizedBoxHeight10 / 2),
              itemCount: Constants.cats[cat]!.length,
              itemBuilder: (context, idx) {
                return Material(
                  child: InkWell(
                    child: Ink(
                      decoration: BoxDecoration(
                        borderRadius:
                            BorderRadius.circular(Dimensions.sizedBoxWidth4),
                        color: Constants.white,
                      ),
                      child: Column(
                        children: [
                          Expanded(
                            child: Ink(
                              height: double.maxFinite,
                              decoration: BoxDecoration(
                                  image: DecorationImage(
                                      image: AssetImage(
                                          Constants.cats[cat]![idx]['img']),
                                      fit: BoxFit.contain)),
                            ),
                          ),
                          SizedBox(
                            height: Dimensions.sizedBoxHeight10,
                          ),
                          Text(
                            Constants.cats[cat]![idx]['label'],
                            textAlign: TextAlign.center,
                            style: TextStyle(
                                fontSize: Dimensions.font11,
                                color:
                                    const Color.fromARGB(255, 129, 129, 129)),
                          )
                        ],
                      ),
                    ),
                    onTap: () {},
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
