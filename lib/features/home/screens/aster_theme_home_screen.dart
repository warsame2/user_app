import 'package:flutter/material.dart';
import 'package:user_app/common/basewidget/title_row_widget.dart';
import 'package:user_app/features/auth/controllers/auth_controller.dart';
import 'package:user_app/features/banner/controllers/banner_controller.dart';
import 'package:user_app/features/banner/widgets/banners_widget.dart';
import 'package:user_app/features/banner/widgets/footer_banner_slider_widget.dart';
import 'package:user_app/features/banner/widgets/single_banner_widget.dart';
import 'package:user_app/features/brand/controllers/brand_controller.dart';
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
import 'package:user_app/features/home/shimmers/order_again_shimmer.dart';
import 'package:user_app/features/home/shimmers/top_store_shimmer.dart';
import 'package:user_app/features/home/widgets/announcement_widget.dart';
import 'package:user_app/features/home/widgets/aster_theme/find_what_you_need_shimmer.dart';
import 'package:user_app/features/home/widgets/aster_theme/find_what_you_need_widget.dart';
import 'package:user_app/features/home/widgets/aster_theme/more_store_list_view_widget.dart';
import 'package:user_app/features/home/widgets/aster_theme/order_again_list_view_widget.dart';
import 'package:user_app/features/home/widgets/featured_product_widget.dart';
import 'package:user_app/features/home/widgets/just_for_you/just_for_you_widget.dart';
import 'package:user_app/features/home/widgets/search_home_page_widget.dart';
import 'package:user_app/features/notification/controllers/notification_controller.dart';
import 'package:user_app/features/order/controllers/order_controller.dart';
import 'package:user_app/features/product/controllers/product_controller.dart';
import 'package:user_app/features/product/controllers/seller_product_controller.dart';
import 'package:user_app/features/product/enums/product_type.dart';
import 'package:user_app/features/product/screens/view_all_product_screen.dart';
import 'package:user_app/features/product/widgets/home_category_product_widget.dart';
import 'package:user_app/features/product/widgets/latest_product_list_widget.dart';
import 'package:user_app/features/product/widgets/products_list_widget.dart';
import 'package:user_app/features/product/widgets/recommended_product_widget.dart';
import 'package:user_app/features/profile/controllers/profile_contrroller.dart';
import 'package:user_app/features/search_product/screens/search_product_screen.dart';
import 'package:user_app/features/shop/controllers/shop_controller.dart';
import 'package:user_app/features/shop/screens/all_shop_screen.dart';
import 'package:user_app/features/shop/widgets/more_store_list_view.dart';
import 'package:user_app/features/shop/widgets/top_seller_view.dart';
import 'package:user_app/features/splash/controllers/splash_controller.dart';
import 'package:user_app/helper/responsive_helper.dart';
import 'package:user_app/localization/language_constrants.dart';
import 'package:user_app/main.dart';
import 'package:user_app/theme/controllers/theme_controller.dart';
import 'package:user_app/utill/custom_themes.dart';
import 'package:user_app/utill/dimensions.dart';
import 'package:user_app/utill/images.dart';
import 'package:provider/provider.dart';

class AsterThemeHomeScreen extends StatefulWidget {
  const AsterThemeHomeScreen({super.key});

  @override
  State<AsterThemeHomeScreen> createState() => _AsterThemeHomeScreenState();

  static Future<void> loadData(bool reload) async {
    await Provider.of<FlashDealController>(Get.context!, listen: false)
        .getFlashDealList(true, false);
    await Provider.of<CartController>(Get.context!, listen: false)
        .getCartData(Get.context!);
    await Provider.of<BannerController>(Get.context!, listen: false)
        .getBannerList(reload);
    await Provider.of<CategoryController>(Get.context!, listen: false)
        .getCategoryList(reload);
    await Provider.of<ProductController>(Get.context!, listen: false)
        .getHomeCategoryProductList(reload);
    await Provider.of<ShopController>(Get.context!, listen: false)
        .getTopSellerList(reload, 1, type: "top");
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
    await Provider.of<ProductController>(Get.context!, listen: false)
        .findWhatYouNeed();
    await Provider.of<ProductController>(Get.context!, listen: false)
        .getJustForYouProduct();
    await Provider.of<ShopController>(Get.context!, listen: false)
        .getMoreStore();
    await Provider.of<NotificationController>(Get.context!, listen: false)
        .getNotificationList(1);
    if (Provider.of<AuthController>(Get.context!, listen: false).isLoggedIn()) {
      await Provider.of<ProfileController>(Get.context!, listen: false)
          .getUserInfo(Get.context!);
      await Provider.of<SellerProductController>(Get.context!, listen: false)
          .getShopAgainFromRecentStore();
      await Provider.of<OrderController>(Get.context!, listen: false)
          .getOrderList(1, 'delivered', type: 'reorder');
    }
  }
}

class _AsterThemeHomeScreenState extends State<AsterThemeHomeScreen> {
  final ScrollController _scrollController = ScrollController();

  void passData(int index, String title) {
    index = index;
    title = title;
  }

  bool singleVendor = false;
  @override
  void initState() {
    super.initState();

    singleVendor = Provider.of<SplashController>(context, listen: false)
            .configModel!
            .businessMode ==
        "single";
  }

  @override
  Widget build(BuildContext context) {
    List<String?> types = [
      getTranslated('new_arrival', context),
      getTranslated('top_product', context),
      getTranslated('best_selling', context),
      getTranslated('discounted_product', context)
    ];

    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: SafeArea(
        child: RefreshIndicator(
          onRefresh: () async {
            await AsterThemeHomeScreen.loadData(true);
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
                  title: Image.asset(Images.logoWithNameImage, height: 35)),

              SliverToBoxAdapter(
                child: Provider.of<SplashController>(context, listen: false)
                            .configModel!
                            .announcement!
                            .status ==
                        '1'
                    ? Consumer<SplashController>(
                        builder: (context, announcement, _) {
                          return (announcement.configModel!.announcement!
                                          .announcement !=
                                      null &&
                                  announcement.onOff)
                              ? AnnouncementWidget(
                                  announcement:
                                      announcement.configModel!.announcement)
                              : const SizedBox();
                        },
                      )
                    : const SizedBox(),
              ),

              // Search Button
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

                    Consumer<FlashDealController>(
                        builder: (context, megaDeal, child) {
                      return megaDeal.flashDeal != null
                          ? megaDeal.flashDealList.isNotEmpty
                              ? Column(children: [
                                  Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal:
                                            Dimensions.paddingSizeDefault),
                                    child: TitleRowWidget(
                                        title: getTranslated(
                                            'flash_deal', context),
                                        eventDuration:
                                            megaDeal.flashDeal != null
                                                ? megaDeal.duration
                                                : null,
                                        onTap: () {
                                          Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                  builder: (_) =>
                                                      const FlashDealScreenView()));
                                        },
                                        isFlash: true),
                                  ),
                                  const SizedBox(
                                      height: Dimensions.paddingSizeSmall),
                                  Text(
                                      getTranslated(
                                              'hurry_up_the_offer_is_limited_grab_while_it_lasts',
                                              context) ??
                                          '',
                                      style: textRegular.copyWith(
                                          color: Provider.of<ThemeController>(
                                                      context,
                                                      listen: false)
                                                  .darkTheme
                                              ? Theme.of(context).hintColor
                                              : Theme.of(context).primaryColor,
                                          fontSize:
                                              Dimensions.fontSizeDefault)),
                                  const SizedBox(
                                      height: Dimensions.paddingSizeDefault),
                                  const Padding(
                                    padding: EdgeInsets.only(
                                        bottom: Dimensions.paddingSizeDefault),
                                    child: FlashDealsListWidget(),
                                  ),
                                ])
                              : const SizedBox.shrink()
                          : const FlashDealShimmer();
                    }),

                    // Find what you need
                    Consumer<ProductController>(
                        builder: (context, productController, _) {
                      return productController.findWhatYouNeedModel != null
                          ? (productController.findWhatYouNeedModel!
                                          .findWhatYouNeed !=
                                      null &&
                                  productController.findWhatYouNeedModel!
                                      .findWhatYouNeed!.isNotEmpty)
                              ? Column(children: [
                                  TitleRowWidget(
                                      title: getTranslated(
                                          'find_what_you_need', context)),
                                  const SizedBox(
                                      height: Dimensions.paddingSizeSmall),
                                  SizedBox(
                                      height: ResponsiveHelper.isTab(context)
                                          ? 165
                                          : 150,
                                      child: const FindWhatYouNeedView()),
                                  const SizedBox(
                                      height: Dimensions.paddingSizeDefault),
                                ])
                              : const SizedBox()
                          : const FindWhatYouNeedShimmer();
                    }),

                    //Order Again
                    (Provider.of<AuthController>(context, listen: false)
                            .isLoggedIn())
                        ? Consumer<OrderController>(
                            builder: (context, orderProvider, _) {
                            return orderProvider.deliveredOrderModel != null
                                ? (orderProvider.deliveredOrderModel!.orders !=
                                            null &&
                                        orderProvider.deliveredOrderModel!
                                            .orders!.isNotEmpty)
                                    ? const Padding(
                                        padding: EdgeInsets.symmetric(
                                            horizontal:
                                                Dimensions.paddingSizeDefault),
                                        child: OrderAgainView(),
                                      )
                                    : Consumer<BannerController>(builder:
                                        (context, bannerProvider, child) {
                                        return bannerProvider.sideBarBanner !=
                                                null
                                            ? Padding(
                                                padding: const EdgeInsets
                                                    .symmetric(
                                                    horizontal: Dimensions
                                                        .paddingSizeDefault),
                                                child: SingleBannersWidget(
                                                    bannerModel: bannerProvider
                                                        .sideBarBanner,
                                                    height:
                                                        MediaQuery.of(context)
                                                                .size
                                                                .width *
                                                            1.2),
                                              )
                                            : const SizedBox();
                                      })
                                : const OrderAgainShimmerShimmer();
                          })
                        : Consumer<BannerController>(
                            builder: (context, bannerProvider, child) {
                            return bannerProvider.sideBarBanner != null
                                ? Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal:
                                            Dimensions.paddingSizeDefault),
                                    child: SingleBannersWidget(
                                        bannerModel:
                                            bannerProvider.sideBarBanner,
                                        height:
                                            MediaQuery.of(context).size.width *
                                                1.2),
                                  )
                                : const SizedBox();
                          }),
                    const SizedBox(
                      height: Dimensions.paddingSizeDefault,
                    ),

                    //top seller
                    singleVendor
                        ? const SizedBox()
                        : Consumer<ShopController>(
                            builder: (context, shopController, _) {
                            return shopController.sellerModel != null
                                ? (shopController.sellerModel!.sellers !=
                                            null &&
                                        shopController
                                            .sellerModel!.sellers!.isNotEmpty)
                                    ? Column(children: [
                                        TitleRowWidget(
                                            title: getTranslated(
                                                'top_stores', context),
                                            onTap: () => Navigator.push(
                                                context,
                                                MaterialPageRoute(
                                                    builder: (_) =>
                                                        const AllTopSellerScreen(
                                                          title: 'top_stores',
                                                        )))),
                                        const SizedBox(
                                            height:
                                                Dimensions.paddingSizeSmall),
                                        SizedBox(
                                            height:
                                                ResponsiveHelper.isTab(context)
                                                    ? 180
                                                    : 165,
                                            child: TopSellerView(
                                              isHomePage: true,
                                              scrollController:
                                                  _scrollController,
                                            )),
                                        const SizedBox(
                                            height:
                                                Dimensions.paddingSizeDefault),
                                      ])
                                    : const SizedBox()
                                : const TopStoreShimmer();
                          }),

                    Consumer<FeaturedDealController>(
                      builder: (context, featuredDealProvider, child) {
                        return featuredDealProvider.featuredDealProductList !=
                                null
                            ? featuredDealProvider
                                    .featuredDealProductList!.isNotEmpty
                                ? Stack(children: [
                                    Container(
                                        width:
                                            MediaQuery.of(context).size.width,
                                        height: 150,
                                        color: Provider.of<ThemeController>(
                                                    context,
                                                    listen: false)
                                                .darkTheme
                                            ? Theme.of(context)
                                                .primaryColor
                                                .withOpacity(.20)
                                            : Theme.of(context)
                                                .primaryColor
                                                .withOpacity(.125)),
                                    Padding(
                                        padding: const EdgeInsets.only(
                                            bottom:
                                                Dimensions.paddingSizeDefault),
                                        child: Column(children: [
                                          Padding(
                                              padding:
                                                  const EdgeInsets.fromLTRB(
                                                      0,
                                                      Dimensions
                                                          .paddingSizeDefault,
                                                      0,
                                                      Dimensions
                                                          .paddingSizeDefault),
                                              child: TitleRowWidget(
                                                  title:
                                                      '${getTranslated('featured_deals', context)}',
                                                  onTap: () => Navigator.push(
                                                      context,
                                                      MaterialPageRoute(
                                                          builder: (_) =>
                                                              const FeaturedDealScreenView())))),
                                          const FeaturedDealsListWidget()
                                        ]))
                                  ])
                                : const SizedBox.shrink()
                            : const FindWhatYouNeedShimmer();
                      },
                    ),

                    const FooterBannerSliderWidget(),
                    const SizedBox(height: Dimensions.paddingSizeDefault),

                    const FeaturedProductWidget(),
                    const SizedBox(height: Dimensions.paddingSizeDefault),

                    Consumer<BannerController>(
                        builder: (context, bannerProvider, child) {
                      return bannerProvider.topSideBarBannerBottom != null
                          ? Padding(
                              padding: const EdgeInsets.only(
                                  bottom: Dimensions.paddingSizeDefault,
                                  left: Dimensions.bannerPadding,
                                  right: Dimensions.bannerPadding),
                              child: SingleBannersWidget(
                                  bannerModel:
                                      bannerProvider.topSideBarBannerBottom,
                                  height:
                                      MediaQuery.of(context).size.width * 1.2))
                          : const SizedBox();
                    }),

                    const Padding(
                        padding: EdgeInsets.only(
                            bottom: Dimensions.paddingSizeDefault),
                        child: RecommendedProductWidget(fromAsterTheme: true)),

                    const LatestProductListWidget(),
                    const SizedBox(height: Dimensions.paddingSizeDefault),

                    //blackFriday
                    Consumer<BannerController>(
                        builder: (context, bannerProvider, child) {
                      return bannerProvider.footerBannerList != null &&
                              bannerProvider.footerBannerList!.isNotEmpty
                          ? Padding(
                              padding: const EdgeInsets.only(
                                  bottom: Dimensions.paddingSizeDefault,
                                  left: Dimensions.paddingSizeDefault,
                                  right: Dimensions.paddingSizeDefault),
                              child: SingleBannersWidget(
                                  bannerModel:
                                      bannerProvider.footerBannerList![0],
                                  height:
                                      MediaQuery.of(context).size.width * 0.5))
                          : const SizedBox();
                    }),

                    SizedBox(child: Consumer<ProductController>(
                        builder: (context, productController, _) {
                      return (productController.justForYouProduct != null &&
                              productController.justForYouProduct!.isNotEmpty)
                          ? Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                  TitleRowWidget(
                                    title:
                                        getTranslated('just_for_you', context),
                                    onTap: () {
                                      Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (_) => AllProductScreen(
                                                  productType:
                                                      ProductType.justForYou)));
                                    },
                                  ),
                                  const SizedBox(
                                      height: Dimensions.paddingSizeSmall),
                                  JustForYouView(
                                      productList:
                                          productController.justForYouProduct)
                                ])
                          : const SizedBox();
                    })),
                    const SizedBox(height: Dimensions.paddingSizeDefault),

                    Consumer<ShopController>(
                        builder: (context, moreStoreProvider, _) {
                      return moreStoreProvider.moreStoreList.isNotEmpty
                          ? Column(children: [
                              TitleRowWidget(
                                title: getTranslated('more_store', context),
                                onTap: () => Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (_) => MoreStoreViewListView(
                                            title: getTranslated(
                                                'more_store', context)))),
                              ),
                              const SizedBox(
                                  height: Dimensions.paddingSizeSmall),
                              const MoreStoreView(isHome: true),
                              const SizedBox(
                                  height: Dimensions.paddingSizeDefault),
                            ])
                          : const SizedBox();
                    }),

                    const HomeCategoryProductWidget(isHomePage: true),
                    const SizedBox(height: Dimensions.paddingSizeDefault),

                    Consumer<BannerController>(
                        builder: (context, footerBannerProvider, child) {
                      return footerBannerProvider.mainSectionBanner != null
                          ? SingleBannersWidget(
                              bannerModel:
                                  footerBannerProvider.mainSectionBanner,
                              height: MediaQuery.of(context).size.width / 4,
                            )
                          : const SizedBox();
                    }),

                    Consumer<ProductController>(
                        builder: (ctx, prodProvider, child) {
                      return Padding(
                        padding: const EdgeInsets.fromLTRB(
                            Dimensions.paddingSizeDefault,
                            0,
                            Dimensions.paddingSizeSmall,
                            Dimensions.paddingSizeExtraSmall),
                        child: Row(children: [
                          Expanded(
                              child: Text(
                                  prodProvider.title == 'new_arrival'
                                      ? getTranslated('new_arrival', context)!
                                      : prodProvider.title!,
                                  style: titleHeader)),
                          prodProvider.latestProductList != null
                              ? PopupMenuButton(
                                  itemBuilder: (context) {
                                    return [
                                      PopupMenuItem(
                                        value: ProductType.newArrival,
                                        child: Text(
                                            getTranslated(
                                                'new_arrival', context)!,
                                            style: textRegular.copyWith(
                                              color: prodProvider.productType ==
                                                      ProductType.newArrival
                                                  ? Theme.of(context)
                                                      .primaryColor
                                                  : Theme.of(context)
                                                      .textTheme
                                                      .bodyLarge
                                                      ?.color,
                                            )),
                                      ),
                                      PopupMenuItem(
                                        value: ProductType.topProduct,
                                        child: Text(
                                            getTranslated(
                                                'top_product', context)!,
                                            style: textRegular.copyWith(
                                              color: prodProvider.productType ==
                                                      ProductType.topProduct
                                                  ? Theme.of(context)
                                                      .primaryColor
                                                  : Theme.of(context)
                                                      .textTheme
                                                      .bodyLarge
                                                      ?.color,
                                            )),
                                      ),
                                      PopupMenuItem(
                                        value: ProductType.bestSelling,
                                        child: Text(
                                            getTranslated(
                                                'best_selling', context)!,
                                            style: textRegular.copyWith(
                                              color: prodProvider.productType ==
                                                      ProductType.bestSelling
                                                  ? Theme.of(context)
                                                      .primaryColor
                                                  : Theme.of(context)
                                                      .textTheme
                                                      .bodyLarge
                                                      ?.color,
                                            )),
                                      ),
                                      PopupMenuItem(
                                        value: ProductType.discountedProduct,
                                        child: Text(
                                            getTranslated(
                                                'discounted_product', context)!,
                                            style: textRegular.copyWith(
                                              color: prodProvider.productType ==
                                                      ProductType
                                                          .discountedProduct
                                                  ? Theme.of(context)
                                                      .primaryColor
                                                  : Theme.of(context)
                                                      .textTheme
                                                      .bodyLarge
                                                      ?.color,
                                            )),
                                      ),
                                    ];
                                  },
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(
                                          Dimensions.paddingSizeSmall)),
                                  child: Padding(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal:
                                              Dimensions.paddingSizeSmall,
                                          vertical:
                                              Dimensions.paddingSizeSmall),
                                      child: Image.asset(Images.dropdown,
                                          scale: 3)),
                                  onSelected: (dynamic value) {
                                    if (value == ProductType.newArrival) {
                                      Provider.of<ProductController>(context,
                                              listen: false)
                                          .changeTypeOfProduct(value, types[0]);
                                    } else if (value ==
                                        ProductType.topProduct) {
                                      Provider.of<ProductController>(context,
                                              listen: false)
                                          .changeTypeOfProduct(value, types[1]);
                                    } else if (value ==
                                        ProductType.bestSelling) {
                                      Provider.of<ProductController>(context,
                                              listen: false)
                                          .changeTypeOfProduct(value, types[2]);
                                    } else if (value ==
                                        ProductType.discountedProduct) {
                                      Provider.of<ProductController>(context,
                                              listen: false)
                                          .changeTypeOfProduct(value, types[3]);
                                    }

                                    Provider.of<ProductController>(context,
                                            listen: false)
                                        .getLatestProductList(1, reload: true);
                                  },
                                )
                              : const SizedBox(),
                        ]),
                      );
                    }),

                    Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: Dimensions.paddingSizeSmall),
                        child: ProductListWidget(
                            isHomePage: false,
                            productType: ProductType.newArrival,
                            scrollController: _scrollController)),
                    const SizedBox(height: Dimensions.paddingSizeDefault),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
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
