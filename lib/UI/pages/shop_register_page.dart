import 'dart:async';

import 'package:GOCart/UI/utils/dimensions.dart';
import 'package:GOCart/UI/widgets/elevated_button_widget.dart';
import 'package:GOCart/UI/widgets/txt_button_widget.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

import '../routes/route_helper.dart';

class ShopRegisterPage extends StatefulWidget {
  const ShopRegisterPage({super.key});

  @override
  State<ShopRegisterPage> createState() => _ShopRegisterPageState();
}

class _ShopRegisterPageState extends State<ShopRegisterPage> {
  ImagePicker _picker = ImagePicker();
  late List<XFile> images;
  late XFile photo;
  final GlobalKey<ScaffoldState> _key = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      key: _key,
      body: SizedBox(
        width: double.maxFinite,
        height: double.maxFinite,
        child: Column(
          children: [
            Container(
              padding: EdgeInsets.symmetric(
                  horizontal: Dimensions.sizedBoxWidth15,
                  vertical: Dimensions.sizedBoxHeight100 / 2),
              child: Stack(
                alignment: Alignment.bottomCenter,
                children: [
                  Align(
                    alignment: Alignment.centerRight,
                    child: Container(
                      width: Dimensions.sizedBoxHeight100 * 2.5,
                      height: Dimensions.sizedBoxHeight100 * 2.5,
                      decoration: const BoxDecoration(
                          image: DecorationImage(
                              image: AssetImage('assets/images/shops.png'),
                              fit: BoxFit.contain)),
                    ),
                  ),
                  Align(
                    alignment: Alignment.bottomLeft,
                    child: Container(
                      margin: EdgeInsets.only(
                          bottom: Dimensions.sizedBoxHeight10 * 2),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Do You',
                            style: TextStyle(
                                fontSize: Dimensions.font12 * 3,
                                shadows: const [
                                  Shadow(
                                      color: Color.fromARGB(255, 98, 98, 98),
                                      offset: Offset(2, 2),
                                      blurRadius: 3)
                                ],
                                fontWeight: FontWeight.w800,
                                color: const Color(0XFFF8C300)),
                          ),
                          Text(
                            'Own a Shop?',
                            style: TextStyle(
                                fontSize: Dimensions.font12 * 3,
                                shadows: const [
                                  Shadow(
                                      color: Color.fromARGB(255, 98, 98, 98),
                                      offset: Offset(2, 2),
                                      blurRadius: 3)
                                ],
                                fontWeight: FontWeight.w800,
                                color: const Color(0XFFF8C300)),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(
                      height: Dimensions.sizedBoxHeight15 * 2,
                    ),
                    Container(
                      padding: EdgeInsets.symmetric(
                          horizontal: Dimensions.sizedBoxWidth10 * 2),
                      width: double.maxFinite,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          TextFormField(
                            decoration: InputDecoration(
                                enabledBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(
                                        Dimensions.sizedBoxWidth15 * 2),
                                    borderSide: const BorderSide(
                                        color: Colors.transparent)),
                                filled: true,
                                hintStyle:
                                    TextStyle(fontSize: Dimensions.font15),
                                labelStyle:
                                    TextStyle(fontSize: Dimensions.font15),
                                fillColor:
                                    const Color.fromARGB(255, 242, 242, 242),
                                contentPadding: EdgeInsets.symmetric(
                                    horizontal: Dimensions.sizedBoxWidth10 * 2),
                                floatingLabelStyle:
                                    const TextStyle(color: Color(0XFFF8C300)),
                                icon: const Icon(
                                  Icons.storefront,
                                  color: Colors.grey,
                                ),
                                focusColor: const Color(0XFFF8C300),
                                focusedBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(
                                        Dimensions.sizedBoxWidth15 * 2),
                                    borderSide: const BorderSide(
                                        color: Color(0XFFF8C300))),
                                hintText: 'e.g. John\'s Snack Shop',
                                labelText: 'Shop\'s name'),
                            cursorColor: const Color(0XFFF8C300),
                          ),
                          SizedBox(
                            height: Dimensions.sizedBoxHeight10 * 2,
                          ),
                          TextFormField(
                            decoration: InputDecoration(
                                enabledBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(
                                        Dimensions.sizedBoxWidth15 * 2),
                                    borderSide: const BorderSide(
                                        color: Colors.transparent)),
                                filled: true,
                                hintStyle:
                                    TextStyle(fontSize: Dimensions.font15),
                                labelStyle:
                                    TextStyle(fontSize: Dimensions.font15),
                                fillColor:
                                    const Color.fromARGB(255, 242, 242, 242),
                                contentPadding: EdgeInsets.symmetric(
                                    horizontal: Dimensions.sizedBoxWidth10 * 2),
                                floatingLabelStyle:
                                    const TextStyle(color: Color(0XFFF8C300)),
                                icon: const Icon(
                                  Icons.location_on_outlined,
                                  color: Colors.grey,
                                ),
                                focusColor: const Color(0XFFF8C300),
                                focusedBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(
                                        Dimensions.sizedBoxWidth15 * 2),
                                    borderSide: const BorderSide(
                                        color: Color(0XFFF8C300))),
                                hintText: 'e.g. shop 12 Bakasi hall',
                                labelText: 'Location'),
                            cursorColor: const Color(0XFFF8C300),
                          ),
                          SizedBox(
                            height: Dimensions.sizedBoxHeight10 * 2,
                          ),
                          TextFormField(
                            decoration: InputDecoration(
                                enabledBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(
                                        Dimensions.sizedBoxWidth15 * 2),
                                    borderSide: const BorderSide(
                                        color: Colors.transparent)),
                                filled: true,
                                hintStyle:
                                    TextStyle(fontSize: Dimensions.font15),
                                labelStyle:
                                    TextStyle(fontSize: Dimensions.font15),
                                fillColor:
                                    const Color.fromARGB(255, 242, 242, 242),
                                contentPadding: EdgeInsets.symmetric(
                                    horizontal: Dimensions.sizedBoxWidth10 * 2),
                                floatingLabelStyle:
                                    const TextStyle(color: Color(0XFFF8C300)),
                                icon: const Icon(
                                  Icons.label_outline,
                                  color: Colors.grey,
                                ),
                                focusColor: const Color(0XFFF8C300),
                                focusedBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(
                                        Dimensions.sizedBoxWidth15 * 2),
                                    borderSide: const BorderSide(
                                        color: Color(0XFFF8C300))),
                                hintText: 'e.g. tag1 tag2',
                                helperText:
                                    'Add tags so as to make it easier for buyers to find your products. Seperate your tags with a space.',
                                helperMaxLines: 2,
                                labelText: 'Add Tags'),
                            cursorColor: const Color(0XFFF8C300),
                          ),
                          SizedBox(
                            height: Dimensions.sizedBoxHeight10 * 2,
                          ),
                          SizedBox(
                            // height: Dimensions.sizedBoxHeight10 * 4,
                            width: Dimensions.sizedBoxWidth100 * 1.1,
                            child: ElevatedBtn(
                              text: 'Upload Image',
                              visualVD: -2,
                              visualHD: -4,
                              isElevated: false,
                              radius: 0,
                              pressed: () {
                                _key.currentState?.showBottomSheet(
                                    (context) => _buildBottomSheet(context));
                              },
                            ),
                          ),
                          SizedBox(
                            height: Dimensions.sizedBoxHeight10 / 2,
                          ),
                          Text(
                            'Upload images to represent your shop e.g. pictures of your shop or products.',
                            style: TextStyle(
                                color: const Color.fromARGB(255, 107, 107, 107),
                                fontSize: Dimensions.font12),
                          ),
                          SizedBox(
                            height: Dimensions.sizedBoxHeight100 / 4,
                          ),
                          SizedBox(
                            width: double.maxFinite,
                            child: ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                  padding:
                                      const EdgeInsets.symmetric(horizontal: 0),
                                  disabledForegroundColor: Colors.transparent,
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(
                                          Dimensions.sizedBoxWidth15 * 2)),
                                  backgroundColor: Colors.transparent),
                              child: Ink(
                                width: double.maxFinite,
                                padding: EdgeInsets.symmetric(
                                    vertical: Dimensions.sizedBoxHeight15),
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(
                                        Dimensions.sizedBoxWidth15 * 2),
                                    gradient: const LinearGradient(colors: [
                                      Color(0XFF00923F),
                                      Color.fromARGB(255, 1, 191, 84)
                                    ])),
                                child: Center(
                                  child: Text(
                                    'Complete Sign Up',
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontSize: Dimensions.font20),
                                  ),
                                ),
                              ),
                              onPressed: () {
                                Timer(
                                    const Duration(milliseconds: 200),
                                    () => Get.toNamed(
                                        RouteHelper.getRoutePage(0)));
                              },
                            ),
                          ),
                        ],
                      ),
                    )
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget _buildBottomSheet(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(Dimensions.sizedBoxWidth10 * 2),
      decoration: const BoxDecoration(color: Colors.white, boxShadow: [
        BoxShadow(color: Colors.grey, offset: Offset(-5, 0), blurRadius: 10)
      ]),
      height: Dimensions.sizedBoxHeight100 * 1.5,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              SizedBox(
                width: Dimensions.sizedBoxWidth10 * 7,
                height: Dimensions.sizedBoxWidth10 * 7,
                child: GestureDetector(
                  onTap: (() => _picker.pickImage(source: ImageSource.camera)),
                  child: Center(
                    child: Column(
                      children: [
                        const Icon(
                          Icons.camera_alt,
                          color: Colors.grey,
                        ),
                        SizedBox(
                          height: Dimensions.sizedBoxHeight10,
                        ),
                        Text(
                          'Take a shot',
                          textAlign: TextAlign.center,
                          style: TextStyle(fontSize: Dimensions.font12),
                        )
                      ],
                    ),
                  ),
                ),
              ),
              SizedBox(
                width: Dimensions.sizedBoxWidth10 * 7,
                height: Dimensions.sizedBoxWidth10 * 7,
                child: GestureDetector(
                  onTap: (() => _picker.pickMultiImage()),
                  child: Center(
                    child: Column(
                      children: [
                        const Icon(
                          Icons.storage,
                          color: Colors.grey,
                        ),
                        SizedBox(
                          height: Dimensions.sizedBoxHeight10,
                        ),
                        Text(
                          'Pick from storage',
                          textAlign: TextAlign.center,
                          style: TextStyle(fontSize: Dimensions.font12),
                        )
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              GestureDetector(
                child: Text(
                  'Cancel',
                  style: TextStyle(fontSize: Dimensions.font18),
                ),
                onTap: () => Navigator.pop(context),
              )
            ],
          )
        ],
      ),
    );
  }
}
