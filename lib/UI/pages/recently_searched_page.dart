import 'package:GOCart/PREFS/preferences.dart';
import 'package:flutter/material.dart';

import '../components/home_app_bar.dart';
import '../../CONSTANTS/constants.dart';
import '../utils/dimensions.dart';

class RecentlySearchedPage extends StatefulWidget {
  const RecentlySearchedPage({super.key});

  @override
  State<RecentlySearchedPage> createState() => _RecentlySearchedPageState();
}

class _RecentlySearchedPageState extends State<RecentlySearchedPage> {
  List<String>? history = [];

  @override
  void initState() {
    setHistory();

    super.initState();
  }

  setHistory() async {
    List<String>? data =
        await Preferences().getListData(Constants.prefsSearchHistory);
    setState(() {
      history = data;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: HomeAppBar(
        title: 'Recently Searched',
        showCart: true,
        implyLeading: true,
        textSize: Dimensions.font24,
      ),
      body: history == null
          ? Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Center(
                  child: Image.asset(
                    'assets/images/searched.png',
                    width: Dimensions.sizedBoxWidth100 * 3,
                  ),
                ),
                SizedBox(
                  height: Dimensions.sizedBoxWidth10 * 2,
                ),
                const Center(
                  child: Text(
                    'Your search history is shown here',
                    style: TextStyle(color: Constants.grey),
                  ),
                ),
              ],
            )
          : SingleChildScrollView(
            child: Container(
                padding:
                    EdgeInsets.symmetric(vertical: Dimensions.sizedBoxHeight10),
              child: Column(
                  children: history!.map((e) {
                    return Container(
                      color: Colors.transparent,
                      width: double.maxFinite,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              SizedBox(
                                width: Dimensions.sizedBoxWidth10,
                              ),
                              Icon(
                                Icons.history,
                                color: Constants.grey,
                                size: 17,
                              ),
                              SizedBox(
                                width: Dimensions.sizedBoxWidth10,
                              ),
                              Text('ghhhh'),
                            ],
                          ),
                          const Divider(
                            color: Constants.grey,
                          )
                        ],
                      ),
                    );
                  }).toList(),
                ),
            ),
          ),
    );
  }
}
