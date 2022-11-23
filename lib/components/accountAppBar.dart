import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:schoolproj/components/search.dart';
import 'package:schoolproj/utils/dimensions.dart';

class AccountAppBar extends StatefulWidget with PreferredSizeWidget {
  AccountAppBar({super.key});

  @override
  State<AccountAppBar> createState() => _AccountAppBarState();

  @override
  // TODO: implement preferredSize
  Size get preferredSize => Size.fromHeight(Dimensions.sizedBoxHeight125);
}

class _AccountAppBarState extends State<AccountAppBar> {
  @override
  Widget build(BuildContext context) {
    return AppBar(
      automaticallyImplyLeading: false,
      title: Text(
        'Account',
        style: TextStyle(fontSize: Dimensions.font23),
      ),
      actions: const [
        Search(),
      ],
      backgroundColor: const Color(0XFF00923F),
      systemOverlayStyle: const SystemUiOverlayStyle(
          statusBarColor: Color(0XFF00923F),
          statusBarBrightness: Brightness.light,
          statusBarIconBrightness: Brightness.light),
      bottom: PreferredSize(
        preferredSize: widget.preferredSize,
        // child: Expanded(
        child: Container(
          width: double.maxFinite,
          margin: EdgeInsets.only(bottom: Dimensions.sizedBoxHeight10),
          padding: EdgeInsets.only(left: Dimensions.sizedBoxWidth15),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Jonathan Wisdom',
                style: TextStyle(
                    fontWeight: FontWeight.w500,
                    fontSize: Dimensions.font23,
                    color: const Color(0XFFF8C300)),
              ),
              SizedBox(height: Dimensions.sizedBoxHeight10 / 2),
              const Text('example@gmail.com',
                  style: TextStyle(color: Color.fromARGB(255, 233, 233, 233))),
            ],
          ),
        ),
        // ),
      ),
    );
  }
}
