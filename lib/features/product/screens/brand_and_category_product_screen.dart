import 'package:flutter/material.dart';
import 'package:user_app/features/product/controllers/product_controller.dart';
import 'package:user_app/utill/dimensions.dart';
import 'package:user_app/utill/images.dart';
import 'package:user_app/common/basewidget/custom_app_bar_widget.dart';
import 'package:user_app/common/basewidget/no_internet_screen_widget.dart';
import 'package:user_app/common/basewidget/product_shimmer_widget.dart';
import 'package:user_app/common/basewidget/product_widget.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:provider/provider.dart';

class BrandAndCategoryProductScreen extends StatefulWidget {
  final bool isBrand;
  final String id;
  final String? name;
  final String? image;
  const BrandAndCategoryProductScreen(
      {super.key,
      required this.isBrand,
      required this.id,
      required this.name,
      this.image});

  @override
  State<BrandAndCategoryProductScreen> createState() =>
      _BrandAndCategoryProductScreenState();
}

class _BrandAndCategoryProductScreenState
    extends State<BrandAndCategoryProductScreen> {
  @override
  void initState() {
    Provider.of<ProductController>(context, listen: false)
        .initBrandOrCategoryProductList(widget.isBrand, widget.id, context);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(title: widget.name),
      body: Consumer<ProductController>(
        builder: (context, productController, child) {
          return Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                const SizedBox(height: Dimensions.paddingSizeExtraSmall),

                // Products
                productController.brandOrCategoryProductList.isNotEmpty
                    ? Expanded(
                        child: MasonryGridView.count(
                          padding: const EdgeInsets.symmetric(
                              horizontal: Dimensions.paddingSizeSmall),
                          physics: const BouncingScrollPhysics(),
                          crossAxisCount:
                              MediaQuery.of(context).size.width > 480 ? 3 : 2,
                          itemCount: productController
                              .brandOrCategoryProductList.length,
                          shrinkWrap: true,
                          itemBuilder: (BuildContext context, int index) {
                            return ProductWidget(
                                productModel: productController
                                    .brandOrCategoryProductList[index]);
                          },
                        ),
                      )
                    : Expanded(
                        child: productController.hasData!
                            ? ProductShimmer(
                                isHomePage: false,
                                isEnabled:
                                    Provider.of<ProductController>(context)
                                        .brandOrCategoryProductList
                                        .isEmpty)
                            : const NoInternetOrDataScreenWidget(
                                isNoInternet: false,
                                icon: Images.noProduct,
                                message: 'no_product_found',
                              )),
              ]);
        },
      ),
    );
  }
}
