import 'package:GOCart/UI/utils/dimensions.dart';
import 'package:GOCart/UI/widgets/elevated_button_widget.dart';
import 'package:GOCart/UI/widgets/head_section_widget.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';

import '../../../CONSTANTS/constants.dart';

class AddProductPage extends StatefulWidget {
  const AddProductPage({super.key});

  @override
  State<AddProductPage> createState() => _AddProductPageState();
}

class _AddProductPageState extends State<AddProductPage> {
  bool _switch = false;
  final ImagePicker _picker = ImagePicker();
  // late List<XFile> images;
  // late XFile photo;
  List<CroppedFile> images = [];
  List<String> tags = [];
  GlobalKey<FormState> key = GlobalKey<FormState>();

  String dropdownValue = '';
  String? errMsg = Constants.err;
  String? tagErr;

  late TextEditingController textEditingController1;
  late TextEditingController textEditingController2;
  late TextEditingController textEditingController3;
  late TextEditingController textEditingController4;
  late TextEditingController textEditingController5;
  late TextEditingController textEditingController6;
  late TextEditingController textEditingController7;
  late TextEditingController textEditingController8;
  late TextEditingController tagController;

  late FocusNode focusNode1;
  late FocusNode focusNode2;
  late FocusNode focusNode3;
  late FocusNode focusNode4;
  late FocusNode focusNode5;
  late FocusNode focusNode6;

  @override
  void initState() {
    textEditingController1 = TextEditingController();
    textEditingController2 = TextEditingController();
    textEditingController3 = TextEditingController();
    textEditingController4 = TextEditingController();
    textEditingController5 = TextEditingController();
    textEditingController6 = TextEditingController();
    textEditingController7 = TextEditingController();
    textEditingController8 = TextEditingController();
    tagController = TextEditingController();

    focusNode1 = FocusNode();
    focusNode2 = FocusNode();
    focusNode3 = FocusNode();
    focusNode4 = FocusNode();
    focusNode5 = FocusNode();
    focusNode6 = FocusNode();

    super.initState();
  }

  @override
  void dispose() {
    textEditingController1.dispose();
    textEditingController2.dispose();
    textEditingController3.dispose();
    textEditingController4.dispose();
    textEditingController5.dispose();
    textEditingController6.dispose();
    textEditingController7.dispose();
    textEditingController8.dispose();
    tagController.dispose();

    focusNode1.dispose();
    focusNode2.dispose();
    focusNode3.dispose();
    focusNode4.dispose();
    focusNode5.dispose();
    focusNode6.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Constants.white,
      appBar: AppBar(
        title: Text(
          'Add Product',
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
                      text: 'Add Product Image *',
                      tMargin: Dimensions.sizedBoxHeight10,
                      textSize: Dimensions.font16,
                    ),
                    IconButton(
                        onPressed: (() async {
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
                        icon: const Icon(
                          Icons.add_a_photo,
                          color: Color.fromARGB(255, 130, 130, 130),
                        ))
                  ],
                ),
                SizedBox(
                  height: Dimensions.sizedBoxHeight10,
                ),
                DottedBorder(
                  borderType: BorderType.RRect,
                  color: const Color.fromARGB(255, 130, 130, 130),
                  strokeWidth: 2,
                  dashPattern: const [10, 5],
                  radius: Radius.circular(Dimensions.sizedBoxWidth10 / 2),
                  child: ClipRRect(
                    borderRadius: BorderRadius.all(
                        Radius.circular(Dimensions.sizedBoxWidth10 / 2)),
                    child: SizedBox(
                      width: double.maxFinite,
                      height: Dimensions.sizedBoxHeight100 * 2,
                      child: Center(
                        child: GestureDetector(
                          onTap: (() async {
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
                          child: Icon(
                            Icons.add_photo_alternate_rounded,
                            color: Colors.grey,
                            size: Dimensions.font17 * 2,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
                HeadSedction(
                  text: 'Add Product Name *',
                  tMargin: Dimensions.sizedBoxHeight15 * 2,
                  textSize: Dimensions.font16,
                ),
                SizedBox(
                  height: Dimensions.sizedBoxHeight10 / 2,
                ),
                TextFormField(
                  controller: textEditingController1,
                  focusNode: focusNode1,
                  validator: (value) {
                    if (value == '') {
                      return errMsg;
                    } else {
                      return null;
                    }
                  },
                  decoration: InputDecoration(
                      labelText: 'Name',
                      border: OutlineInputBorder(
                          borderSide: const BorderSide(color: Constants.grey),
                          borderRadius: BorderRadius.all(
                              Radius.circular(Dimensions.sizedBoxWidth4)))),
                ),
                HeadSedction(
                  text: 'Add Product Category *',
                  tMargin: Dimensions.sizedBoxHeight15 * 2,
                  textSize: Dimensions.font16,
                ),
                SizedBox(
                  height: Dimensions.sizedBoxHeight10 / 2,
                ),
                DropdownButtonFormField(
                    decoration: InputDecoration(
                        border: OutlineInputBorder(
                            borderSide: const BorderSide(color: Constants.grey),
                            borderRadius: BorderRadius.all(
                                Radius.circular(Dimensions.sizedBoxWidth4)))),
                    value: Constants.categories[0],
                    items: Constants.categories
                        .map((e) => DropdownMenuItem(
                              child: Text(e),
                              value: e,
                            ))
                        .toList(),
                    menuMaxHeight: Dimensions.sizedBoxHeight320,
                    onChanged: ((dynamic value) {})),
                HeadSedction(
                  text: 'Add Product Description *',
                  tMargin: Dimensions.sizedBoxHeight15 * 2,
                  textSize: Dimensions.font16,
                ),
                SizedBox(
                  height: Dimensions.sizedBoxHeight10 / 2,
                ),
                TextFormField(
                  controller: textEditingController2,
                  focusNode: focusNode2,
                  validator: (value) {
                    if (value == '') {
                      return errMsg;
                    } else {
                      return null;
                    }
                  },
                  maxLines: 8,
                  decoration: InputDecoration(
                      labelText: 'Description',
                      alignLabelWithHint: true,
                      hintText: 'Type something...',
                      counterText: '0/500 characters',
                      border: OutlineInputBorder(
                          borderSide: const BorderSide(color: Constants.grey),
                          borderRadius: BorderRadius.all(
                              Radius.circular(Dimensions.sizedBoxWidth4)))),
                ),
                HeadSedction(
                  text: 'Add Product Price *',
                  tMargin: Dimensions.sizedBoxHeight15 * 2,
                  textSize: Dimensions.font16,
                ),
                SizedBox(
                  height: Dimensions.sizedBoxHeight10 / 2,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text(
                        'Do you want to add a discount to this product?'),
                    Switch(
                        value: _switch,
                        activeColor: Constants.tetiary,
                        onChanged: ((value) {
                          setState(() {
                            _switch = !_switch;
                          });
                        })),
                  ],
                ),
                SizedBox(
                  height: Dimensions.sizedBoxHeight10,
                ),
                TextFormField(
                  controller: textEditingController3,
                  focusNode: focusNode3,
                  validator: (value) {
                    if (value == '') {
                      return errMsg;
                    } else {
                      return null;
                    }
                  },
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(
                      labelText: 'Min-price',
                      helperText: 'Minimum price for selling food.',
                      hintText: '100',
                      prefix: SizedBox(
                          width: Dimensions.sizedBoxWidth15,
                          child: const Text('\$')),
                      suffixText: 'NGN',
                      border: OutlineInputBorder(
                          borderSide: const BorderSide(color: Constants.grey),
                          borderRadius: BorderRadius.all(
                              Radius.circular(Dimensions.sizedBoxWidth4)))),
                ),
                SizedBox(
                  height: Dimensions.sizedBoxHeight10,
                ),
                _switch
                    ? (TextFormField(
                        controller: textEditingController4,
                        focusNode: focusNode4,
                        validator: (value) {
                          if (value == '') {
                            return errMsg;
                          } else {
                            return null;
                          }
                        },
                        keyboardType: TextInputType.number,
                        decoration: InputDecoration(
                            labelText: 'Old-price',
                            hintText: '100',
                            prefix: SizedBox(
                                width: Dimensions.sizedBoxWidth15,
                                child: const Text('\$')),
                            suffixText: 'NGN',
                            border: OutlineInputBorder(
                                borderSide:
                                    const BorderSide(color: Constants.grey),
                                borderRadius: BorderRadius.all(Radius.circular(
                                    Dimensions.sizedBoxWidth4)))),
                      ))
                    : Container(),
                SizedBox(
                  height: Dimensions.sizedBoxHeight10,
                ),
                TextFormField(
                  controller: textEditingController5,
                  focusNode: focusNode5,
                  validator: (value) {
                    if (value == '') {
                      return errMsg;
                    } else {
                      return null;
                    }
                  },
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(
                      labelText: _switch ? 'New-price' : 'Price',
                      hintText: '100',
                      prefix: SizedBox(
                          width: Dimensions.sizedBoxWidth15,
                          child: const Text('\$')),
                      suffixText: 'NGN',
                      border: OutlineInputBorder(
                          borderSide: const BorderSide(color: Constants.grey),
                          borderRadius: BorderRadius.all(
                              Radius.circular(Dimensions.sizedBoxWidth4)))),
                ),
                HeadSedction(
                  text: 'Add Product Tags (optional)',
                  tMargin: Dimensions.sizedBoxHeight15 * 2,
                  textSize: Dimensions.font16,
                ),
                SizedBox(
                  height: Dimensions.sizedBoxHeight10 / 2,
                ),
                Wrap(
                  spacing: 5,
                  children: tags.map((e) {
                    return Chip(
                      backgroundColor: Constants.tetiary,
                      label: Text(
                        e,
                        style: const TextStyle(color: Constants.white),
                      ),
                      deleteIcon: const Icon(
                        Icons.close,
                        color: Constants.white,
                      ),
                      onDeleted: () {
                        setState(() {
                          int index = tags.indexOf(e);
                          tags.removeAt(index);
                        });
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
                      hintText: 'e.g. fashion',
                      errorText: tagErr,
                      helperText:
                          'Add tags to make it easy to find your product',
                      suffixIcon: Container(
                        width: Dimensions.sizedBoxWidth10 * 6,
                        padding: EdgeInsets.symmetric(
                          vertical: Dimensions.sizedBoxHeight4,
                        ),
                        margin:
                            EdgeInsets.only(right: Dimensions.sizedBoxWidth10),
                        child: ElevatedBtn(
                          text: 'Add',
                          bgColor: Colors.green,
                          pressed: () {
                            if (tagController.text == '') {
                              setState(() {
                                tagErr = 'You cant\'t add empty tags';
                              });
                            } else {
                              setState(() {
                                tags.add(tagController.text);
                                tagController.clear();
                                tagErr = null;
                              });
                            }
                          },
                        ),
                      ),
                      border: OutlineInputBorder(
                          borderSide: const BorderSide(color: Constants.grey),
                          borderRadius: BorderRadius.all(
                              Radius.circular(Dimensions.sizedBoxWidth4)))),
                ),
                HeadSedction(
                  text: 'Additional Details *',
                  tMargin: Dimensions.sizedBoxHeight15 * 2,
                  textSize: Dimensions.font16,
                ),
                SizedBox(
                  height: Dimensions.sizedBoxHeight10 / 2,
                ),
                Row(
                  children: [
                    Expanded(
                      child: TextFormField(
                        controller: textEditingController6,
                        focusNode: focusNode6,
                        validator: (value) {
                          if (value == '') {
                            return errMsg;
                          } else {
                            return null;
                          }
                        },
                        keyboardType: TextInputType.number,
                        decoration: const InputDecoration(
                          labelText: 'Total Stock',
                          hintText: '50',
                        ),
                      ),
                    ),
                    SizedBox(
                      width: Dimensions.sizedBoxWidth10 * 2,
                    ),
                    Expanded(
                      child: TextFormField(
                        keyboardType: TextInputType.number,
                        decoration: InputDecoration(
                          labelText: 'Delivery Price',
                          hintText: '100',
                          prefix: SizedBox(
                              width: Dimensions.sizedBoxWidth15,
                              child: const Text('\$')),
                          suffixText: 'NGN',
                        ),
                      ),
                    ),
                  ],
                ),
                HeadSedction(
                  text: 'Add Product Specification (optional)',
                  tMargin: Dimensions.sizedBoxHeight15 * 2,
                  textSize: Dimensions.font16,
                ),
                SizedBox(
                  height: Dimensions.sizedBoxHeight10 / 2,
                ),
                TextFormField(
                  controller: textEditingController7,
                  maxLines: 8,
                  decoration: InputDecoration(
                      labelText: 'Specifications',
                      alignLabelWithHint: true,
                      hintText: 'Type something...',
                      helperText: 'Seperate with commas',
                      border: OutlineInputBorder(
                          borderSide: const BorderSide(color: Constants.grey),
                          borderRadius: BorderRadius.all(
                              Radius.circular(Dimensions.sizedBoxWidth4)))),
                ),
                HeadSedction(
                  text: 'Add Product KeyFeatures (optional)',
                  tMargin: Dimensions.sizedBoxHeight15 * 2,
                  textSize: Dimensions.font16,
                ),
                SizedBox(
                  height: Dimensions.sizedBoxHeight10 / 2,
                ),
                TextFormField(
                  controller: textEditingController8,
                  maxLines: 8,
                  decoration: InputDecoration(
                      labelText: 'KeyFeatures',
                      alignLabelWithHint: true,
                      hintText: 'Type something...',
                      helperText: 'Seperate with commas',
                      border: OutlineInputBorder(
                          borderSide: const BorderSide(color: Constants.grey),
                          borderRadius: BorderRadius.all(
                              Radius.circular(Dimensions.sizedBoxWidth4)))),
                ),
                SizedBox(
                  height: Dimensions.sizedBoxWidth10 * 2,
                ),
                SizedBox(
                  width: double.maxFinite,
                  height: Dimensions.sizedBoxHeight100 / 2,
                  child: ElevatedBtn(
                    text: 'SUBMIT',
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
        ),
      ),
    );
  }

  Future<XFile?> _getImage() async {
    return await _picker.pickImage(source: ImageSource.gallery);
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
