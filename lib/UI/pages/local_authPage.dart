import 'package:GOCart/CONSTANTS/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:local_auth/local_auth.dart';

import '../utils/dimensions.dart';

class LocalAuthPage extends StatefulWidget {
  const LocalAuthPage({super.key});

  @override
  State<LocalAuthPage> createState() => _LocalAuthPageState();
}

class _LocalAuthPageState extends State<LocalAuthPage> {
  LocalAuthentication authentication = LocalAuthentication();

  List pin = [false, false, false, false, false, false];

  int pp = 123456;
  String p = '';

  bool showDelete = false;

  setPin(String pass) {
    int index = pin.indexOf(false);

    if (index == 0) {
      setState(() {
        showDelete = true;
      });
    }

    setState(() {
      pin[index] = pass;

      if (index == 5) {
        for (var element in pin) {
          p += element;
        }

        if (int.parse(p) == pp) {
          HapticFeedback.vibrate();
          
          showDialog(
              context: context,
              builder: (context) => _showDialog(context, 'Correct'));
        } else {
          HapticFeedback.vibrate();
          
          showDialog(
              context: context,
              builder: (context) => _showDialog(context, 'Wrong'));
        }

        pin = [false, false, false, false, false, false];
      }
    });
  }

  deletePin() {
    int index = pin.indexOf(false);

    List newPin = pin;
    newPin.removeAt(index - 1);
    newPin.add(false);

    setState(() {
      pin = newPin;

      if (index - 1 == 0) {
        showDelete = false;
      }
    });
  }

  Future authenticate() async {
    final bool isBiometricsAvailable = await authentication.isDeviceSupported();

    if (!isBiometricsAvailable) return false;

    try {
      return await authentication.authenticate(
          localizedReason: 'Scan Fingerprint',
          options: const AuthenticationOptions(
              // biometricOnly: true,
              useErrorDialogs: true,
              stickyAuth: true));
    } on PlatformException catch (e) {
      print(e.code);
      return;
    }
  }

  @override
  Widget build(BuildContext context) {
    List<Widget> row1 = [
      IconButton(
          onPressed: (() {
            setPin('1');
          }),
          icon: Text(
            '1',
            style: TextStyle(
              fontWeight: FontWeight.w800,
              fontSize: Dimensions.font18 * 2,
            ),
          )),
      IconButton(
          onPressed: (() {
            setPin('2');
          }),
          icon: Text(
            '2',
            style: TextStyle(
              fontWeight: FontWeight.w800,
              fontSize: Dimensions.font18 * 2,
            ),
          )),
      IconButton(
          onPressed: (() {
            setPin('3');
          }),
          icon: Text(
            '3',
            style: TextStyle(
              fontWeight: FontWeight.w800,
              fontSize: Dimensions.font18 * 2,
            ),
          )),
    ];

    List<Widget> row2 = [
      IconButton(
          onPressed: (() {
            setPin('4');
          }),
          icon: Text(
            '4',
            style: TextStyle(
              fontWeight: FontWeight.w800,
              fontSize: Dimensions.font18 * 2,
            ),
          )),
      IconButton(
          onPressed: (() {
            setPin('5');
          }),
          icon: Text(
            '5',
            style: TextStyle(
              fontWeight: FontWeight.w800,
              fontSize: Dimensions.font18 * 2,
            ),
          )),
      IconButton(
          onPressed: (() {
            setPin('6');
          }),
          icon: Text(
            '6',
            style: TextStyle(
              fontWeight: FontWeight.w800,
              fontSize: Dimensions.font18 * 2,
            ),
          )),
    ];

    List<Widget> row3 = [
      IconButton(
          onPressed: (() {
            setPin('7');
          }),
          icon: Text(
            '7',
            style: TextStyle(
              fontWeight: FontWeight.w800,
              fontSize: Dimensions.font18 * 2,
            ),
          )),
      IconButton(
          onPressed: (() {
            setPin('8');
          }),
          icon: Text(
            '8',
            style: TextStyle(
              fontWeight: FontWeight.w800,
              fontSize: Dimensions.font18 * 2,
            ),
          )),
      IconButton(
          onPressed: (() {
            setPin('9');
          }),
          icon: Text(
            '9',
            style: TextStyle(
              fontWeight: FontWeight.w800,
              fontSize: Dimensions.font18 * 2,
            ),
          )),
    ];

    List<Widget> row4 = [
      SizedBox(
        width: Dimensions.sizedBoxWidth15 * 6,
        height: Dimensions.sizedBoxWidth15 * 6,
        child: IconButton(
            onPressed: (() {}),
            splashRadius: Dimensions.sizedBoxWidth100 / 2,
            icon: Text(
              'Sign Out',
              style: TextStyle(
                  fontWeight: FontWeight.w600,
                  fontSize: Dimensions.font20,
                  color: Constants.secondary),
            )),
      ),
      IconButton(
          onPressed: (() {
            setPin('0');
          }),
          icon: Text(
            '0',
            style: TextStyle(
              fontWeight: FontWeight.w800,
              fontSize: Dimensions.font18 * 2,
            ),
          )),
      SizedBox(
        width: Dimensions.sizedBoxWidth15 * 6,
        height: Dimensions.sizedBoxWidth15 * 6,
        child: IconButton(
          onPressed: (() async {
            HapticFeedback.vibrate();
            if (showDelete) {
              deletePin();
            } else {
              print(await authenticate());
            }
          }),
          splashRadius: Dimensions.sizedBoxWidth100 / 2,
          padding: EdgeInsets.all(0),
          icon: showDelete
              ? Text(
                  'Delete',
                  style: TextStyle(
                      fontWeight: FontWeight.w600,
                      fontSize: Dimensions.font20,
                      color: Constants.secondary),
                )
              : Container(
                  width: Dimensions.sizedBoxWidth100 / 2,
                  height: Dimensions.sizedBoxWidth100 / 2,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(
                          Dimensions.sizedBoxWidth100 / 2),
                      color: Constants.secondary),
                  child: Center(
                    child: Icon(
                      Icons.fingerprint_rounded,
                      color: Constants.white,
                      size: Dimensions.sizedBoxWidth10 * 3,
                    ),
                  ),
                ),
        ),
      ),
    ];

    return Scaffold(
      backgroundColor: Constants.white,
      body: CustomScrollView(slivers: [
        SliverFillRemaining(
          child: Container(
            width: double.maxFinite,
            margin: EdgeInsets.symmetric(
                horizontal: Dimensions.sizedBoxWidth10 * 2),
            padding: EdgeInsets.only(
                top: Dimensions.sizedBoxHeight100,
                bottom: Dimensions.sizedBoxHeight100 / 2),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  children: [
                    Text(
                      'Welcome Back!',
                      style: TextStyle(
                          fontWeight: FontWeight.w800,
                          fontSize: Dimensions.font17 * 2,
                          color: Constants.secondary),
                    ),
                    SizedBox(
                      height: Dimensions.sizedBoxWidth10 * 2,
                    ),
                    Container(
                      width: Dimensions.sizedBoxWidth15 * 2,
                      height: Dimensions.sizedBoxHeight3 * 2,
                      decoration: BoxDecoration(
                          color: Constants.secondary,
                          borderRadius: BorderRadius.circular(
                              Dimensions.sizedBoxHeight3 * 2)),
                    ),
                    SizedBox(
                      height: Dimensions.sizedBoxWidth10 * 2,
                    ),
                    Text(
                      'Jonathan Wisdom',
                      style: TextStyle(
                        fontWeight: FontWeight.w800,
                        fontSize: Dimensions.font24,
                      ),
                    ),
                    SizedBox(
                      height: Dimensions.sizedBoxWidth15 * 4,
                    ),
                  ],
                ),
                Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [0, 1, 2, 3, 4, 5].map((e) {
                        return Container(
                          width: pin[e] == false
                              ? Dimensions.sizedBoxWidth10
                              : Dimensions.sizedBoxWidth15,
                          height: pin[e] == false
                              ? Dimensions.sizedBoxWidth10
                              : Dimensions.sizedBoxWidth15,
                          decoration: BoxDecoration(
                              color: pin[e] == false
                                  ? Constants.grey
                                  : Constants.primary,
                              borderRadius: BorderRadius.circular(
                                  Dimensions.sizedBoxWidth10)),
                          margin: EdgeInsets.only(
                              right: e < 4 ? Dimensions.sizedBoxWidth10 * 2 : 0,
                              left:
                                  e == 5 ? Dimensions.sizedBoxWidth10 * 2 : 0),
                        );
                      }).toList(),
                    ),
                    SizedBox(
                      height: Dimensions.sizedBoxWidth15 * 4,
                    ),
                    SizedBox(
                      height: Dimensions.sizedBoxHeight100 * 2.8,
                      width: double.maxFinite,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [row1, row2, row3, row4].map((e) {
                          return Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: e.map((e) => Expanded(child: e)).toList(),
                          );
                        }).toList(),
                      ),
                    )
                  ],
                ),
              ],
            ),
          ),
        ),
      ]),
    );
  }

  Widget _showDialog(context, String txt) {
    return Dialog(
      backgroundColor: Colors.transparent,
      elevation: 0,
      insetPadding:
          EdgeInsets.symmetric(horizontal: Dimensions.sizedBoxWidth10 * 2),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Center(
            child: Text(txt, style: TextStyle(color: Constants.white, fontSize: Dimensions.font19, fontWeight: FontWeight.w500),),
          ),
        ],
      ),
    );
  }
}
