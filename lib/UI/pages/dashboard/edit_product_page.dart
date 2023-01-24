import 'package:GOCart/PROVIDERS/product_provider.dart';
import 'package:carousel_slider/carousel_options.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';

import '../../../CONSTANTS/constants.dart';
import '../../utils/dimensions.dart';
import '../../widgets/elevated_button_widget.dart';
import '../../widgets/head_section_widget.dart';

class EditProductPage extends StatefulWidget {
  final Map<String, dynamic> data;

  const EditProductPage({super.key, required this.data});

  @override
  State<EditProductPage> createState() => _EditProductPageState();
}

class _EditProductPageState extends State<EditProductPage> {
  bool _switch = false;
  final ImagePicker _picker = ImagePicker();
  // late List<XFile> images;
  // late XFile photo;
  List<CroppedFile> images = [];
  List imgUrls = [];
  List specifications = [];
  List keyFeatures = [];
  final double _height = Dimensions.pageViewContainer;
  GlobalKey<FormState> key = GlobalKey<FormState>();

  List<bool> disability = [false, false, false, false, false, false, false];
  List tags = [];
  String pCat = '';
  String? tagErr;

  late TextEditingController textEditingController1;
  late TextEditingController textEditingController2;
  late TextEditingController textEditingController3;
  late TextEditingController textEditingController4;
  late TextEditingController textEditingController5;
  late TextEditingController textEditingController6;
  late TextEditingController textEditingController7;
  late TextEditingController textEditingController8;
  late TextEditingController textEditingController9;
  late TextEditingController tagController;

  late FocusNode focusNode1;
  late FocusNode focusNode2;
  late FocusNode focusNode3;
  late FocusNode focusNode4;
  late FocusNode focusNode5;
  late FocusNode focusNode6;

  @override
  void initState() {
    specifications = widget.data[Constants.prodSpecifications];
    keyFeatures = widget.data[Constants.prodKeyFeatures];
    tags = widget.data[Constants.prodTags];
    pCat = widget.data[Constants.prodCategory];
    imgUrls = widget.data[Constants.imgUrls];

    textEditingController1 = TextEditingController();
    textEditingController2 = TextEditingController();
    textEditingController3 = TextEditingController();
    textEditingController4 = TextEditingController();
    textEditingController5 = TextEditingController();
    textEditingController6 = TextEditingController();
    textEditingController7 = TextEditingController();
    textEditingController8 = TextEditingController();
    textEditingController9 = TextEditingController();
    tagController = TextEditingController();

    textEditingController1.text = widget.data[Constants.name];
    textEditingController2.text = widget.data[Constants.prodDescription];
    textEditingController3.text =
        widget.data[Constants.prodMinPrice].toString();
    textEditingController4.text =
        widget.data[Constants.prodOldPrice].toString();
    textEditingController5.text =
        widget.data[Constants.prodNewPrice].toString();
    textEditingController6.text =
        widget.data[Constants.prodTotalStock].toString();

    String specs = '';
    String keyF = '';

    for (var element in widget.data[Constants.prodSpecifications]) {
      specs += element + ',';
    }
    for (var element in widget.data[Constants.prodKeyFeatures]) {
      keyF += element + ',';
    }
    if (widget.data[Constants.prodOldPrice] != 0) {
      _switch = true;
    }

    textEditingController7.text = specs;
    textEditingController8.text = keyF;
    textEditingController9.text =
        widget.data[Constants.deliveryPrice].toString();

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
    String currency = Constants(context).currency().currencySymbol;

    return Scaffold(
      backgroundColor: Constants.white,
      appBar: AppBar(
        title: Text(
          'Edit Product',
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
                      text: 'Product Images',
                      tMargin: Dimensions.sizedBoxHeight10,
                      textSize: Dimensions.font16,
                    ),
                    IconButton(
                        onPressed: (() async {
                          await _getImage().then((value) async {
                            for (var element in value) {
                              await _cropImage(element!.path)
                                  .then((value) async {
                                if (value == null) return;

                                setState(() {
                                  images.add(value);
                                });
                              });
                            }

                            await addImages();
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
                images.isEmpty && imgUrls.isEmpty
                    ? DottedBorder(
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
                                child: Icon(
                                  Icons.add_a_photo_rounded,
                                  color: Colors.grey,
                                  size: Dimensions.font17 * 2,
                                ),
                              ),
                            ),
                          ),
                        ),
                      )
                    : SizedBox(
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
                          itemCount: widget.data[Constants.imgUrls].length,
                          itemBuilder: (context, index, realIndex) {
                            return Constants(context).buildPageItem(
                                index,
                                widget.data[Constants.imgUrls][index],
                                widget.data[Constants.uid],
                                '',
                                imgUrls.length);
                            // return _buildPageItem(index);
                          },
                        ),
                      ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    HeadSedction(
                      text: 'Product Name',
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
                HeadSedction(
                  text: 'Product Category',
                  tMargin: Dimensions.sizedBoxHeight15 * 2,
                  textSize: Dimensions.font16,
                ),
                SizedBox(
                  height: Dimensions.sizedBoxHeight10 / 2,
                ),
                DropdownButtonFormField(
                    value: pCat,
                    items: Constants.categories
                        .map((e) => DropdownMenuItem(
                              value: e,
                              child: Text(e),
                            ))
                        .toList(),
                    menuMaxHeight: Dimensions.sizedBoxHeight320,
                    onChanged: ((dynamic value) {
                      setState(() {
                        pCat = value;
                      });
                    })),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    HeadSedction(
                      text: 'Product Description',
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
                  maxLines: 8,
                  decoration: InputDecoration(
                    counterText: '0/500 characters',
                    enabled: disability[1],
                    filled: true,
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    HeadSedction(
                      text: 'Product Price',
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
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text(
                        'Do you want to add a discount to this product?'),
                    Switch(
                        value: pCat == 'Cooked Foods' ? false : _switch,
                        activeColor: Constants.tetiary,
                        onChanged: pCat == 'Cooked Foods'
                            ? null
                            : ((value) {
                                setState(() {
                                  _switch = !_switch;
                                });
                              })),
                  ],
                ),
                pCat == 'Cooked Foods'
                    ? Column(
                        children: [
                          SizedBox(
                            height: Dimensions.sizedBoxHeight10,
                          ),
                          TextFormField(
                            controller: textEditingController3,
                            focusNode: focusNode3,
                            validator: (value) {
                              if (value == '') {
                                return Constants.err;
                              }

                              return null;
                            },
                            keyboardType: TextInputType.number,
                            decoration: InputDecoration(
                              labelText: 'Min-price',
                              enabled: disability[2],
                              filled: true,
                              prefix: SizedBox(
                                  width: Dimensions.sizedBoxWidth15,
                                  child: Text(currency)),
                              suffixText: 'NGN',
                            ),
                          )
                        ],
                      )
                    : Column(
                        children: [
                          SizedBox(
                            height: Dimensions.sizedBoxHeight10,
                          ),
                          _switch
                              ? (TextFormField(
                                  controller: textEditingController4,
                                  focusNode: focusNode4,
                                  validator: (value) {
                                    if (value == '') {
                                      return Constants.err;
                                    }

                                    return null;
                                  },
                                  keyboardType: TextInputType.number,
                                  decoration: InputDecoration(
                                    labelText: 'Old-price',
                                    enabled: disability[2],
                                    filled: true,
                                    prefix: SizedBox(
                                        width: Dimensions.sizedBoxWidth15,
                                        child: Text(currency)),
                                    suffixText: 'NGN',
                                  ),
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
                                return Constants.err;
                              }

                              return null;
                            },
                            keyboardType: TextInputType.number,
                            decoration: InputDecoration(
                              labelText: _switch ? 'New-price' : 'Price',
                              enabled: disability[2],
                              filled: true,
                              prefix: SizedBox(
                                  width: Dimensions.sizedBoxWidth15,
                                  child: Text(currency)),
                              suffixText: 'NGN',
                            ),
                          )
                        ],
                      ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    HeadSedction(
                      text: 'Product Tags',
                      tMargin: Dimensions.sizedBoxHeight15 * 2,
                      textSize: Dimensions.font16,
                    ),
                    IconButton(
                        onPressed: (() {
                          setState(() {
                            disability[3] = true;
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
                      backgroundColor: disability[3]
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
                        if (disability[3]) {
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
                    errorText: tagErr,
                    helperText: 'Add tags to make it easy to find your product',
                    suffixIcon: Container(
                      width: Dimensions.sizedBoxWidth10 * 6,
                      padding: EdgeInsets.symmetric(
                        vertical: Dimensions.sizedBoxHeight4,
                      ),
                      margin:
                          EdgeInsets.only(right: Dimensions.sizedBoxWidth10),
                      child: ElevatedBtn(
                        text: 'Add',
                        bgColor: disability[3]
                            ? Constants.primary
                            : Constants.primary.withAlpha(155),
                        disabled: !disability[3],
                        pressed: () {
                          if (disability[3]) {
                            if (tagController.text == '') {
                              setState(() {
                                tagErr = 'You cant\'t add empty tags';
                              });
                            } else {
                              setState(() {
                                tags.add(tagController.text.trim());
                                tagController.clear();
                                tagErr = null;
                              });
                            }
                          }
                        },
                      ),
                    ),
                    enabled: disability[3],
                    filled: true,
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    HeadSedction(
                      text: 'Product Additional Details',
                      tMargin: Dimensions.sizedBoxHeight15 * 2,
                      textSize: Dimensions.font16,
                    ),
                    IconButton(
                        onPressed: (() {
                          setState(() {
                            disability[4] = true;
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
                Row(
                  children: [
                    Expanded(
                      child: TextFormField(
                        controller: textEditingController6,
                        focusNode: focusNode6,
                        validator: pCat == 'Cooked Foods'
                            ? null
                            : (value) {
                                if (value == '') {
                                  return Constants.err;
                                }

                                return null;
                              },
                        keyboardType: TextInputType.number,
                        decoration: InputDecoration(
                          labelText: 'Total Stock',
                          enabled: disability[4],
                          filled: true,
                        ),
                      ),
                    ),
                    SizedBox(
                      width: Dimensions.sizedBoxWidth10 * 2,
                    ),
                    Expanded(
                      child: TextFormField(
                        controller: textEditingController9,
                        validator: (value) {
                          if (value == '') {
                            return Constants.err;
                          }

                          return null;
                        },
                        keyboardType: TextInputType.number,
                        decoration: InputDecoration(
                          labelText: 'Delivery Price',
                          prefix: SizedBox(
                              width: Dimensions.sizedBoxWidth15,
                              child: Text(currency)),
                          suffixText: 'NGN',
                          enabled: disability[4],
                          filled: true,
                        ),
                      ),
                    ),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    HeadSedction(
                      text: 'Product Specification',
                      tMargin: Dimensions.sizedBoxHeight15 * 2,
                      textSize: Dimensions.font16,
                    ),
                    IconButton(
                        onPressed: (() {
                          setState(() {
                            disability[5] = true;
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
                  controller: textEditingController7,
                  validator: (value) {
                    if (value == '') {
                      return Constants.err;
                    }

                    return null;
                  },
                  maxLines: 8,
                  decoration: InputDecoration(
                    helperText: 'Seperate with commas',
                    enabled: disability[5],
                    filled: true,
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    HeadSedction(
                      text: 'Product KeyFeatures',
                      tMargin: Dimensions.sizedBoxHeight15 * 2,
                      textSize: Dimensions.font16,
                    ),
                    IconButton(
                        onPressed: (() {
                          setState(() {
                            disability[6] = true;
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
                  controller: textEditingController8,
                  validator: (value) {
                    if (value == '') {
                      return Constants.err;
                    }

                    return null;
                  },
                  maxLines: 8,
                  decoration: InputDecoration(
                    helperText: 'Seperate with commas',
                    enabled: disability[6],
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
                    child: Provider.of<ProductProvider>(context, listen: true)
                                .process ==
                            Process.processing
                        ? SizedBox(
                            width: Dimensions.sizedBoxWidth10 * 2,
                            height: Dimensions.sizedBoxWidth10 * 2,
                            child: const CircularProgressIndicator(
                              color: Constants.white,
                              strokeWidth: 3,
                            ))
                        : Text(
                            'UPDATE',
                            style: TextStyle(
                                color: Constants.white,
                                fontSize: Dimensions.font14),
                          ),
                    pressed: () async {
                      if (key.currentState!.validate()) {
                        if (imgUrls.isEmpty && images.isEmpty) {
                          Constants(context).snackBar(
                              'Please add at least one image!', Colors.red);
                        } else {
                          if (textEditingController7.text != '') {
                            List<String> specs =
                                textEditingController7.text.trim().split(',');

                            for (var element in specs) {
                              specifications.add(element.trim());
                            }
                          }

                          if (textEditingController8.text != '') {
                            List<String> keyF =
                                textEditingController8.text.trim().split(',');

                            for (var element in keyF) {
                              keyFeatures.add(element.trim());
                            }
                          }

                          await Provider.of<ProductProvider>(context,
                                  listen: false)
                              .updateProduct({
                            Constants.name: textEditingController1.text.trim(),
                            Constants.prodDescription:
                                textEditingController2.text.trim(),
                            Constants.prodMinPrice: double.parse(
                                textEditingController3.text.trim()),
                            Constants.prodOldPrice: double.parse(
                                textEditingController4.text.trim()),
                            Constants.prodNewPrice: double.parse(
                                textEditingController5.text.trim()),
                            Constants.prodTags: tags,
                            Constants.prodTotalStock: textEditingController6
                                        .text ==
                                    ''
                                ? 0
                                : int.parse(textEditingController6.text.trim()),
                            Constants.deliveryPrice:
                                textEditingController9.text == ''
                                    ? 0
                                    : double.parse(
                                        textEditingController9.text.trim()),
                            Constants.prodSpecifications: specifications,
                            Constants.prodKeyFeatures: keyFeatures,
                          }, widget.data[Constants.uid]).then((value) {
                            if (value) {
                              tagController.clear();
                              textEditingController1.clear();
                              textEditingController2.clear();
                              textEditingController3.clear();
                              textEditingController4.clear();
                              textEditingController5.clear();
                              textEditingController6.clear();
                              textEditingController7.clear();
                              textEditingController8.clear();
                              textEditingController9.clear();
                              tags.clear();
                              specifications.clear();
                              keyFeatures.clear();
                              images.clear();

                              Navigator.pop(context);
                            }
                          });
                        }
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

  Future<List<XFile?>> _getImage() async {
    return await _picker.pickMultiImage();
  }

  Future<XFile?> _getCamImage() async {
    return await _picker.pickImage(source: ImageSource.camera);
  }

  Future addImages() async {
    await Provider.of<ProductProvider>(context, listen: false)
        .addImage(images, FirebaseAuth.instance.currentUser!.uid,
            widget.data[Constants.uid])
        .then((value) {
      if (value) {
        Navigator.pop(context);
      }
    });
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
