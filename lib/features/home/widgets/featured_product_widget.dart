import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:user_app/common/basewidget/product_widget.dart';
import 'package:user_app/common/basewidget/slider_product_shimmer_widget.dart';
import 'package:user_app/common/basewidget/title_row_widget.dart';
import 'package:user_app/features/product/controllers/product_controller.dart';
import 'package:user_app/features/product/enums/product_type.dart';
import 'package:user_app/features/product/screens/view_all_product_screen.dart';
import 'package:user_app/helper/responsive_helper.dart';
import 'package:user_app/localization/language_constrants.dart';
import 'package:user_app/utill/dimensions.dart';
import 'package:provider/provider.dart';

class FeaturedProductWidget extends StatelessWidget {
  const FeaturedProductWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<ProductController>(
        builder: (context, productController, _) {
      return (productController.featuredProductList?.isNotEmpty ?? false)
          ? Column(children: [
              Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: Dimensions.paddingSizeExtraSmall,
                  vertical: Dimensions.paddingSizeExtraSmall,
                ),
                child: TitleRowWidget(
                  title: getTranslated('featured_products', context),
                  onTap: () => Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (_) => AllProductScreen(
                              productType: ProductType.featuredProduct))),
                ),
              ),
              SizedBox(
                height: ResponsiveHelper.isTab(context)
                    ? MediaQuery.of(context).size.width * .58
                    : 320,
                child: CarouselSlider.builder(
                  options: CarouselOptions(
                    viewportFraction:
                        ResponsiveHelper.isTab(context) ? .5 : .65,
                    autoPlay: false,
                    pauseAutoPlayOnTouch: true,
                    pauseAutoPlayOnManualNavigate: true,
                    enlargeFactor: 0.2,
                    enlargeCenterPage: true,
                    pauseAutoPlayInFiniteScroll: true,
                    disableCenter: true,
                  ),
                  itemCount: productController.featuredProductList?.length,
                  itemBuilder: (context, index, next) {
                    return ProductWidget(
                        productModel:
                            productController.featuredProductList![index],
                        productNameLine: 1);
                  },
                ),
              ),
            ])
          : productController.featuredProductList == null
              ? const SliderProductShimmerWidget()
              : const SizedBox();
    });
  }
}