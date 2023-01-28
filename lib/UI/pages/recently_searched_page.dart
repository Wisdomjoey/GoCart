import 'package:GOCart/PREFS/preferences.dart';
import 'package:GOCart/UI/widgets/elevated_button_widget.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';

import '../../PROVIDERS/global_provider.dart';
import '../components/home_app_bar.dart';
import '../../CONSTANTS/constants.dart';
import '../routes/route_helper.dart';
import '../utils/dimensions.dart';

class RecentlySearchedPage extends StatelessWidget {
  const RecentlySearchedPage({super.key});

  @override
  Widget build(BuildContext context) {
    List<String> history = Provider.of<GlobalProvider>(context).history;

    return Scaffold(
      appBar: HomeAppBar(
        title: 'Recently Searched',
        showCart: true,
        implyLeading: true,
        textSize: Dimensions.font24,
      ),
      body: history.isEmpty
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
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Column(
                      children: history.map((e) {
                        return Container(
                          color: Colors.transparent,
                          width: double.maxFinite,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Expanded(
                                    child: Container(
                                      color: Colors.red,
                                      child: GestureDetector(
                                        onTap: () => Get.toNamed(
                                            RouteHelper.getProductListPage(),
                                            arguments: e),
                                        child: Row(
                                          children: [
                                            SizedBox(
                                              width: Dimensions.sizedBoxWidth10,
                                            ),
                                            const Icon(
                                              Icons.history,
                                              color: Constants.grey,
                                              size: 17,
                                            ),
                                            SizedBox(
                                              width: Dimensions.sizedBoxWidth10,
                                            ),
                                            Text(e),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ),
                                  Padding(
                                    padding: EdgeInsets.only(right: Dimensions.sizedBoxWidth10),
                                    child: GestureDetector(
                                      onTap: () {
                                        history.remove(e);

                                        Preferences().saveListData(
                                            Constants.prefsSearchHistory,
                                            history);

                                        Provider.of<GlobalProvider>(context,
                                                listen: false)
                                            .setHistory(history);
                                      },
                                      child: const Icon(
                                        Icons.close,
                                        color: Constants.grey,
                                        size: 17,
                                      ),
                                    ),
                                  ),
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
                    SizedBox(
                      height: Dimensions.sizedBoxHeight10 * 2,
                    ),
                    Container(
                      width: Dimensions.sizedBoxWidth100,
                      height: Dimensions.sizedBoxHeight10 * 4,
                      padding:
                          EdgeInsets.only(right: Dimensions.sizedBoxWidth10),
                      child: ElevatedBtn(
                        pressed: () {
                          Preferences()
                              .saveListData(Constants.prefsSearchHistory, []);

                          Provider.of<GlobalProvider>(context, listen: false)
                              .setHistory([]);
                        },
                        text: 'Clear',
                      ),
                    )
                  ],
                ),
              ),
            ),
    );
  }
}
