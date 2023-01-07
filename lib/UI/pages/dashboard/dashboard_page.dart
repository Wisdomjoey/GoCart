import 'package:GOCart/UI/utils/dimensions.dart';
import 'package:GOCart/UI/widgets/head_section_widget.dart';
import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

import '../../../CONSTANTS/constants.dart';

class DashboardPage extends StatelessWidget {
  const DashboardPage({super.key});

  @override
  Widget build(BuildContext context) {
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
                      dataSource: [
                        _SalesData('Jan', 30),
                        _SalesData('Feb', 50),
                        _SalesData('Mar', 23),
                        _SalesData('Apr', 38),
                        _SalesData('May', 41),
                      ],
                      xValueMapper: (_SalesData sales, _) => sales.year,
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
                      dataSource: [
                        _SalesData('Jan', 30),
                        _SalesData('Feb', 50),
                        _SalesData('Mar', 23),
                        _SalesData('Apr', 38),
                        _SalesData('May', 41),
                      ],
                      xValueMapper: (_SalesData sales, _) => sales.year,
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
                          '50',
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
  final String year;
  final double sales;

  _SalesData(this.year, this.sales);
}
