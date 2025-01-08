import 'package:flutter/material.dart';
import 'package:user_app/features/brand/controllers/brand_controller.dart';
import 'package:user_app/features/brand/widgets/brand_shimmer_widget.dart';
import 'package:user_app/features/product/screens/brand_and_category_product_screen.dart';
import 'package:user_app/helper/responsive_helper.dart';
import 'package:user_app/localization/controllers/localization_controller.dart';
import 'package:user_app/theme/controllers/theme_controller.dart';
import 'package:user_app/utill/custom_themes.dart';
import 'package:user_app/utill/dimensions.dart';
import 'package:user_app/common/basewidget/custom_image_widget.dart';
import 'package:provider/provider.dart';

class BrandListWidget extends StatelessWidget {
  final bool isHomePage;
  const BrandListWidget({super.key, required this.isHomePage});

  @override
  Widget build(BuildContext context) {
    return Consumer<BrandController>(
      builder: (context, brandProvider, child) {
        return brandProvider.brandList.isNotEmpty
            ? isHomePage
                ? SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Row(
                        children: brandProvider.brandList
                            .map((brand) => InkWell(
                                  splashColor: Colors.transparent,
                                  highlightColor: Colors.transparent,
                                  onTap: () {
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (_) =>
                                                BrandAndCategoryProductScreen(
                                                    isBrand: true,
                                                    id: brand.id.toString(),
                                                    name: brand.name,
                                                    image: brand
                                                        .imageFullUrl?.path)));
                                  },
                                  child: Padding(
                                    padding: EdgeInsets.only(
                                        left:
                                            Provider.of<LocalizationController>(
                                                        context,
                                                        listen: false)
                                                    .isLtr
                                                ? Dimensions.paddingSizeDefault
                                                : 0,
                                        right: brandProvider.brandList.length ==
                                                brandProvider.brandList
                                                        .indexOf(brand) +
                                                    1
                                            ? Dimensions.paddingSizeDefault
                                            : Provider.of<LocalizationController>(
                                                        context,
                                                        listen: false)
                                                    .isLtr
                                                ? 0
                                                : Dimensions
                                                    .paddingSizeDefault),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      children: [
                                        Container(
                                          width: ResponsiveHelper.isTab(context)
                                              ? 120
                                              : 50,
                                          height:
                                              ResponsiveHelper.isTab(context)
                                                  ? 120
                                                  : 50,
                                          decoration: BoxDecoration(
                                              borderRadius:
                                                  const BorderRadius.all(
                                                      Radius.circular(5)),
                                              color: Theme.of(context)
                                                  .highlightColor,
                                              boxShadow:
                                                  Provider.of<ThemeController>(
                                                              context,
                                                              listen: false)
                                                          .darkTheme
                                                      ? null
                                                      : [
                                                          BoxShadow(
                                                              color: Colors.grey
                                                                  .withOpacity(
                                                                      0.12),
                                                              spreadRadius: 1,
                                                              blurRadius: 1,
                                                              offset:
                                                                  const Offset(
                                                                      0, 1))
                                                        ]),
                                          child: ClipRRect(
                                              borderRadius:
                                                  const BorderRadius.all(
                                                      Radius.circular(5)),
                                              child: CustomImageWidget(
                                                  image:
                                                      '${brand.imageFullUrl?.path!}')),
                                        ),
                                      ],
                                    ),
                                  ),
                                ))
                            .toList()))
                : GridView.builder(
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 4,
                            childAspectRatio: (1 / 1.3),
                            mainAxisSpacing: 10,
                            crossAxisSpacing: 5),
                    padding: EdgeInsets.zero,
                    itemCount: brandProvider.brandList.length,
                    shrinkWrap: true,
                    physics: const BouncingScrollPhysics(),
                    itemBuilder: (BuildContext context, int index) {
                      return InkWell(
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (_) => BrandAndCategoryProductScreen(
                                      isBrand: true,
                                      id: brandProvider.brandList[index].id
                                          .toString(),
                                      name: brandProvider.brandList[index].name,
                                      image: brandProvider.brandList[index]
                                          .imageFullUrl?.path)));
                        },
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: [
                            Expanded(
                                child: ClipRRect(
                              borderRadius: BorderRadius.circular(
                                  Dimensions.paddingSizeSmall),
                              child: Container(
                                decoration: BoxDecoration(
                                    color: Theme.of(context).cardColor,
                                    borderRadius: BorderRadius.circular(
                                        Dimensions.paddingSizeSmall)),
                                child: CustomImageWidget(
                                    image:
                                        'https://alfajri.so/storage/app/public/category_banner/${brandProvider.brandList[index].image}'),
                              ),
                            )),
                            SizedBox(
                                height:
                                    (MediaQuery.of(context).size.width / 4) *
                                        0.3,
                                child: Center(
                                    child: Text(
                                        brandProvider.brandList[index].name!,
                                        maxLines: 1,
                                        overflow: TextOverflow.ellipsis,
                                        textAlign: TextAlign.center,
                                        style: textRegular.copyWith(
                                            fontSize:
                                                Dimensions.fontSizeSmall)))),
                          ],
                        ),
                      );
                    },
                  )
            : BrandShimmerWidget(isHomePage: isHomePage);
      },
    );
  }
}
