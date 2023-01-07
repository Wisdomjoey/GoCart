import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';

import '../../../CONSTANTS/constants.dart';
import '../../utils/dimensions.dart';
import '../../widgets/elevated_button_widget.dart';
import '../../widgets/head_section_widget.dart';

class ManageShopPage extends StatefulWidget {
  const ManageShopPage({super.key});

  @override
  State<ManageShopPage> createState() => _ManageShopPageState();
}

class _ManageShopPageState extends State<ManageShopPage> {
  final ImagePicker _picker = ImagePicker();
  // late List<XFile> images;
  // late XFile photo;
  List<CroppedFile> images = [];
  final double _height = Dimensions.pageViewContainer;
  GlobalKey<FormState> key = GlobalKey<FormState>();

  List<bool> disability = [false, false, false];
  List<String> tags = ['Tags', 'Product Price', 'Tags'];

  late TextEditingController textEditingController1;
  late TextEditingController textEditingController2;
  late TextEditingController tagController;

  late FocusNode focusNode1;
  late FocusNode focusNode2;

  @override
  void initState() {
    textEditingController1 = TextEditingController();
    textEditingController2 = TextEditingController();
    tagController = TextEditingController();

    textEditingController1.text = 'Example';
    textEditingController2.text = 'Example';

    focusNode1 = FocusNode();
    focusNode2 = FocusNode();

    super.initState();
  }

  @override
  void dispose() {
    textEditingController1.dispose();
    textEditingController2.dispose();
    tagController.dispose();

    focusNode1.dispose();
    focusNode2.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Constants.white,
      appBar: AppBar(
        title: Text(
          'Shop Details',
          style: TextStyle(fontSize: Dimensions.font23),
        ),
        backgroundColor: Constants.secondary,
        systemOverlayStyle: const SystemUiOverlayStyle(
            statusBarColor: Color.fromARGB(84, 0, 146, 63),
            statusBarBrightness: Brightness.light,
            statusBarIconBrightness: Brightness.light),
      ),
      body: SingleChildScrollView(
          child: Padding(
        padding: EdgeInsets.all(Dimensions.sizedBoxWidth15),
        child: Form(
          key: key,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  HeadSedction(
                    text: 'Shop Images',
                    tMargin: Dimensions.sizedBoxHeight10,
                    textSize: Dimensions.font16,
                  ),
                  IconButton(
                      onPressed: (() async {
                        await _getImage().then((value) async {
                          if (value == null) return;

                          await _cropImage(value.path).then((value) {
                            if (value == null) return;

                            setState(() {
                              images.add(value);
                            });
                          });
                        });
                      }),
                      icon: const Icon(
                        Icons.add_photo_alternate,
                        color: Color.fromARGB(255, 130, 130, 130),
                      ))
                ],
              ),
              SizedBox(
                height: Dimensions.sizedBoxHeight10,
              ),
              SizedBox(
                height: Dimensions.pageViewContainer,
                child: CarouselSlider.builder(
                  options: CarouselOptions(
                    height: _height,
                    viewportFraction: 0.9,
                    enableInfiniteScroll: false,
                    enlargeStrategy: CenterPageEnlargeStrategy.height,
                    scrollDirection: Axis.horizontal,
                    initialPage: 0,
                    enlargeCenterPage: true,
                    onPageChanged: (index, reason) {
                      // setState(() {
                      //   _currentPageValue = double.parse(index.toString());
                      // });
                    },
                  ),
                  itemCount: 5,
                  itemBuilder: (context, index, realIndex) {
                    return Constants(context).buildPageItem(index);
                    // return _buildPageItem(index);
                  },
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  HeadSedction(
                    text: 'Shop Name',
                    tMargin: Dimensions.sizedBoxHeight15 * 2,
                    textSize: Dimensions.font16,
                  ),
                  IconButton(
                      onPressed: (() {
                        setState(() {
                          disability[0] = true;
                        });
                      }),
                      icon: const Icon(
                        Icons.edit,
                        size: 20,
                        color: Constants.tetiary,
                      ))
                ],
              ),
              SizedBox(
                height: Dimensions.sizedBoxHeight10 / 2,
              ),
              TextFormField(
                controller: textEditingController1,
                focusNode: focusNode1,
                validator: (value) {
                  if (value == '') {
                    return Constants.err;
                  }

                  return null;
                },
                decoration: InputDecoration(
                  enabled: disability[0],
                  filled: true,
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  HeadSedction(
                    text: 'Shop Location',
                    tMargin: Dimensions.sizedBoxHeight15 * 2,
                    textSize: Dimensions.font16,
                  ),
                  IconButton(
                      onPressed: (() {
                        setState(() {
                          disability[1] = true;
                        });
                      }),
                      icon: const Icon(
                        Icons.edit,
                        size: 20,
                        color: Constants.tetiary,
                      ))
                ],
              ),
              SizedBox(
                height: Dimensions.sizedBoxHeight10 / 2,
              ),
              TextFormField(
                controller: textEditingController2,
                focusNode: focusNode2,
                validator: (value) {
                  if (value == '') {
                    return Constants.err;
                  }

                  return null;
                },
                decoration: InputDecoration(
                  enabled: disability[1],
                  filled: true,
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  HeadSedction(
                    text: 'Shop Tags',
                    tMargin: Dimensions.sizedBoxHeight15 * 2,
                    textSize: Dimensions.font16,
                  ),
                  IconButton(
                      onPressed: (() {
                        setState(() {
                          disability[2] = true;
                        });
                      }),
                      icon: const Icon(
                        Icons.edit,
                        size: 20,
                        color: Constants.tetiary,
                      ))
                ],
              ),
              SizedBox(
                height: Dimensions.sizedBoxHeight10 / 2,
              ),
              Wrap(
                spacing: 5,
                children: tags.map((e) {
                  return Chip(
                    backgroundColor: disability[2]
                        ? Constants.tetiary
                        : Constants.tetiary.withAlpha(150),
                    label: Text(
                      e,
                      style: const TextStyle(color: Constants.white),
                    ),
                    deleteIcon: const Icon(
                      Icons.close,
                      color: Constants.white,
                    ),
                    onDeleted: () {
                      if (disability[2]) {
                        setState(() {
                          int index = tags.indexOf(e);
                          tags.removeAt(index);
                        });
                      }
                    },
                  );
                }).toList(),
              ),
              SizedBox(
                height: Dimensions.sizedBoxHeight10 / 2,
              ),
              TextFormField(
                controller: tagController,
                decoration: InputDecoration(
                  labelText: 'Tags',
                  helperText: 'Add tags to make it easy to find your shop',
                  suffixIcon: Container(
                    width: Dimensions.sizedBoxWidth10 * 6,
                    padding: EdgeInsets.symmetric(
                      vertical: Dimensions.sizedBoxHeight4,
                    ),
                    margin: EdgeInsets.only(right: Dimensions.sizedBoxWidth10),
                    child: ElevatedBtn(
                      text: 'Add',
                      bgColor: disability[2]
                          ? Constants.primary
                          : Constants.primary.withAlpha(155),
                      disabled: !disability[2],
                      pressed: () {
                        if (disability[2]) {
                          if (tagController.text == '') {
                            setState(() {
                              // tagErr = 'You cant\'t add empty tags';
                            });
                          } else {
                            setState(() {
                              tags.add(tagController.text);
                              tagController.clear();
                              // tagErr = null;
                            });
                          }
                        }
                      },
                    ),
                  ),
                  enabled: disability[2],
                  filled: true,
                ),
              ),
              SizedBox(
                height: Dimensions.sizedBoxWidth10 * 2,
              ),
              SizedBox(
                width: double.maxFinite,
                height: Dimensions.sizedBoxHeight100 / 2,
                child: ElevatedBtn(
                  text: 'UPDATE',
                  pressed: () {
                    if (key.currentState!.validate()) {
                      if (images.isEmpty) {
                        Get.showSnackbar(GetSnackBar(
                          message: 'Please add at least one image!',
                          snackPosition: SnackPosition.TOP,
                          backgroundColor: Colors.red,
                          duration: Duration(seconds: 7),
                          borderRadius: Dimensions.sizedBoxWidth4,
                          margin: EdgeInsets.only(
                              bottom: Dimensions.sizedBoxHeight15,
                              right: Dimensions.sizedBoxWidth10,
                              left: Dimensions.sizedBoxWidth10),
                        ));
                      } else {}
                    }
                  },
                ),
              )
            ],
          ),
        ),
      )),
    );
  }

  Future<XFile?> _getImage() async {
    return await _picker.pickImage(source: ImageSource.gallery);
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
