import 'package:GOCart/PROVIDERS/user_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:GOCart/UI/components/search.dart';
import 'package:GOCart/UI/utils/dimensions.dart';
import 'package:provider/provider.dart';

import '../../CONSTANTS/constants.dart';

class AccountAppBar extends StatelessWidget with PreferredSizeWidget {
  AccountAppBar({super.key});

  @override
  Widget build(BuildContext context) {
    Map<String, dynamic> data = Provider.of<UserProvider>(context).userData;

    return AppBar(
      automaticallyImplyLeading: false,
      title: Text(
        'Account',
        style: TextStyle(fontSize: Dimensions.font24),
      ),
      actions: const [
        Search(),
      ],
      backgroundColor: Constants.secondary,
      systemOverlayStyle: const SystemUiOverlayStyle(
          statusBarColor: Constants.secondary,
          statusBarBrightness: Brightness.light,
          statusBarIconBrightness: Brightness.light),
      bottom: PreferredSize(
        preferredSize: preferredSize,
        // child: Expanded(
        child: Container(
          width: double.maxFinite,
          margin: EdgeInsets.only(bottom: Dimensions.sizedBoxHeight10),
          padding: EdgeInsets.only(left: Dimensions.sizedBoxWidth15),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                '${data[Constants.userLastName][0].toUpperCase() + data[Constants.userLastName].substring(1)} ${data[Constants.userFirstName][0].toUpperCase() + data[Constants.userFirstName].substring(1)}',
                style: TextStyle(
                    fontWeight: FontWeight.w500,
                    fontSize: Dimensions.font23,
                    color: Constants.tetiary),
              ),
              SizedBox(height: Dimensions.sizedBoxHeight10 / 2),
              Text(data[Constants.userEmail],
                  style: const TextStyle(
                      color: Color.fromARGB(255, 233, 233, 233))),
            ],
          ),
        ),
        // ),
      ),
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(Dimensions.sizedBoxHeight125);
}
