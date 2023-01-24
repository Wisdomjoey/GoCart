import 'dart:async';

import 'package:GOCart/PROVIDERS/auth_provider.dart';
import 'package:GOCart/PROVIDERS/shop_provider.dart';
import 'package:GOCart/UI/utils/dimensions.dart';
import 'package:GOCart/UI/utils/validator.dart';
import 'package:GOCart/UI/widgets/elevated_button_widget.dart';
import 'package:GOCart/UI/widgets/text_form_field_widget.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';

import '../../CONSTANTS/constants.dart';
import '../../PROVIDERS/cart_provider.dart';
import '../routes/route_helper.dart';

class ShopRegisterPage extends StatefulWidget {
  const ShopRegisterPage({super.key});

  @override
  State<ShopRegisterPage> createState() => _ShopRegisterPageState();
}

class _ShopRegisterPageState extends State<ShopRegisterPage> {
  final ImagePicker _picker = ImagePicker();
  // late List<XFile> images;
  // late XFile photo;
  List<CroppedFile> images = [];
  List<String> shopCategories = [];
  List<String> tags = [];

  final GlobalKey<ScaffoldState> _key = GlobalKey<ScaffoldState>();
  final GlobalKey<FormState> key = GlobalKey<FormState>();

  late TextEditingController controller1;
  late TextEditingController controller2;
  late TextEditingController controller3;

  late FocusNode node1;
  late FocusNode node2;
  late FocusNode node3;

  Map<String, dynamic> checked = {};

  @override
  void initState() {
    controller1 = TextEditingController();
    controller2 = TextEditingController();
    controller3 = TextEditingController();

    node1 = FocusNode();
    node2 = FocusNode();
    node3 = FocusNode();

    for (var element in Constants.shopCategory) {
      checked.addAll({element: false});
    }

    super.initState();
  }

  @override
  void dispose() {
    controller1.dispose();
    controller2.dispose();
    controller3.dispose();

    node1.dispose();
    node2.dispose();
    node3.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Constants.white,
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
                                color: Constants.tetiary),
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
                                color: Constants.tetiary),
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
                      margin:
                          EdgeInsets.only(bottom: Dimensions.sizedBoxHeight15),
                      padding: EdgeInsets.symmetric(
                          horizontal: Dimensions.sizedBoxWidth10 * 2),
                      width: double.maxFinite,
                      child: Form(
                        key: key,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            TextFormFieldWidget(
                              controller: controller1,
                              node: node1,
                              label: 'Shop\'s name',
                              hint: 'e.g. John\'s Snack Shop',
                              icon: const Icon(
                                Icons.storefront,
                                color: Constants.grey,
                              ),
                            ),
                            TextFormFieldWidget(
                              controller: controller2,
                              node: node2,
                              label: 'Location',
                              hint: 'e.g. shop 12 Bakasi hall',
                              icon: const Icon(
                                Icons.location_on_outlined,
                                color: Constants.grey,
                              ),
                            ),
                            TextFormFieldWidget(
                              controller: controller3,
                              node: node3,
                              label: 'Add Tags',
                              hint: 'e.g. tag1 tag2',
                              error: 'Tags should contain only letters',
                              help:
                                  'Add tags so as to make it easier for buyers to find your products. Seperate your tags with a space.',
                              helpMax: 2,
                              val: () => isTagsValid(controller3.text),
                              icon: const Icon(
                                Icons.label_outlined,
                                color: Constants.grey,
                              ),
                            ),
                            SizedBox(
                              height: Dimensions.sizedBoxHeight10 / 2,
                            ),
                            Column(
                              children: [
                                const Text(
                                    'Select your shop\'s category, you can select more than one'),
                                Column(
                                  children: Constants.shopCategory.map((e) {
                                    return CheckboxListTile(
                                      value: checked[e],
                                      onChanged: ((value) {
                                        setState(() {
                                          checked[e] = value;
                                          shopCategories.add(
                                              Constants.shopCategoryV[Constants
                                                  .shopCategory
                                                  .indexOf(e)]);
                                        });
                                      }),
                                      title: Text(e),
                                    );
                                  }).toList(),
                                )
                              ],
                            ),
                            SizedBox(
                              height: Dimensions.sizedBoxHeight10 / 2,
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
                                      backgroundColor:
                                          const Color.fromARGB(23, 0, 0, 0),
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
                                  color:
                                      const Color.fromARGB(255, 107, 107, 107),
                                  fontSize: Dimensions.font12),
                            ),
                            SizedBox(
                              height: Dimensions.sizedBoxHeight100 / 4,
                            ),
                            SizedBox(
                              width: double.maxFinite,
                              child: ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 0),
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
                                        Constants.secondary,
                                        Color.fromARGB(255, 1, 191, 84)
                                      ])),
                                  child: Center(
                                    child: Provider.of<ShopProvider>(context)
                                                .load ==
                                            Load.processing
                                        ? SizedBox(
                                            width:
                                                Dimensions.sizedBoxWidth10 * 2,
                                            height:
                                                Dimensions.sizedBoxWidth10 * 2,
                                            child:
                                                const CircularProgressIndicator(
                                              color: Constants.white,
                                              strokeWidth: 3,
                                            ))
                                        : Text(
                                            'Complete Sign Up',
                                            style: TextStyle(
                                                color: Constants.white,
                                                fontSize: Dimensions.font20),
                                          ),
                                  ),
                                ),
                                onPressed: () async {
                                  if (shopCategories.isEmpty) {
                                    Constants(context).snackBar(
                                        'Please add at least one category',
                                        Colors.red);
                                  } else {
                                    if (images.isEmpty) {
                                      Constants(context).snackBar(
                                          'Please add at least one image',
                                          Colors.red);
                                    } else {
                                      if (key.currentState!.validate()) {
                                        tags =
                                            controller3.text.trim().split(' ');

                                        await Provider.of<ShopProvider>(context,
                                                listen: false)
                                            .createShop(
                                                controller1.text
                                                    .trim(),
                                                controller2.text.trim(),
                                                tags,
                                                images,
                                                FirebaseAuth
                                                    .instance.currentUser!.uid,
                                                shopCategories,
                                                context)
                                            .then((value) async {
                                          if (value) {
                                            await Provider.of<CartProvider>(
                                                    context,
                                                    listen: false)
                                                .getCart(FirebaseAuth
                                                    .instance.currentUser!.uid)
                                                .then((value) async {
                                              await Provider.of<CartProvider>(
                                                      context,
                                                      listen: false)
                                                  .getFoodCart(FirebaseAuth
                                                      .instance
                                                      .currentUser!
                                                      .uid)
                                                  .then((value) async {
                                                await Provider.of<ShopProvider>(
                                                        context,
                                                        listen: false)
                                                    .fetchAllShops()
                                                    .then((value) {
                                                  if (Provider.of<AuthProvider>(
                                                          context, listen: false)
                                                      .isPhoneVerified) {
                                                    Get.offNamed(
                                                        RouteHelper
                                                            .getRoutePage(),
                                                        arguments: 0);
                                                  } else {
                                                    Get.offNamed(RouteHelper
                                                        .getPhoneRegisterPage());
                                                  }
                                                });
                                              });
                                            });
                                          }
                                        });
                                      }
                                    }
                                  }
                                },
                              ),
                            ),
                          ],
                        ),
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
    return SizedBox(
      width: double.maxFinite,
      height: double.maxFinite,
      child: Align(
        alignment: Alignment.bottomCenter,
        child: Container(
          padding: EdgeInsets.all(Dimensions.sizedBoxWidth10 * 2),
          decoration: const BoxDecoration(color: Constants.white, boxShadow: [
            BoxShadow(
                color: Constants.grey, offset: Offset(-5, 0), blurRadius: 10)
          ]),
          height: Dimensions.sizedBoxHeight100 * 1.5,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  GestureDetector(
                    onTap: (() async {
                      await _getCamImage().then((value) async {
                        if (value == null) return;

                        await _cropImage(value.path).then((value) {
                          if (value == null) return;

                          setState(() {
                            images.add(value);
                          });
                        });
                      });
                    }),
                    child: SizedBox(
                      width: Dimensions.sizedBoxWidth10 * 7,
                      height: Dimensions.sizedBoxWidth10 * 7,
                      child: Center(
                        child: Column(
                          children: [
                            const Icon(
                              Icons.camera_alt,
                              color: Constants.grey,
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
                    width: Dimensions.sizedBoxWidth10,
                  ),
                  GestureDetector(
                    onTap: (() async {
                      await _getImage().then((value) async {
                        for (var element in value) {
                          await _cropImage(element!.path).then((value) {
                            if (value == null) return;

                            setState(() {
                              images.add(value);
                            });
                          });
                        }
                      });
                    }),
                    child: SizedBox(
                      width: Dimensions.sizedBoxWidth10 * 7,
                      height: Dimensions.sizedBoxWidth10 * 7,
                      child: Center(
                        child: Column(
                          children: [
                            const Icon(
                              Icons.storage,
                              color: Constants.grey,
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
        ),
      ),
    );
  }

  Future<List<XFile?>> _getImage() async {
    return await _picker.pickMultiImage();
  }

  Future<XFile?> _getCamImage() async {
    return await _picker.pickImage(source: ImageSource.camera);
  }

  Future<CroppedFile?> _cropImage(String path) async {
    return await ImageCropper().cropImage(sourcePath: path, uiSettings: [
      AndroidUiSettings(
          toolbarColor: Constants.primary,
          toolbarWidgetColor: Constants.white,
          lockAspectRatio: false),
    ]);
  }
}
