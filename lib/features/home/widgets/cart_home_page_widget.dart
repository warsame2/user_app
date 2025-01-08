import 'package:flutter/material.dart';
import 'package:user_app/features/cart/controllers/cart_controller.dart';
import 'package:user_app/features/notification/controllers/notification_controller.dart';
import 'package:user_app/helper/responsive_helper.dart';
import 'package:user_app/utill/color_resources.dart';
import 'package:user_app/utill/custom_themes.dart';
import 'package:user_app/utill/dimensions.dart';
import 'package:user_app/utill/images.dart';
import 'package:user_app/features/cart/screens/cart_screen.dart';
import 'package:user_app/features/notification/screens/notification_screen.dart';
import 'package:provider/provider.dart';

class CartHomePageWidget extends StatelessWidget {
  const CartHomePageWidget({super.key});
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Consumer<NotificationController>(
            builder: (context, notificationProvider, _) {
          return IconButton(
              onPressed: () => Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (_) => const NotificationScreen())),
              icon: Stack(clipBehavior: Clip.none, children: [
                Image.asset(Images.notification,
                    height: Dimensions.iconSizeDefault,
                    width: Dimensions.iconSizeDefault,
                    color: ColorResources.getPrimary(context)),
                Positioned(
                    top: -4,
                    right: -4,
                    child: CircleAvatar(
                        radius: ResponsiveHelper.isTab(context) ? 10 : 7,
                        backgroundColor: ColorResources.red,
                        child: Text(
                            notificationProvider
                                    .notificationModel?.newNotificationItem
                                    .toString() ??
                                '0',
                            style: titilliumSemiBold.copyWith(
                                color: ColorResources.white,
                                fontSize: Dimensions.fontSizeExtraSmall))))
              ]));
        }),
        Padding(
          padding: const EdgeInsets.only(right: 12.0),
          child: IconButton(
            onPressed: () => Navigator.push(
                context, MaterialPageRoute(builder: (_) => const CartScreen())),
            icon: Stack(clipBehavior: Clip.none, children: [
              Image.asset(Images.cartArrowDownImage,
                  height: Dimensions.iconSizeDefault,
                  width: Dimensions.iconSizeDefault,
                  color: ColorResources.getPrimary(context)),
              Positioned(
                  top: -4,
                  right: -4,
                  child:
                      Consumer<CartController>(builder: (context, cart, child) {
                    return CircleAvatar(
                        radius: ResponsiveHelper.isTab(context) ? 10 : 7,
                        backgroundColor: ColorResources.red,
                        child: Text(cart.cartList.length.toString(),
                            style: titilliumSemiBold.copyWith(
                                color: ColorResources.white,
                                fontSize: Dimensions.fontSizeExtraSmall)));
                  })),
            ]),
          ),
        ),
      ],
    );
  }
}
