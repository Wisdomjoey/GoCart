import 'package:GOCart/CONSTANTS/constants.dart';
import 'package:GOCart/PROVIDERS/user_provider.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:GOCart/UI/components/information_box.dart';
import 'package:GOCart/UI/utils/dimensions.dart';
import 'package:provider/provider.dart';

import '../components/home_app_bar.dart';

class InboxPage extends StatelessWidget {
  const InboxPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: HomeAppBar(
        title: 'Inbox',
        showCart: true,
        implyLeading: true,
      ),
      body: FutureBuilder(
        future: Provider.of<UserProvider>(context, listen: false)
            .fetchAllInbox(FirebaseAuth.instance.currentUser!.uid),
        builder: ((context, AsyncSnapshot snapshot) {
          return snapshot.connectionState == ConnectionState.waiting
              ? const Center(
                  child: CircularProgressIndicator(color: Constants.tetiary),
                )
              : (snapshot.data.isEmpty
                  ? SizedBox(
                    width: double.maxFinite,
                    height: double.maxFinite,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Container(
                          width: Dimensions.sizedBoxWidth100 * 2.5,
                          height: Dimensions.sizedBoxWidth100 * 2.5,
                          decoration: const BoxDecoration(
                              image: DecorationImage(
                                  image: AssetImage('assets/images/Emails.png'), fit: BoxFit.cover)),
                        ),
                        SizedBox(height: Dimensions.sizedBoxHeight10,),
                        const Text('No inboxes at the moment', style: TextStyle(color: Constants.grey),)
                      ],
                    ),
                  )
                  : ListView.builder(
                      padding:
                          EdgeInsets.only(top: Dimensions.sizedBoxHeight10),
                      itemCount: snapshot.data.length,
                      itemBuilder: (context, index) {
                        return InformationBox(
                          data: snapshot.data[index],
                        );
                      },
                    ));
        }),
      ),
    );
  }
}
