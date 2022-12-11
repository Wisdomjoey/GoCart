import 'package:flutter/material.dart';
import 'package:GOCart/utils/dimensions.dart';
import 'package:timelines/timelines.dart';

import '../components/home_app_bar.dart';

class OrderStatusPage extends StatelessWidget {
  const OrderStatusPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: HomeAppBar(
        title: 'Item Status',
        showCart: true,
        implyLeading: true,
        textSize: Dimensions.font24,
      ),
      body: Container(
          margin: EdgeInsets.only(top: Dimensions.sizedBoxHeight10),
          height: 700,
          padding: EdgeInsets.all(Dimensions.sizedBoxWidth10 * 2),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                width: double.maxFinite,
                height: 700,
                child: Timeline.tileBuilder(
                  theme: TimelineThemeData(
                      color: Colors.red,
                      indicatorTheme:
                          const IndicatorThemeData(size: 22, color: Colors.red),
                      connectorTheme: const ConnectorThemeData(
                          color: Colors.grey, space: 5, thickness: 5)),
                  builder: TimelineTileBuilder.fromStyle(
                    indicatorStyle: IndicatorStyle.outlined,
                    endConnectorStyle: ConnectorStyle.dashedLine,
                    itemExtent: 100,
                    itemCount: 5,
                    contentsBuilder: (context, index) {
                      return const Text('data');
                    },
                  ),
                ),
              )
            ],
          )),
    );
  }
}
