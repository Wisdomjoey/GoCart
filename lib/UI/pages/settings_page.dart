import 'package:GOCart/UI/components/home_app_bar.dart';
import 'package:GOCart/UI/utils/dimensions.dart';
import 'package:GOCart/UI/widgets/head_section_widget.dart';
import 'package:flutter/material.dart';

import '../../CONSTANTS/constants.dart';
import '../widgets/list_tile_btn_widget.dart';

class SettingsPage extends StatefulWidget {
  const SettingsPage({super.key});

  @override
  State<SettingsPage> createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  bool _switch = true;
  int? _gValue = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: HomeAppBar(
        textSize: Dimensions.font24,
        title: 'Settings',
        implyLeading: true,
        showCart: true,
      ),
      body: SingleChildScrollView(
        child: Container(
          margin: EdgeInsets.symmetric(horizontal: Dimensions.sizedBoxWidth10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const HeadSedction(
                text: 'APPEARANCE',
                weight: FontWeight.w500,
              ),
              Material(
                color: Constants.white,
                borderRadius: BorderRadius.circular(Dimensions.sizedBoxWidth4),
                child: Column(
                  children: [
                    ListTileBtn(
                        textSize: Dimensions.font14,
                        showTrailing: false,
                        onTap: () => showDialog(
                            context: context,
                            builder: ((context) => _showDialog(context))),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Theme',
                              style: TextStyle(fontSize: Dimensions.font15),
                            ),
                            SizedBox(
                              height: Dimensions.sizedBoxHeight3,
                            ),
                            Text(
                              'System',
                              style: TextStyle(
                                  color: Constants.grey,
                                  fontSize: Dimensions.font12),
                            ),
                          ],
                        )),
                  ],
                ),
              ),
              const HeadSedction(
                text: 'SETTINGS',
                weight: FontWeight.w500,
              ),
              Material(
                color: Constants.white,
                borderRadius: BorderRadius.circular(Dimensions.sizedBoxWidth4),
                child: Column(
                  children: [
                    ListTileBtn(
                      title: 'Push Notifications',
                      textSize: Dimensions.font15,
                      trailing: Switch(
                          value: _switch,
                          activeColor: Constants.tetiary,
                          onChanged: ((value) {
                            setState(() {
                              _switch = !_switch;
                            });
                          })),
                    ),
                    ListTileBtn(
                      title: 'Language',
                      textSize: Dimensions.font15,
                      trailing: Text(
                        'ENGLISH',
                        style: TextStyle(
                            color: const Color.fromARGB(255, 189, 189, 189),
                            fontSize: Dimensions.font12,
                            fontWeight: FontWeight.w600),
                      ),
                    ),
                  ],
                ),
              ),
              const HeadSedction(
                text: 'ABOUT',
                weight: FontWeight.w500,
              ),
              Material(
                color: Constants.white,
                borderRadius: BorderRadius.circular(Dimensions.sizedBoxWidth4),
                child: Column(
                  children: [
                    ListTileBtn(
                      textSize: Dimensions.font14,
                      trailing: Text(
                        'UP TO DATE',
                        style: TextStyle(
                            color: const Color.fromARGB(255, 189, 189, 189),
                            fontSize: Dimensions.font12,
                            fontWeight: FontWeight.w600),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'App Version',
                            style: TextStyle(fontSize: Dimensions.font15),
                          ),
                          SizedBox(
                            height: Dimensions.sizedBoxHeight3,
                          ),
                          Text(
                            'v1.02.13',
                            style: TextStyle(
                                color: Constants.grey,
                                fontSize: Dimensions.font12),
                          ),
                        ],
                      ),
                    ),
                    ListTileBtn(title: 'Support', textSize: Dimensions.font15),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _showDialog(BuildContext context) {
    return Dialog(
      insetPadding:
          EdgeInsets.symmetric(horizontal: Dimensions.sizedBoxWidth15 * 2),
      child: Container(
        padding: EdgeInsets.symmetric(
            horizontal: Dimensions.sizedBoxWidth10 * 2,
            vertical: Dimensions.sizedBoxHeight15),
        height: Dimensions.sizedBoxHeight100 * 2,
        decoration: BoxDecoration(
            color: Constants.white,
            borderRadius: BorderRadius.circular(Dimensions.font25 / 5)),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Radio(
                        // toggleable: true,
                        visualDensity:
                            const VisualDensity(vertical: -1, horizontal: -3),
                        value: 0,
                        groupValue: _gValue,
                        onChanged: ((dynamic value) {
                          setState(() {
                            _gValue = value;
                          });
                          Navigator.pop(context);
                        })),
                    Text(
                      'System',
                      style: TextStyle(
                          color: const Color.fromARGB(255, 121, 121, 121),
                          fontSize: Dimensions.font16),
                    )
                  ],
                ),
                Row(
                  children: [
                    Radio(
                        // toggleable: true,
                        visualDensity:
                            const VisualDensity(vertical: -1, horizontal: -3),
                        value: 1,
                        groupValue: _gValue,
                        onChanged: ((dynamic value) {
                          setState(() {
                            _gValue = value;
                          });
                          Navigator.pop(context);
                        })),
                    Text(
                      'Light',
                      style: TextStyle(
                          color: const Color.fromARGB(255, 121, 121, 121),
                          fontSize: Dimensions.font16),
                    )
                  ],
                ),
                Row(
                  children: [
                    Radio(
                        // toggleable: true,
                        visualDensity:
                            const VisualDensity(vertical: -1, horizontal: -3),
                        value: 2,
                        groupValue: _gValue,
                        onChanged: ((dynamic value) {
                          setState(() {
                            _gValue = value;
                          });
                          Navigator.pop(context);
                        })),
                    Text(
                      'Dark',
                      style: TextStyle(
                          color: const Color.fromARGB(255, 121, 121, 121),
                          fontSize: Dimensions.font16),
                    )
                  ],
                ),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  '',
                ),
                GestureDetector(
                  child: Text(
                    'CLOSE',
                    style: TextStyle(
                        fontWeight: FontWeight.w500,
                        fontSize: Dimensions.font16,
                        color: const Color.fromARGB(255, 74, 74, 74)),
                  ),
                  onTap: () {
                    Navigator.pop(context);
                  },
                )
              ],
            ),
          ],
        ),
      ),
    );
  }
}
