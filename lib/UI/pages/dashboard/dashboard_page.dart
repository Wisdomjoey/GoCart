import 'package:GOCart/UI/utils/dimensions.dart';
import 'package:GOCart/UI/widgets/head_section_widget.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

import '../../../CONSTANTS/constants.dart';
import '../../../PROVIDERS/shop_provider.dart';

class DashboardPage extends StatelessWidget {
  final String shopId;

  const DashboardPage({super.key, required this.shopId});

  calcTotSales(Map<String, dynamic> data) {
    int totSales = 0;

    for (var element in data[Constants.sales]) {
      totSales += element[Constants.prodTotalSales] as int;
    }

    return totSales.toString();
  }

  @override
  Widget build(BuildContext context) {
    Map<String, dynamic> data =
        (Provider.of<ShopProvider>(context)
                .shops
                .where((element) => element[Constants.uid] == shopId))
            .elementAt(0) as Map<String, dynamic>;

    return SingleChildScrollView(
      child: Padding(
        padding: EdgeInsets.all(Dimensions.sizedBoxWidth15),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            HeadSedction(
              text: 'Sales Chart',
              weight: FontWeight.w500,
              textSize: Dimensions.font18,
              tMargin: Dimensions.sizedBoxWidth10,
              bMargin: Dimensions.sizedBoxWidth10 * 2,
            ),
            Container(
              width: double.maxFinite,
              height: Dimensions.sizedBoxHeight230,
              padding: EdgeInsets.all(Dimensions.sizedBoxWidth10 / 2),
              decoration: BoxDecoration(
                  color: Constants.white,
                  borderRadius:
                      BorderRadius.circular(Dimensions.sizedBoxWidth10 / 2)),
              child: SfCartesianChart(
                primaryXAxis: CategoryAxis(),
                legend: Legend(isVisible: true),
                tooltipBehavior: TooltipBehavior(enable: true),
                series: [
                  LineSeries<_SalesData, String>(
                      dataSource: data[Constants.sales].isNotEmpty
                          ? data[Constants.sales].map((e) => _SalesData(
                              e[Constants.month], e[Constants.prodTotalSales]))
                          : [
                              _SalesData(
                                  DateFormat('MMM').format(DateTime.now()), 0)
                            ],
                      xValueMapper: (_SalesData sales, _) => sales.month,
                      yValueMapper: (_SalesData sales, _) => sales.sales,
                      name: 'Sales',
                      xAxisName: 'Values',
                      yAxisName: 'Months'),
                ],
              ),
            ),
            HeadSedction(
              text: 'Profit Chart',
              weight: FontWeight.w500,
              textSize: Dimensions.font18,
              tMargin: Dimensions.sizedBoxWidth15 * 2,
              bMargin: Dimensions.sizedBoxWidth10 * 2,
            ),
            Container(
              width: double.maxFinite,
              height: Dimensions.sizedBoxHeight230,
              padding: EdgeInsets.all(Dimensions.sizedBoxWidth10 / 2),
              decoration: BoxDecoration(
                  color: Constants.white,
                  borderRadius:
                      BorderRadius.circular(Dimensions.sizedBoxWidth10 / 2)),
              child: SfCartesianChart(
                primaryXAxis: CategoryAxis(),
                legend: Legend(isVisible: true),
                tooltipBehavior: TooltipBehavior(enable: true),
                series: [
                  LineSeries<_SalesData, String>(
                      dataSource: data[Constants.sales].isNotEmpty
                          ? data[Constants.sales].map((e) => _SalesData(
                              e[Constants.month], e[Constants.sales]))
                          : [
                              _SalesData(
                                  DateFormat('MMM').format(DateTime.now()), 0)
                            ],
                      xValueMapper: (_SalesData sales, _) => sales.month,
                      yValueMapper: (_SalesData sales, _) => sales.sales,
                      name: 'Profits',
                      xAxisName: 'Values',
                      yAxisName: 'Months'),
                ],
              ),
            ),
            SizedBox(
              height: Dimensions.sizedBoxHeight10 * 2,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: Container(
                    width: double.maxFinite,
                    padding: EdgeInsets.all(Dimensions.sizedBoxWidth10),
                    decoration: BoxDecoration(
                        color: Constants.white,
                        borderRadius: BorderRadius.circular(
                            Dimensions.sizedBoxWidth10 / 2)),
                    child: Column(
                      children: [
                        Text(
                          'Total Sales',
                          style: TextStyle(
                              color: const Color.fromARGB(255, 130, 130, 130),
                              fontSize: Dimensions.font18,
                              fontWeight: FontWeight.w500),
                        ),
                        SizedBox(
                          height: Dimensions.sizedBoxHeight3,
                        ),
                        Text(
                          data[Constants.sales].isNotEmpty
                              ? calcTotSales(data)
                              : '0',
                          style: TextStyle(fontSize: Dimensions.font15),
                        )
                      ],
                    ),
                  ),
                ),
                SizedBox(
                  width: Dimensions.sizedBoxWidth25,
                ),
                Expanded(
                  child: Container(
                    width: double.maxFinite,
                    padding: EdgeInsets.all(Dimensions.sizedBoxWidth10),
                    decoration: BoxDecoration(
                        color: Constants.white,
                        borderRadius: BorderRadius.circular(
                            Dimensions.sizedBoxWidth10 / 2)),
                    child: Column(
                      children: [
                        Text(
                          'Total Likes',
                          style: TextStyle(
                              color: const Color.fromARGB(255, 130, 130, 130),
                              fontSize: Dimensions.font18,
                              fontWeight: FontWeight.w500),
                        ),
                        SizedBox(
                          height: Dimensions.sizedBoxHeight3,
                        ),
                        Text(
                          data[Constants.likes].length.toString(),
                          style: TextStyle(fontSize: Dimensions.font15),
                        )
                      ],
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(
              height: Dimensions.sizedBoxHeight10 * 2,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: Container(
                    width: double.maxFinite,
                    padding: EdgeInsets.all(Dimensions.sizedBoxWidth10),
                    decoration: BoxDecoration(
                        color: Constants.white,
                        borderRadius: BorderRadius.circular(
                            Dimensions.sizedBoxWidth10 / 2)),
                    child: Column(
                      children: [
                        Text(
                          'Total Products',
                          style: TextStyle(
                              color: const Color.fromARGB(255, 130, 130, 130),
                              fontSize: Dimensions.font18,
                              fontWeight: FontWeight.w500),
                        ),
                        SizedBox(
                          height: Dimensions.sizedBoxHeight3,
                        ),
                        Text(
                          '50',
                          style: TextStyle(fontSize: Dimensions.font15),
                        )
                      ],
                    ),
                  ),
                ),
                SizedBox(
                  width: Dimensions.sizedBoxWidth25,
                ),
                Expanded(
                  child: Container(
                    width: double.maxFinite,
                    padding: EdgeInsets.all(Dimensions.sizedBoxWidth10),
                    decoration: BoxDecoration(
                        color: Constants.white,
                        borderRadius: BorderRadius.circular(
                            Dimensions.sizedBoxWidth10 / 2)),
                    child: Column(
                      children: [
                        Text(
                          'Total Orders',
                          style: TextStyle(
                              color: const Color.fromARGB(255, 130, 130, 130),
                              fontSize: Dimensions.font18,
                              fontWeight: FontWeight.w500),
                        ),
                        SizedBox(
                          height: Dimensions.sizedBoxHeight3,
                        ),
                        Text(
                          '50',
                          style: TextStyle(fontSize: Dimensions.font15),
                        )
                      ],
                    ),
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}

class _SalesData {
  final String month;
  final double sales;

  _SalesData(this.month, this.sales);
}
