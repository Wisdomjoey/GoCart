import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:GOCart/UI/components/search.dart';
import 'package:GOCart/UI/utils/dimensions.dart';

import '../../CONSTANTS/constants.dart';

class AccountAppBar extends StatelessWidget with PreferredSizeWidget {
  final String firstname;
  final String lastname;
  final String email;
  
  AccountAppBar({super.key, required this.firstname, required this.lastname, required this.email});

  @override
  Widget build(BuildContext context) {
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
                '${lastname[0].toUpperCase() + lastname.substring(1)} ${firstname[0].toUpperCase() + firstname.substring(1)}',
                style: TextStyle(
                    fontWeight: FontWeight.w500,
                    fontSize: Dimensions.font23,
                    color: Constants.tetiary),
              ),
              SizedBox(height: Dimensions.sizedBoxHeight10 / 2),
              Text(email,
                  style: const TextStyle(color: Color.fromARGB(255, 233, 233, 233))),
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
