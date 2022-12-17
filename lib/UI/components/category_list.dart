import 'package:flutter/material.dart';
import 'package:GOCart/UI/utils/dimensions.dart';

class CategoryList extends StatelessWidget {
  final int index;

  const CategoryList({super.key, this.index = 0});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          Padding(
              padding: EdgeInsets.only(
                  top: Dimensions.sizedBoxHeight15,
                  left: Dimensions.sizedBoxWidth15,
                  right: Dimensions.sizedBoxWidth15),
              child: Material(
                color: Colors.white,
                borderRadius: BorderRadius.circular(Dimensions.sizedBoxWidth4),
                child: ListTile(
                  title: Text(
                    'ALL PRODUCTS',
                    style: TextStyle(
                        fontWeight: FontWeight.w500,
                        fontSize: Dimensions.font13),
                  ),
                  trailing: Icon(
                    Icons.arrow_forward_ios_rounded,
                    size: Dimensions.font15,
                  ),
                  iconColor: const Color(0XFF111111),
                  minLeadingWidth: Dimensions.sizedBoxWidth4 / 2,
                  visualDensity: VisualDensity(
                      vertical: -(Dimensions.sizedBoxHeight4 / 2)),
                  onTap: () {},
                ),
              )),
          Container(
            width: double.maxFinite,
            margin: EdgeInsets.only(
                left: Dimensions.sizedBoxWidth15,
                top: Dimensions.sizedBoxHeight10,
                right: Dimensions.sizedBoxWidth15),
            padding: EdgeInsets.symmetric(
                horizontal: Dimensions.sizedBoxWidth10,
                vertical: Dimensions.sizedBoxHeight15),
            decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.all(
                    Radius.circular(Dimensions.sizedBoxHeight4))),
            child: GridView.builder(
              physics: const NeverScrollableScrollPhysics(),
              shrinkWrap: true,
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  mainAxisSpacing: Dimensions.sizedBoxWidth10,
                  crossAxisSpacing: Dimensions.sizedBoxHeight10 * 2),
              itemCount: 19,
              itemBuilder: (context, idx) {
                return Material(
                  child: InkWell(
                    child: Ink(
                      decoration: BoxDecoration(
                        borderRadius:
                            BorderRadius.circular(Dimensions.sizedBoxWidth4),
                        color: Colors.white,
                      ),
                      child: Column(
                        children: [
                          Expanded(
                            child: Ink(
                              height: double.maxFinite,
                              decoration: const BoxDecoration(
                                  image: DecorationImage(
                                      image:
                                          AssetImage('assets/images/build.jpg'),
                                      fit: BoxFit.contain)),
                            ),
                          ),
                          Text('data$index')
                        ],
                      ),
                    ),
                    onTap: () {},
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
