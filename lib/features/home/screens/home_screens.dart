import 'package:flutter/material.dart';
import 'package:user_app/common/basewidget/title_row_widget.dart';
import 'package:user_app/features/address/controllers/address_controller.dart';
import 'package:user_app/features/auth/controllers/auth_controller.dart';
import 'package:user_app/features/banner/controllers/banner_controller.dart';
import 'package:user_app/features/banner/widgets/banners_widget.dart';
import 'package:user_app/features/banner/widgets/footer_banner_slider_widget.dart';
import 'package:user_app/features/banner/widgets/single_banner_widget.dart';
import 'package:user_app/features/brand/controllers/brand_controller.dart';
import 'package:user_app/features/brand/screens/brands_screen.dart';
import 'package:user_app/features/brand/widgets/brand_list_widget.dart';
import 'package:user_app/features/cart/controllers/cart_controller.dart';
import 'package:user_app/features/category/controllers/category_controller.dart';
import 'package:user_app/features/category/widgets/category_list_widget.dart';
import 'package:user_app/features/deal/controllers/featured_deal_controller.dart';
import 'package:user_app/features/deal/controllers/flash_deal_controller.dart';
import 'package:user_app/features/deal/screens/featured_deal_screen_view.dart';
import 'package:user_app/features/deal/screens/flash_deal_screen_view.dart';
import 'package:user_app/features/deal/widgets/featured_deal_list_widget.dart';
import 'package:user_app/features/deal/widgets/flash_deals_list_widget.dart';
import 'package:user_app/features/home/shimmers/flash_deal_shimmer.dart';
import 'package:user_app/features/home/widgets/announcement_widget.dart';
import 'package:user_app/features/home/widgets/aster_theme/find_what_you_need_shimmer.dart';
import 'package:user_app/features/home/widgets/featured_product_widget.dart';
import 'package:user_app/features/home/widgets/publication_house_widget.dart';
import 'package:user_app/features/home/widgets/search_home_page_widget.dart';
import 'package:user_app/features/notification/controllers/notification_controller.dart';
import 'package:user_app/features/product/controllers/product_controller.dart';
import 'package:user_app/features/product/enums/product_type.dart';
import 'package:user_app/features/product/widgets/home_category_product_widget.dart';
import 'package:user_app/features/product/widgets/latest_product_list_widget.dart';
import 'package:user_app/features/product/widgets/products_list_widget.dart';
import 'package:user_app/features/product/widgets/recommended_product_widget.dart';
import 'package:user_app/features/profile/controllers/profile_contrroller.dart';
import 'package:user_app/features/search_product/screens/search_product_screen.dart';
import 'package:user_app/features/shop/controllers/shop_controller.dart';
import 'package:user_app/features/shop/screens/all_shop_screen.dart';
import 'package:user_app/features/shop/widgets/top_seller_view.dart';
import 'package:user_app/features/splash/controllers/splash_controller.dart';
import 'package:user_app/features/splash/domain/models/config_model.dart';
import 'package:user_app/helper/responsive_helper.dart';
import 'package:user_app/localization/language_constrants.dart';
import 'package:user_app/main.dart';
import 'package:user_app/theme/controllers/theme_controller.dart';
import 'package:user_app/utill/custom_themes.dart';
import 'package:user_app/utill/dimensions.dart';
import 'package:user_app/utill/images.dart';
import 'package:provider/provider.dart';

import '../../dashboard/widgets/app_exit_card_widget.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final ScrollController _scrollController = ScrollController();
  Future<void> loadData(bool reload) async {
    await Provider.of<FlashDealController>(Get.context!, listen: false)
        .getFlashDealList(reload, false);
    await Provider.of<ShopController>(Get.context!, listen: false)
        .getTopSellerList(reload, 1, type: "top");
    Provider.of<BannerController>(Get.context!, listen: false)
        .getBannerList(reload);
    Provider.of<CategoryController>(Get.context!, listen: false)
        .getCategoryList(reload);
    Provider.of<AddressController>(Get.context!, listen: false)
        .getAddressList();
    await Provider.of<CartController>(Get.context!, listen: false)
        .getCartData(Get.context!);

    await Provider.of<ProductController>(Get.context!, listen: false)
        .getHomeCategoryProductList(reload);
    await Provider.of<BrandController>(Get.context!, listen: false)
        .getBrandList(reload);
    await Provider.of<ProductController>(Get.context!, listen: false)
        .getLatestProductList(1, reload: reload);
    await Provider.of<ProductController>(Get.context!, listen: false)
        .getFeaturedProductList('1', reload: reload);
    await Provider.of<FeaturedDealController>(Get.context!, listen: false)
        .getFeaturedDealList(reload);
    await Provider.of<ProductController>(Get.context!, listen: false)
        .getLProductList('1', reload: reload);
    await Provider.of<ProductController>(Get.context!, listen: false)
        .getRecommendedProduct();
    await Provider.of<NotificationController>(Get.context!, listen: false)
        .getNotificationList(1);
    if (Provider.of<AuthController>(Get.context!, listen: false).isLoggedIn()) {
      await Provider.of<ProfileController>(Get.context!, listen: false)
          .getUserInfo(Get.context!);
    }
  }

  void passData(int index, String title) {
    index = index;
    title = title;
  }

  bool singleVendor = true;
  @override
  void initState()  {
    super.initState();
    singleVendor = Provider.of<SplashController>(context, listen: false)
            .configModel!
            .businessMode ==
        "single";
     loadData(true);
  }

  @override
  Widget build(BuildContext context) {
    final ConfigModel? configModel =
        Provider.of<SplashController>(context, listen: false).configModel;

    List<String?> types = [
      getTranslated('new_arrival', context),
      getTranslated('top_product', context),
      getTranslated('best_selling', context),
      getTranslated('discounted_product', context)
    ];

    return PopScope(
        canPop: false,
        onPopInvoked: (val) async {

            await Future.delayed(const Duration(milliseconds: 150));
            showModalBottomSheet(
                backgroundColor: Colors.transparent,
                context: Get.context!,
                builder: (_) => const AppExitCard());
          
          return;
        },
        child:     
    Scaffold(
      resizeToAvoidBottomInset: false,
      body: SafeArea(
        child: RefreshIndicator(
          onRefresh: () async {
            await loadData(true);
          },
          child: CustomScrollView(
            controller: _scrollController,
            slivers: [
              SliverAppBar(
                floating: true,
                elevation: 0,
                centerTitle: false,
                automaticallyImplyLeading: false,
                backgroundColor: Theme.of(context).highlightColor,
                title: Image.asset(Images.logoWithNameImage, height: 35),
              ),
              // SliverToBoxAdapter(
              //   child: Provider.of<SplashController>(context, listen: false)
              //               .configModel!
              //               .announcement!
              //               .status ==
              //           '1'
              //       ? Consumer<SplashController>(
              //           builder: (context, announcement, _) {
              //           return (announcement.configModel!.announcement!
              //                           .announcement !=
              //                       null &&
              //                   announcement.onOff)
              //               ? AnnouncementWidget(
              //                   announcement:
              //                       announcement.configModel!.announcement)
              //               : const SizedBox();
              //         })
              //       : const SizedBox(),
              // ),
              SliverPersistentHeader(
                  pinned: true,
                  delegate: SliverDelegate(
                    child: InkWell(
                      onTap: () => Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (_) => const SearchScreen())),
                      child: const Hero(
                          tag: 'search',
                          child: Material(child: SearchHomePageWidget())),
                    ),
                  )),

              SliverToBoxAdapter(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const BannersWidget(),
                    const SizedBox(height: Dimensions.paddingSizeDefault),

                    const CategoryListWidget(isHomePage: true),
                    const SizedBox(height: Dimensions.paddingSizeDefault),

                    // const SizedBox(height: Dimensions.paddingSizeExtraSmall),

                    const SizedBox(height: Dimensions.paddingSizeDefault),

                    const HomeCategoryProductWidget(isHomePage: true),
                    const SizedBox(height: Dimensions.paddingSizeDefault),

                    // const BannersWidget(),
                    // const SizedBox(height: Dimensions.paddingSizeDefault),

                    // const CategoryListWidget(isHomePage: true),
                    // const SizedBox(height: Dimensions.paddingSizeDefault),

                    // // const SizedBox(height: Dimensions.paddingSizeExtraSmall),

                    // const SizedBox(height: Dimensions.paddingSizeDefault),

                    // const FeaturedProductWidget(),
                    // const SizedBox(height: Dimensions.paddingSizeDefault),

                    // singleVendor
                    //     ? const SizedBox()
                    //     : Consumer<ShopController>(
                    //         builder: (context, topSellerProvider, child) {
                    //         return (topSellerProvider.sellerModel != null &&
                    //                 (topSellerProvider.sellerModel!.sellers !=
                    //                         null &&
                    //                     topSellerProvider
                    //                         .sellerModel!.sellers!.isNotEmpty))
                    //             ? TitleRowWidget(
                    //                 title: getTranslated('top_seller', context),
                    //                 onTap: () => Navigator.push(
                    //                     context,
                    //                     MaterialPageRoute(
                    //                         builder: (_) =>
                    //                             const AllTopSellerScreen(
                    //                               title: 'top_stores',
                    //                             ))))
                    //             : const SizedBox();
                    //       }),
                    // singleVendor
                    //     ? const SizedBox(height: 0)
                    //     : const SizedBox(height: Dimensions.paddingSizeSmall),

                    // singleVendor
                    //     ? const SizedBox()
                    //     : Consumer<ShopController>(
                    //         builder: (context, topSellerProvider, child) {
                    //         return (topSellerProvider.sellerModel != null &&
                    //                 (topSellerProvider.sellerModel!.sellers !=
                    //                         null &&
                    //                     topSellerProvider
                    //                         .sellerModel!.sellers!.isNotEmpty))
                    //             ? Padding(
                    //                 padding: const EdgeInsets.only(
                    //                     bottom: Dimensions.paddingSizeDefault),
                    //                 child: SizedBox(
                    //                     height: ResponsiveHelper.isTab(context)
                    //                         ? 170
                    //                         : 165,
                    //                     child: TopSellerView(
                    //                       isHomePage: true,
                    //                       scrollController: _scrollController,
                    //                     )))
                    //             : const SizedBox();
                    //       }),

                    // const Padding(
                    //     padding: EdgeInsets.only(
                    //         bottom: Dimensions.paddingSizeDefault),
                    //     child: RecommendedProductWidget()),

                    // const Padding(
                    //     padding: EdgeInsets.only(
                    //         bottom: Dimensions.paddingSizeDefault),
                    //     child: LatestProductListWidget()),

                    // if (configModel?.brandSetting == "1")
                    //   TitleRowWidget(
                    //     title: getTranslated('brand', context),
                    //     onTap: () => Navigator.push(
                    //         context,
                    //         MaterialPageRoute(
                    //             builder: (_) => const BrandsView())),
                    //   ),

                    // SizedBox(
                    //     height: configModel?.brandSetting == "1"
                    //         ? Dimensions.paddingSizeSmall
                    //         : 0),

                    // if (configModel!.brandSetting == "1") ...[
                    //   const BrandListWidget(isHomePage: true),
                    //   const SizedBox(height: Dimensions.paddingSizeDefault),
                    // ],

                    // const PublicatioinHouseWidget(isHomePage: true),

                    // const HomeCategoryProductWidget(isHomePage: true),
                    // const SizedBox(height: Dimensions.paddingSizeDefault),

                    // const FooterBannerSliderWidget(),
                    // const SizedBox(height: Dimensions.paddingSizeDefault),

                    Consumer<ProductController>(
                        builder: (ctx, prodProvider, child) {
                      return Container(
                          decoration: BoxDecoration(
                              color: Theme.of(context)
                                  .colorScheme
                                  .onSecondaryContainer),
                          child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
//  const BannersWidget(),
//                     const SizedBox(height: Dimensions.paddingSizeDefault),

//                     const CategoryListWidget(isHomePage: true),
//                     const SizedBox(height: Dimensions.paddingSizeDefault),

//                     // const SizedBox(height: Dimensions.paddingSizeExtraSmall),

//                     const SizedBox(height: Dimensions.paddingSizeDefault),

//                     const HomeCategoryProductWidget(isHomePage: true),
//                     const SizedBox(height: Dimensions.paddingSizeDefault),

                                // Padding(
                                //     padding: const EdgeInsets.fromLTRB(
                                //         Dimensions.paddingSizeDefault,
                                //         0,
                                //         Dimensions.paddingSizeSmall,
                                //         0),
                                //     child: Row(children: [
                                //       Expanded(
                                //           child: Text(
                                //               prodProvider.title == 'xyz'
                                //                   ? getTranslated(
                                //                       'new_arrival', context)!
                                //                   : prodProvider.title!,
                                //               style: titleHeader)),
                                //       prodProvider.latestProductList != null
                                //           ? PopupMenuButton(
                                //               padding: const EdgeInsets.all(0),
                                //               itemBuilder: (context) {
                                //                 return [
                                //                   PopupMenuItem(
                                //                     value:
                                //                         ProductType.newArrival,
                                //                     child: Text(
                                //                         getTranslated(
                                //                                 'new_arrival',
                                //                                 context) ??
                                //                             '',
                                //                         style: textRegular
                                //                             .copyWith(
                                //                           color: prodProvider
                                //                                       .productType ==
                                //                                   ProductType
                                //                                       .newArrival
                                //                               ? Theme.of(
                                //                                       context)
                                //                                   .primaryColor
                                //                               : Theme.of(
                                //                                       context)
                                //                                   .textTheme
                                //                                   .bodyLarge
                                //                                   ?.color,
                                //                         )),
                                //                   ),
                                //                   PopupMenuItem(
                                //                     value:
                                //                         ProductType.topProduct,
                                //                     child: Text(
                                //                         getTranslated(
                                //                                 'top_product',
                                //                                 context) ??
                                //                             '',
                                //                         style: textRegular
                                //                             .copyWith(
                                //                           color: prodProvider
                                //                                       .productType ==
                                //                                   ProductType
                                //                                       .topProduct
                                //                               ? Theme.of(
                                //                                       context)
                                //                                   .primaryColor
                                //                               : Theme.of(
                                //                                       context)
                                //                                   .textTheme
                                //                                   .bodyLarge
                                //                                   ?.color,
                                //                         )),
                                //                   ),
                                //                   PopupMenuItem(
                                //                     value:
                                //                         ProductType.bestSelling,
                                //                     child: Text(
                                //                         getTranslated(
                                //                                 'best_selling',
                                //                                 context) ??
                                //                             '',
                                //                         style: textRegular
                                //                             .copyWith(
                                //                           color: prodProvider
                                //                                       .productType ==
                                //                                   ProductType
                                //                                       .bestSelling
                                //                               ? Theme.of(
                                //                                       context)
                                //                                   .primaryColor
                                //                               : Theme.of(
                                //                                       context)
                                //                                   .textTheme
                                //                                   .bodyLarge
                                //                                   ?.color,
                                //                         )),
                                //                   ),
                                //                   // PopupMenuItem(
                                //                   //   value: ProductType
                                //                   //       .discountedProduct,
                                //                   //   child: Text(
                                //                   //       getTranslated(
                                //                   //               'discounted_product',
                                //                   //               context) ??
                                //                   //           '',
                                //                   //       style: textRegular
                                //                   //           .copyWith(
                                //                   //         color: prodProvider
                                //                   //                     .productType ==
                                //                   //                 ProductType
                                //                   //                     .discountedProduct
                                //                   //             ? Theme.of(
                                //                   //                     context)
                                //                   //                 .primaryColor
                                //                   //             : Theme.of(
                                //                   //                     context)
                                //                   //                 .textTheme
                                //                   //                 .bodyLarge
                                //                   //                 ?.color,
                                //                   //       )),
                                //                   // ),

                                //                 ];
                                //               },
                                //               shape: RoundedRectangleBorder(
                                //                   borderRadius: BorderRadius
                                //                       .circular(Dimensions
                                //                           .paddingSizeSmall)),
                                //               child: Padding(
                                //                   padding: const EdgeInsets
                                //                       .fromLTRB(
                                //                       Dimensions
                                //                           .paddingSizeExtraSmall,
                                //                       Dimensions
                                //                           .paddingSizeSmall,
                                //                       Dimensions
                                //                           .paddingSizeExtraSmall,
                                //                       Dimensions
                                //                           .paddingSizeSmall),
                                //                   child: Image.asset(
                                //                       Images.dropdown,
                                //                       scale: 3)),
                                //               onSelected: (ProductType value) {
                                //                 if (value ==
                                //                     ProductType.newArrival) {
                                //                   Provider.of<ProductController>(
                                //                           context,
                                //                           listen: false)
                                //                       .changeTypeOfProduct(
                                //                           value, types[0]);
                                //                 } else if (value ==
                                //                     ProductType.topProduct) {
                                //                   Provider.of<ProductController>(
                                //                           context,
                                //                           listen: false)
                                //                       .changeTypeOfProduct(
                                //                           value, types[1]);
                                //                 } else if (value ==
                                //                     ProductType.bestSelling) {
                                //                   Provider.of<ProductController>(
                                //                           context,
                                //                           listen: false)
                                //                       .changeTypeOfProduct(
                                //                           value, types[2]);
                                //                 } else if (value ==
                                //                     ProductType
                                //                         .discountedProduct) {
                                //                   Provider.of<ProductController>(
                                //                           context,
                                //                           listen: false)
                                //                       .changeTypeOfProduct(
                                //                           value, types[3]);
                                //                 }
                                //                 Provider.of<ProductController>(
                                //                         context,
                                //                         listen: false)
                                //                     .getLatestProductList(1,
                                //                         reload: true);
                                //               },
                                //             )
                                //           : const SizedBox()
                                //     ])),

                                // Padding(
                                //   padding: const EdgeInsets.symmetric(
                                //       horizontal: Dimensions.paddingSizeSmall),
                                //   child: ProductListWidget(
                                //       isHomePage: false,
                                //       productType: ProductType.newArrival,
                                //       scrollController: _scrollController),
                                // ),
                                // const SizedBox(
                                //     height: Dimensions.homePagePadding)
                              ]));
                    }),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    ));
  
  
    
    

  }
}

class SliverDelegate extends SliverPersistentHeaderDelegate {
  Widget child;
  double height;
  SliverDelegate({required this.child, this.height = 70});

  @override
  Widget build(
      BuildContext context, double shrinkOffset, bool overlapsContent) {
    return child;
  }

  @override
  double get maxExtent => height;

  @override
  double get minExtent => height;

  @override
  bool shouldRebuild(SliverDelegate oldDelegate) {
    return oldDelegate.maxExtent != height ||
        oldDelegate.minExtent != height ||
        child != oldDelegate.child;
  }
}
