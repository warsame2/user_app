import 'package:flutter/material.dart';
import 'package:user_app/features/shop/controllers/shop_controller.dart';
import 'package:user_app/localization/language_constrants.dart';
import 'package:user_app/utill/color_resources.dart';
import 'package:user_app/utill/custom_themes.dart';
import 'package:user_app/utill/dimensions.dart';
import 'package:user_app/common/basewidget/custom_app_bar_widget.dart';
import 'package:user_app/features/shop/widgets/top_seller_view.dart';
import 'package:user_app/utill/images.dart';
import 'package:provider/provider.dart';

class AllTopSellerScreen extends StatefulWidget {
  final String title;
  const AllTopSellerScreen({super.key, required this.title});

  @override
  State<AllTopSellerScreen> createState() => _AllTopSellerScreenState();
}

class _AllTopSellerScreenState extends State<AllTopSellerScreen> {
  ScrollController scrollController = ScrollController();
  @override
  Widget build(BuildContext context) {
    return Consumer<ShopController>(builder: (context, shopController, _) {
      return Scaffold(
          backgroundColor: ColorResources.getIconBg(context),
          appBar: CustomAppBar(
            title: '${getTranslated(shopController.sellerTypeTitle, context)}',
            showResetIcon: true,
            reset:
                Consumer<ShopController>(builder: (context, shopController, _) {
              return Padding(
                padding: const EdgeInsets.symmetric(
                    horizontal: Dimensions.paddingSizeLarge),
                child: PopupMenuButton(
                    itemBuilder: (context) {
                      return [
                        PopupMenuItem(
                            value: "new",
                            textStyle: textRegular.copyWith(
                                color: Theme.of(context).hintColor),
                            child: Text(
                                getTranslated('new_seller', context) ?? '')),
                        PopupMenuItem(
                            value: "all",
                            textStyle: textRegular.copyWith(
                                color: Theme.of(context).hintColor),
                            child: Text(
                                getTranslated('all_seller', context) ?? '')),
                        PopupMenuItem(
                            value: "top",
                            textStyle: textRegular.copyWith(
                                color: Theme.of(context).hintColor),
                            child: Text(
                                getTranslated('top_seller', context) ?? '')),
                      ];
                    },
                    shape: RoundedRectangleBorder(
                        borderRadius:
                            BorderRadius.circular(Dimensions.paddingSizeSmall)),
                    child: Padding(
                        padding: const EdgeInsets.fromLTRB(
                            Dimensions.paddingSizeExtraSmall,
                            Dimensions.paddingSizeSmall,
                            Dimensions.paddingSizeExtraSmall,
                            Dimensions.paddingSizeSmall),
                        child: Image.asset(Images.dropdown, scale: 3)),
                    onSelected: (dynamic value) {
                      shopController.setSellerType(value, notify: true);
                    }),
              );
            }),
          ),
          body: Padding(
              padding: const EdgeInsets.all(Dimensions.paddingSizeSmall),
              child: TopSellerView(
                isHomePage: false,
                scrollController: scrollController,
              )));
    });
  }
}
