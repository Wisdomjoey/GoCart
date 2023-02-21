import 'package:GOCart/CONSTANTS/constants.dart';
import 'package:GOCart/UI/utils/dimensions.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class OrderCompletePage extends StatelessWidget {
  const OrderCompletePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
			body: SizedBox(
        width: double.maxFinite,
        height: double.maxFinite,
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: Dimensions.sizedBoxWidth15),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                width: Dimensions.sizedBoxWidth100 * 2.5,
                height: Dimensions.sizedBoxWidth100 * 2.5,
                decoration: const BoxDecoration(
                    image: DecorationImage(
                        image: AssetImage('assets/images/Delivery.png'), fit: BoxFit.cover)),
              ),
              SizedBox(
                height: Dimensions.sizedBoxHeight10,
              ),
              Text(
                'Your order has been placed successfully, you\'ll get a call shortly from the supplier',
                textAlign: TextAlign.center,
                style: TextStyle(color: Constants.grey, fontSize: Dimensions.font16),
              ),
							SizedBox(height: Dimensions.sizedBoxHeight10 / 2,),
              GestureDetector(
                onTap: () => Navigator.pop(context),
                child: const Text(
                  'Go Back',
                  style: TextStyle(
                      color: Constants.primary,
                      decoration: TextDecoration.underline),
                ),
              )
            ],
          ),
        ),
      ),
		);
  }
}
